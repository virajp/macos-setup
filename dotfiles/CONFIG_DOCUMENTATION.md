# Configuration Documentation

This document explains the less-obvious settings and customizations in the
dotfiles configuration. `dotfiles/` mirrors `$HOME`: every file sits at the path
it is linked to, and each topic's `[dotfiles]` table in
`.config/mise/conf.d/<topic>.toml` symlinks it into place (see
[`readme.md`](./readme.md)).

## Directory Structure

| Path                                        | What it configures                                                        |
| ------------------------------------------- | ------------------------------------------------------------------------- |
| `.config/fish/`                             | Fish shell — the default interactive shell (`conf.d/*.fish`)              |
| `.zshenv`, `.zshrc`, `.config/zsh/`         | Zsh configuration (fallback shell); `.zshrc` sources `.config/zsh/*.zsh`  |
| `.config/starship.toml`                     | Starship prompt (the active prompt, initialised from fish)                |
| `.config/ghostty/`                          | Ghostty terminal configuration                                            |
| `.config/brewfile`                          | VS Code extensions and the `1password` cask (not linked, see below)       |
| `.config/git/`                              | Git config, ignore, `identity`, GitHub/GitLab includes, `allowed_signers` |
| `.ssh/`                                     | SSH client config and `config.identity` (see below)                       |
| `.config/fnox/`                             | Secret management via the macOS Keychain (see below)                      |
| `.config/mise/`                             | Global `mise` config, the machine declaration (`conf.d/`) and tasks       |
| `.config/dprint.json`, `.config/taplo.toml` | `dprint` / `taplo` formatter configuration                                |
| `.gemrc`                                    | RubyGems configuration                                                    |
| `.config/1Password/`                        | 1Password SSH agent configuration                                         |
| `.claude/`                                  | Claude Code (`CLAUDE.md`, `settings.json`, `output-styles/`)              |
| `.github/`                                  | GitHub Copilot commit-message guidelines                                  |

Files written by `mise bootstrap` from inline content rather than linked:
`~/.config/gh/config.yml` (`git.toml`), `~/Library/Preferences/pnpm/config.yaml`
(`node.toml`), `~/.config/mempalace/docker-compose.yaml` (`mempalace.toml`) and
`/etc/pam.d/sudo_local` (`shell.toml`).

## Shells & Prompt

The default interactive shell is **fish**; `zsh` is kept in sync as a fallback.
`mise bootstrap` makes fish the login shell (`[bootstrap.user]` in `shell.toml`)
and adds the Homebrew shells to `/etc/shells` (see
[`docs/shell.md`](../docs/shell.md)).

Interactive shells get a full `mise activate`; non-interactive shells get
`--shims`. In fish that is the if/else in `conf.d/51-mise.fish`, and it
activates exactly once — `51-mise.fish` sets `MISE_FISH_AUTO_ACTIVATE=0` to
suppress Homebrew's vendor snippet. For bash and zsh the profile lines are
declared in `[bootstrap.mise_shell_activate]` (`shell.toml`).

zsh needs two files, because `.zshrc` is interactive-only: `.zshenv` loads shims
unconditionally and `.zshrc` (via `.config/zsh/01-initialisers.zsh`) adds the
full activate on top for interactive shells. The shims load is **not** redundant
for interactive shells. zsh's `brew shellenv` runs `/usr/libexec/path_helper`
(the fish variant does not), which rebuilds `PATH` and leaves mise-managed
binaries unresolvable until the full activate runs.

`mise` must activate **after** `brew shellenv` in both shells. mise wins
precedence by prepending to `PATH`, so anything that touches `PATH` afterwards
takes it back — and tools present in both Homebrew and mise (`jq`, `yq`) would
silently resolve to the Homebrew copy.

### Fish loading sequence

1. `conf.d/*.fish` — sorted by filename across **all** conf.d directories,
   including Homebrew's `vendor_conf.d`
2. `config.fish` — main configuration

Homebrew's `mise` formula ships `vendor_conf.d/mise-activate.fish`, which sorts
after `51-mise.fish` and would re-run a full `mise activate`, overriding the
shims branch. `51-mise.fish` sets `MISE_FISH_AUTO_ACTIVATE=0` to suppress it.

`fish_add_path` defaults to **universal** scope, which persists in
`~/.config/fish/fish_variables` independently of any config file — so removing a
`fish_add_path` line does not remove the path. `02-path.fish` therefore passes
`--global`, which is rebuilt every startup and cannot accumulate stale entries.
If a universal `fish_user_paths` ever reappears, clear it with
`set --erase --universal fish_user_paths`.

### Prompt

**Starship** is the active prompt (`06-prompt.fish` calls `starship init`). An
`oh-my-posh init` block is left commented out in `06-prompt.fish`; its themes
are no longer in this repo.

