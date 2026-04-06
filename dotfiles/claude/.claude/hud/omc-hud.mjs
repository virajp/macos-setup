#!/usr/bin/env node
/**
 * OMC HUD - Statusline Script
 * Wrapper that imports from dev paths, plugin cache, or npm package
 */

import { execFileSync } from "node:child_process";
import { existsSync, readdirSync } from "node:fs";
import { createRequire } from "node:module";
import { homedir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { pathToFileURL } from "node:url";

function uniquePaths(paths) {
  return [...new Set(paths.filter(Boolean).map((candidate) => resolve(candidate)))];
}

function getGlobalNodeModuleRoots() {
  const roots = [];
  const addPrefixRoots = (prefix) => {
    if (!prefix) return;
    if (process.platform === "win32") {
      roots.push(join(prefix, "node_modules"));
      return;
    }
    roots.push(join(prefix, "lib", "node_modules"));
    roots.push(join(prefix, "node_modules"));
  };

  addPrefixRoots(process.env.npm_config_prefix);
  addPrefixRoots(process.env.PREFIX);

  const nodeBinDir = dirname(process.execPath);
  roots.push(join(nodeBinDir, "node_modules"));
  roots.push(join(nodeBinDir, "..", "node_modules"));
  roots.push(join(nodeBinDir, "..", "lib", "node_modules"));

  if (process.platform === "win32" && process.env.APPDATA) {
    roots.push(join(process.env.APPDATA, "npm", "node_modules"));
  }

  try {
    const npmCommand = process.platform === "win32" ? "npm.cmd" : "npm";
    const npmRoot = String(execFileSync(npmCommand, ["root", "-g"], {
      encoding: "utf8",
      stdio: ["ignore", "pipe", "ignore"],
      timeout: 1500,
    })).trim();
    if (npmRoot) roots.unshift(npmRoot);
  } catch { /* continue */ }

  return uniquePaths(roots);
}

async function importHudPackage(hudPackage) {
  try {
    const wrapperRequire = createRequire(import.meta.url);
    const resolvedHudPath = wrapperRequire.resolve(hudPackage);
    await import(pathToFileURL(resolvedHudPath).href);
    return true;
  } catch { /* continue */ }

  try {
    const cwdRequire = createRequire(join(process.cwd(), "__omc_hud__.cjs"));
    const resolvedHudPath = cwdRequire.resolve(hudPackage);
    await import(pathToFileURL(resolvedHudPath).href);
    return true;
  } catch { /* continue */ }

  for (const nodeModulesRoot of getGlobalNodeModuleRoots()) {
    const resolvedHudPath = join(nodeModulesRoot, hudPackage);
    if (!existsSync(resolvedHudPath)) continue;
    try {
      await import(pathToFileURL(resolvedHudPath).href);
      return true;
    } catch { /* continue */ }
  }

  return false;
}

async function main() {
  const home = homedir();
  let pluginCacheVersion = null;
  let pluginCacheDir = null;
  
  // 1. Development paths (only when OMC_DEV=1)
  if (process.env.OMC_DEV === "1") {
    const devPaths = [
      join(home, "Workspace/oh-my-claudecode/dist/hud/index.js"),
      join(home, "workspace/oh-my-claudecode/dist/hud/index.js"),
      join(home, "projects/oh-my-claudecode/dist/hud/index.js"),
    ];
    
    for (const devPath of devPaths) {
      if (existsSync(devPath)) {
        try {
          await import(pathToFileURL(devPath).href);
          return;
        } catch { /* continue */ }
      }
    }
  }
  
  // 2. Plugin cache (for production installs)
  // Respect CLAUDE_CONFIG_DIR so installs under a custom config dir are found
  const configDir = process.env.CLAUDE_CONFIG_DIR || join(home, ".claude");
  const pluginCacheBase = join(configDir, "plugins", "cache", "omc", "oh-my-claudecode");
  if (existsSync(pluginCacheBase)) {
    try {
      const versions = readdirSync(pluginCacheBase);
      if (versions.length > 0) {
        const sortedVersions = versions.sort((a, b) => a.localeCompare(b, undefined, { numeric: true })).reverse();
        const latestInstalledVersion = sortedVersions[0];
        pluginCacheVersion = latestInstalledVersion;
        pluginCacheDir = join(pluginCacheBase, latestInstalledVersion);
        
        // Filter to only versions with built dist/hud/index.js
        // This prevents picking an unbuilt new version after plugin update
        const builtVersions = sortedVersions.filter(version => {
          const pluginPath = join(pluginCacheBase, version, "dist/hud/index.js");
          return existsSync(pluginPath);
        });
        
        if (builtVersions.length > 0) {
          const latestVersion = builtVersions[0];
          pluginCacheVersion = latestVersion;
          pluginCacheDir = join(pluginCacheBase, latestVersion);
          const pluginPath = join(pluginCacheDir, "dist/hud/index.js");
          await import(pathToFileURL(pluginPath).href);
          return;
        }
      }
    } catch { /* continue */ }
  }
  
  // 3. Marketplace clone (for marketplace installs without a populated cache)
  const marketplaceHudPath = join(configDir, "plugins", "marketplaces", "omc", "dist/hud/index.js");
  if (existsSync(marketplaceHudPath)) {
    try {
      await import(pathToFileURL(marketplaceHudPath).href);
      return;
    } catch { /* continue */ }
  }
  
  // 4. npm package (current project, global install, or branded fallback)
  const npmHudPackages = [
    "oh-my-claude-sisyphus/dist/hud/index.js",
    "oh-my-claudecode/dist/hud/index.js",
  ];
  for (const hudPackage of npmHudPackages) {
    if (await importHudPackage(hudPackage)) {
      return;
    }
  }
  
  // 5. Fallback: provide detailed error message with fix instructions
  if (pluginCacheDir && existsSync(pluginCacheDir)) {
    // Plugin exists but HUD could not be loaded
    const distDir = join(pluginCacheDir, "dist");
    if (!existsSync(distDir)) {
      console.log(`[OMC HUD] Plugin installed but not built. Run: cd "${pluginCacheDir}" && npm install && npm run build`);
    } else {
      console.log(`[OMC HUD] Plugin HUD load failed. Run: cd "${pluginCacheDir}" && npm install && npm run build`);
    }
  } else if (existsSync(pluginCacheBase)) {
    // Plugin cache directory exists but no versions
    console.log(`[OMC HUD] Plugin cache found but no versions installed. Run: /oh-my-claudecode:omc-setup`);
  } else {
    // No plugin installation found at all
    console.log("[OMC HUD] Plugin not installed. Run: /oh-my-claudecode:omc-setup");
  }
}

main();