## Secret Management (fnox)

Secrets are stored in the **macOS Keychain** and read by
[`fnox`](https://github.com/jdx/fnox); `.config/fnox/config.toml` maps them.
There is no plaintext secret file in this repo, and **nothing is exported to the
shell** (`env = false`): neither shell runs `fnox activate` and mise's `[env]`
carries no secrets. Each consumer is handed exactly the secrets its profile
holds:

| Consumer                 | How                                                                                |
| ------------------------ | ---------------------------------------------------------------------------------- |
| `brew` (GitHub API)      | `brew` shell alias → `fnox exec -P brew -- brew` (`system.toml`, `upgrade:brew`)   |
| Context7 MCP in Claude   | `CONTEXT7_RUNNER="fnox exec -P context7 -- pnpm dlx"` in `.claude/settings.json`   |
| mempalace (Hugging Face) | `mp` shell alias → `fnox exec --profile mempalace -- mempalace` (`mempalace.toml`) |

Each profile holds only `env = "exec"` secrets, so `fnox exec -P <profile>`
injects only those variables into the child process. `brew` invoked by mise
itself (`mise bootstrap packages …`) bypasses the alias and runs
unauthenticated, which only matters for GitHub rate limits. mise's own GitHub
API calls use `[settings.github] use_git_credentials`.

## Tooling via mise

`.config/mise/config.toml` holds global settings (including the `[dotfiles]`
settings, see **Link map**); everything else is split by topic across
`conf.d/*.toml`, each carrying its topic's `[tools]`, `[env]`, `[settings]` and
`[shell_alias]`. `node.toml` sets `pnpm` as the npm package manager;
`python.toml` installs `pipx:*` tools with `uvx` (`pipx.uvx = true`). Most
`[shell_alias]` shortcuts live in `utils.toml` — including `updateall`,
`osx-upgrade`, IP helpers (`ipv4`, `gateway`, …), and cleanup tasks. The task
scripts themselves live under `.config/mise/tasks/`.

mise is the single source of truth for **environment variables, aliases and
shell functions**. Neither shell defines its own — there is no `aliases.sh` or
`functions.sh`, and fish's `conf.d` carries only bootstrap variables. Some names
differ from their old shell equivalents: `ips4` is now `ipv4`, `ips6` is `ipv6`,
and `list-services` is `listServices`.

**`PATH` stays in shell config** (`fish/conf.d/02-path.fish`,
`.config/zsh/03-path.zsh`). mise prepends `[env] _.path` entries *ahead* of its
own tool paths, so declaring a directory there shadows mise-managed tools with
any copy living in it — `~/.local/bin` holds a standalone `uv` and `uvx`, and
Homebrew's `bin` holds `jq` and `yq`. Keeping `PATH` in shell config, with
`mise activate` running last, is what makes the mise-managed copies win. The one
`_.path` entry is `$PNPM_HOME/bin` (`node.toml`), which holds only pnpm globals.

## AI tools

Claude Code's config lives in `.claude/` (linked by `claude.toml`):
`settings.json`, the global `CLAUDE.md` and `output-styles/`.

The `cc*` aliases all run one global task, `func:claude`
(`.config/mise/tasks/func/claude`): `cc` with the default model,
`ccf`/`cco`/`ccs`/`cch` pinned to Fable, Opus, Sonnet and Haiku. It starts
`claude --remote-control --effort high` with the session named after the current
folder, or `<folder>-<name>` when a bare first argument is given — `cc review`
in `macos-setup/` is the session `macos-setup-review`. Only `--model` is parsed
by the task (it is the flag the aliases put before the name); every other
argument passes through to `claude`, so `cc review --continue` and
`cc --continue` both work, and a later `--effort` overrides the default.

## mempalace (MCP memory server)

`mempalace.toml` declares everything: the `docker compose` file for mempalace's
qdrant backend (written to `~/.config/mempalace/`, `127.0.0.1:6333`, data
bind-mounted from `~/.local/share/qdrant`), which `mise bootstrap` keeps running
(`[bootstrap.compose.mempalace]`); the `mempalace-hub` user service
(`[bootstrap.services.mempalace-hub]`, `mempalace serve`); the `pipx:mempalace`
tool; and the `MEMPALACE_*` `[env]` (palace data in `~/.local/share/mempalace`).
`project_dir` has to be a literal absolute path (mise expands neither `~`,
`$HOME` nor templates there), so it holds the username. `mempalace:*` mise tasks
(`.config/mise/tasks/mempalace/`) wrap the compose lifecycle; `mempalace:update`
pulls the qdrant image weekly from `updateall`. See
[`docs/mempalace.md`](../docs/mempalace.md) for one-time setup.

## Git

`.config/git/config` always includes `identity`, which holds the `[user]`
identity (name, email, signing key) and includes the host-specific configs
conditionally (`github.config`, `gitlab.config`). The global ignore file is
`.config/git/ignore`, and commit signatures are verified against
`.config/git/allowed_signers`.

`push.default` is `current`, and the push aliases (`p` in the git config, `gp`
in mise) push only the current branch — never `--all`. With public repos, a
`--all` push would publish every local scratch branch, whatever it carries.

## SSH & GitHub CLI

`.ssh/config` verifies host keys (`StrictHostKeyChecking accept-new`: first
contact is recorded in `~/.ssh/known_hosts`, a changed key is refused) and uses
the 1Password SSH agent. It includes `~/.ssh/config.local` for machine-local
hosts — LAN boxes, per-host auth overrides — which is untracked on purpose,
since this repo is public. A missing include is ignored by ssh. The default
`User` sits in `.ssh/config.identity`, included as the first line of `Host *`.
`~/.ssh` is linked `symlink-each`, so ssh and the 1Password agent can write
sibling files there without them landing in the repo.

`~/.config/gh/config.yml` is written by `mise bootstrap` from `git.toml`.
`hosts.yml` is machine state `gh auth login` writes, and while macOS `gh` keeps
the token in the Keychain by default, `--insecure-storage` or a Keychain failure
writes it into the file — so it is never tracked here.

## Machine declaration (`.config/mise/conf.d/`)

`.config/mise/` is the global mise config (linked to `~/.config/mise`), so
`mise bootstrap` applies `conf.d/*.toml` from any directory, in
[mise's phase order](https://mise.jdx.dev/bootstrap.html). Each file is one
topic:

- `[bootstrap.packages]` (every topic file) — Homebrew formulae (`brew:`), casks
  (`brew-cask:`) and Mac App Store apps (`mas:<adam id>`). mise pours the same
  bottles brew would into the shared `/opt/homebrew` Cellar without calling
  `brew`; `brew list`/`upgrade` still see them. Casks land in `~/Applications`
  (`MISE_BREW_CASK_OPT_APPDIR` in `config.toml`). Third-party tap formulae work
  only when the tap publishes `api/formula/<name>.json` (`virajp/tap`, declared
  in `claude.toml`, does). Ownership rule: formulae, casks and mas → mise,
  versioned dev tools → `[tools]`. `tailscaled` must run as root (utun) and mise
  has no privileged services on macOS, so the `tailscale:daemon` task (run by
  `updateall`) starts it with `sudo brew services`, and `upgrade:tailscale`
  hands the root-owned keg back before `packages upgrade` can replace it. (The
  App Store build is sandboxed and cannot run the Tailscale SSH server.)
- `shell.toml` — fish as login shell (`[bootstrap.user]`), Touch ID for sudo
  (`[bootstrap.files."/etc/pam.d/sudo_local"]`), Homebrew's bash, fish and zsh
  in `/etc/shells` (`[dotfiles]` `line` entries), and the shell links.
- `macos-defaults.toml` — `[bootstrap.macos.defaults]`, one table per domain.
  mise never restarts apps, so the `post-defaults` hook does the `killall`s (and
  `chflags nohidden ~/Library`, and the one `$HOME`-dependent Finder key, since
  defaults values are not templated).
- `mempalace.toml` — the qdrant compose project and the `mempalace-hub` service
  (see **mempalace**).
- `claude.toml` — the `virajp/tap` and `stablyai/orca` taps, `claude-status`
  (the Claude Code status line), the Claude casks and the `~/.claude` links.
- `git.toml`, `node.toml` — the gh and pnpm config files.
- `devtools.toml`, `python.toml`, `1password.toml`, `starship.toml`,
  `fonts.toml`, `utils.toml`, `extras.toml`, `env.toml`, `system.toml` — tools,
  packages, env, aliases and links for their topic.

The `pmset`/`nvram` power profile is the `upgrade:power` task; mise has no
declaration for it.

`updateall` runs `upgrade:brew` and
`mise bootstrap --skip macos-defaults,packages` every time, and once a week — a
stamp in `/tmp`, so a reboot (every macOS update has one) resets the week;
`updateall --force` runs it now — pulls the qdrant image, re-applies the macOS
defaults and runs `upgrade:power`.

### Link map

Only paths listed in a `[dotfiles]` table are symlinked, so repo metadata is
never linked by accident. Sources resolve against `dotfiles.root` in
`config.toml` (this directory), at the same path as the target.
`mode =
"symlink"` (the default) links the source itself;
`mode = "symlink-each"` links each entry inside the source directory
individually (used for `~/.ssh`). `line`/`block` entries add a line or a managed
block to a file instead of linking it (`/etc/shells`, `~/.zprofile`).
`.config/brewfile`'s entry in `system.toml` is commented out.
