# sync.md

Instructions for **Claude Code** to adopt the shape of
[`virajp/macos-setup`](https://github.com/virajp/macos-setup) into your own
macOS setup repo, or to sync later upstream changes into it, while keeping your
own software and identity.

Start it with a single prompt in Claude Code:

```text
Follow https://raw.githubusercontent.com/virajp/macos-setup/main/sync.md
Follow https://raw.githubusercontent.com/virajp/macos-setup/main/sync.md for fish
```

The second form limits the run to one piece of software (see
[Scoped run](#8-scoped-run-for-app)).

---

The rest of this file is addressed to the agent running it.

## Hard rules

- **Ask, never assume.** Use `AskUserQuestion` for every decision this file does
  not settle. When a step says "ask", ask before acting.
- **macOS on Apple Silicon only.** Stop if `uname -s` is not `Darwin` or
  `uname -m` is not `arm64`.
- **Write only inside the user's setup repo** and the temp folder, except for
  the mise install (step 3) and the final apply (step 11), each behind its own
  consent.
- **Never copy upstream's personal values** — the owner's identity, packages,
  paths and projects (see [What comes over](#6-what-comes-over)).
- **Never commit or push without asking.** Show the diff first. Never push at
  all; the user pushes.
- **Compare against upstream's current state** on every run. Do not record a
  last-synced commit and do not read upstream's git history — only what the tree
  looks like now matters.

## 1. Preflight

1. Check `uname -s` is `Darwin`.
2. Check `uname -m` is `arm64`. The setup assumes Apple Silicon's Homebrew
   prefix `/opt/homebrew` (login shell, `/etc/shells`, fish env, `setup`); on an
   Intel Mac, stop and tell the user.
3. Read the prompt: no `for <app>` means a full run; `for <app>` means a scoped
   run (step 8). Confirm the scope with the user.

## 2. Clone upstream into a temp folder

```shell
UPSTREAM="$(mktemp -d)/macos-setup"
git clone --depth 1 https://github.com/virajp/macos-setup.git "$UPSTREAM"
```

Read upstream from `$UPSTREAM` only. Delete the temp folder at the end (step
12), whatever the outcome.

## 3. mise

This setup is driven by [mise](https://mise.jdx.dev/), and mise must be
installed with its own installer (`~/.local/bin/mise`), never Homebrew or any
other method.

1. Find every mise on the machine: `which -a mise`, and check
   `~/.local/bin/mise`.
2. **Only `~/.local/bin/mise`:** nothing to do. Continue.
3. **None:** ask for consent, then install:

   ```shell
   curl https://mise.run | sh
   ```

4. **Installed another way** (e.g. `/opt/homebrew/bin/mise` from Homebrew, or
   cargo, MacPorts, Nix): tell the user what was found and ask for consent to
   replace it. Then uninstall it with that method (e.g. `brew uninstall mise`)
   and install with `curl https://mise.run | sh`. **Keep all mise data** — do
   not delete `~/.config/mise`, `~/.local/share/mise`, `~/.local/state/mise` or
   `~/.cache/mise`.
5. Verify: `~/.local/bin/mise --version`. If `~/.local/bin` is not on `PATH`,
   use the full path for the rest of the run and tell the user.
6. Compare that version with `min_version` in upstream's
   `dotfiles/.config/mise/config.toml`. If theirs is older, ask for consent and
   run `mise self-update`: the bootstrap features this setup uses (compose,
   templates, macOS defaults) need a recent mise.

If the user declines, stop: nothing below works without mise.

## 4. Find the user's setup repo

Ask where their setup repo is.

- **They have one:** use it. If it has uncommitted changes, ask whether to
  continue.
- **They have none:** scaffold one.
  1. Ask for their GitHub username and the repo name (default `macos-setup`).
     Create it at `~/Projects/github.com/<user>/<repo>` and `git init` it,
     unless they pick another path.
  2. Copy upstream's structure into it (step 6 decides what comes over).
  3. Fill the package lists from **their machine**, not upstream's:
     - `brew leaves` → `"brew:<formula>"`
     - `brew list --cask` → `"brew-cask:<cask>"`
     - `mas list` → `"mas:<id>"` (if `mas` is installed)
     - `mise ls --global --current` → `[tools]`

     Place each entry in the `conf.d/<topic>.toml` whose topic fits it (list
     upstream's `conf.d/` for the current topics — e.g. `shell`, `terminal`,
     `cli`, `network`, `git`, `containers`, `security`, `devtools`, `node`,
     `python`, `system`). Put leftover formulae in `cli.toml` and leftover apps
     in `macos-apps.toml`. A versioned dev tool found as a formula (`node`,
     `python`, `go`, `terraform`, …) belongs in `[tools]`, not `brew:` — suggest
     moving it. Show the placement and let the user move or drop entries.
  4. For every upstream `[dotfiles]` target that already exists in their `$HOME`
     as a real file (e.g. `~/.config/fish/config.fish`,
     `~/.config/starship.toml`), copy **their** file into the mirror path under
     `dotfiles/` instead of upstream's. Ask per file when both exist and differ.
  5. Pushing the new repo to GitHub is up to them.

Below, `$REPO` is the user's repo.

## 5. Identity

Personal values live only in `[vars]` of
`$REPO/dotfiles/.config/mise/conf.d/identity.toml`. The identity files are mise
templates (`mode = "template"`, original file names) rendered from these vars:
`.config/git/identity`, `.config/git/github.config`,
`.config/git/gitlab.config`, `.config/git/allowed_signers`,
`.ssh/config.identity`, `.config/1Password/ssh/agent.toml`. The same vars feed
`PROJECTS_DIR` (`conf.d/cli.toml`) and the pnpm and gh config files
(`template = true` in `conf.d/node.toml` and `conf.d/git.toml`). `[vars]` values
must be strings.

- If `identity.toml` exists, keep it and ask only for vars upstream added since.
- Otherwise ask for each value and write the file:

  | Var                        | Ask for                                                                                                |
  | -------------------------- | ------------------------------------------------------------------------------------------------------ |
  | `name`                     | Git author name                                                                                        |
  | `github_email`             | GitHub commit email (suggest their `…@users.noreply.github.com`)                                       |
  | `gitlab_email`             | GitLab commit email (ask if they use GitLab at all)                                                    |
  | `signing_key`              | SSH public key for commit signing (ask if they sign commits)                                           |
  | `ssh_user`                 | Default SSH user                                                                                       |
  | `projects_dir`             | Folder holding `github.com/<user>/<repo>` (default `~/Projects`)                                       |
  | `editor`                   | Command gh opens for issues and PRs (e.g. `code`, `vim`)                                               |
  | `op_ssh_vault`             | 1Password vault holding their SSH keys (default `Private`)                                             |
  | `pnpm_release_age_exclude` | Package patterns exempt from pnpm's release-age cooldown, space-separated (their own scopes, or empty) |

- If they don't use GitLab, drop `gitlab.config`, its `includeIf` blocks in
  `identity`, its `allowed_signers` line and its `[dotfiles]` entry — ask first.
  If they don't sign commits, ask how to handle the signing settings in
  `.config/git/config` (`gpgsign`, `gpg.format`, `gpg "ssh"`).
- Take the template files themselves from upstream; they hold no personal
  values.

## 6. What comes over

Compare every upstream file with the user's copy and sort each difference into
one of these groups.

### Structure — take upstream

The shape of the setup: the `dotfiles/` `$HOME` mirror, `setup`, the task
scripts in `.config/mise/tasks/` and `dotfiles/.config/mise/tasks/`, the split
of `conf.d/*.toml` into topics, `[settings]`, `[env]`, `[shell_alias]`,
`[bootstrap.*]` declarations other than packages, `[dotfiles]` entries, shell
config (`.config/fish/`, `.zshenv`, `.zshrc`, `.config/zsh/`), formatter and
lint config, `.gitignore`, `LICENSE`, `readme.md`, `CLAUDE.md`, and `docs/`
(apart from what is excluded below).

Where an upstream setting assumes an app the user doesn't have (e.g.
`CHROME_EXECUTABLE` → Brave, `edit` → Sublime Text, `code` as the git editor in
`.config/git/config`, the GCP env), ask: keep it, point it at their app, or drop
it.

**Merge, don't overwrite.** "Take upstream" applies key by key, never file by
file — on a re-sync the user's structure files carry their own additions:

- A key only the user has (their own alias, env var, `[dotfiles]` entry, a line
  in a shell config): keep it. Upstream may have removed it, but without
  upstream's history that looks the same as the user's own addition, so list
  every such key in the summary and let the user drop stale ones.
- A key upstream has and the user's copy doesn't: add it, unless it belongs to
  something they opted out of in this run. The user may have deleted it on
  purpose, so the diff in step 10 shows each addition.
- A key both have with different values: show both and ask.

**Task scripts are compared file by file.** A task in `.config/mise/tasks/` or
`dotfiles/.config/mise/tasks/` is a whole script with no keys, so match it by
path:

- A task only the user has: keep it, and list it in the summary — like a key, it
  may be one upstream removed.
- A task only upstream has: add it, unless it belongs to something they opted
  out of.
- A task both have, identical: nothing to do.
- A task both have, different: show the diff and ask — take upstream's, keep
  theirs, or merge. For a merge, write one version with upstream's changes and
  the user's additions, and show it before writing.
- A user task with no upstream counterpart that closely matches an upstream task
  under another path: ask whether upstream renamed it, and move it if so.

**Follow keys, not file names.** When upstream moves keys to another file (e.g.
`utils.toml` split into `cli.toml`, `network.toml`, `macos-apps.toml` and
`system.toml`), match each of the user's keys to where upstream keeps it now and
move it there — packages and tools included. Create files upstream added, and
delete a file upstream removed once everything in it has moved. Ask where to put
a key with no upstream counterpart.

### The user's software — keep theirs

Never copy upstream's package or tool choices:

- entries in `[bootstrap.packages]` (`brew:`, `brew-cask:`, `mas:`)
- entries in `[tools]` and their versions
- `dotfiles/.config/brewfile`

Keep their entries, even when upstream moves the same kind of entry to another
topic file — then move theirs the same way. The exception is a tool the
structure itself needs to run (e.g. `fnox`, `usage`, `dprint`, `taplo`,
`pre-commit`): when upstream adds or requires one, ask whether to add it.

### Keep-theirs lines

These lines hold machine paths or usernames that mise cannot template. Write the
user's value on the first run and never overwrite it afterwards:

| Line                                                            | Their value                                                                |
| --------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `dotfiles.root` in `dotfiles/.config/mise/config.toml`          | `<their repo path>/dotfiles`, `~`-relative                                 |
| `project_dir` in `conf.d/mempalace.toml` (if mempalace adopted) | their absolute `$HOME` + `/.config/mempalace` ¹                            |
| `GITHUB_USER` default, raw URL and `Author` in `setup`          | their username and name                                                    |
| `REPO_NAME` and `PROJECTS_DIR` defaults in `setup`              | their repo name and projects folder, so `REPO_DIR` matches `dotfiles.root` |
| `"Projects/github.com"` substitution in `.config/starship.toml` | their `projects_dir` + `/github.com`, relative to `~`                      |
| URLs in `.config/git-conventional-commits.yaml`                 | their repo                                                                 |
| Clone path and `curl` URL in `docs/setup.md`                    | their username and repo                                                    |
| Hostname in `docs/host.md`                                      | ask for their computer name, or leave the placeholder                      |

¹ Check first whether their mise renders templates in compose values
([jdx/mise#13937](https://github.com/jdx/mise/discussions/13937)): if
`project_dir = "{{ env.HOME }}/.config/mempalace"` passes
`mise bootstrap compose status`, use that and drop this row.

### Adopted by default — offer an opt-out

List these and let the user deselect any:

- macOS defaults (`conf.d/macos-defaults.toml`) and the power profile
  (`upgrade:power`)
- Touch ID for sudo (`/etc/pam.d/sudo_local` in `conf.d/shell.toml`)
- mempalace (`conf.d/mempalace.toml`, `mempalace:*` tasks)
- the `virajp/tap` tap and `claude-status` (`conf.d/claude.toml`)
- the `@askviraj/linter` lint hook (`.config/pre-commit-config.yaml`,
  `.config/mise/tasks/code/lint`, `.config/linter.yaml`, `eslint.config.mjs`)
- `dotfiles/.claude/CLAUDE.md` and `dotfiles/.claude/output-styles/` (see
  step 7)

For each one deselected, also remove what only it uses: its `[dotfiles]`
entries, tasks, `[env]`, aliases and `updateall` steps.

### Offered only — opt-in

Ask about each; skip it if declined:

- 1Password as SSH agent and commit signer (`.config/1Password/`,
  `IdentityAgent` in `.ssh/config`, `op-ssh-sign` in `.config/git/config`)
- Tailscale (`tailscale:daemon`, `upgrade:tailscale`, their `updateall` steps)
- the OrbStack `Include` in `.ssh/config`
- the fnox secrets upstream declares (`GITHUB_API_TOKEN`, `CONTEXT7_API_KEY`,
  `HF_TOKEN`). The values live in the Keychain, never in the repo: for each one
  adopted, tell the user to run `fnox set <NAME>`.

### Never comes over

- `dotfiles/.claude/settings.json`
- the owner's own projects: `@virajp.dev/claude-plugins` in `upgrade:ai`, the
  `virajp/ai-plugins` link in `docs/ai-tools/readme.md`, the schema URL in
  `.config/statusline.json`
- `docs/plans/`, `docs/backlog.md`, `TASKS.md`, `graphify-out/`, `.vscode/`
- the "Install these tools manually" list in `readme.md`
- `sync.md` itself

## 7. CLAUDE.md

Copy `dotfiles/.claude/CLAUDE.md` (if adopted), then drop every rule whose
plugin, skill or file the user doesn't have:

| Rule                                  | Needs                        |
| ------------------------------------- | ---------------------------- |
| **git**: use the `git-workflow` skill | the `vwf` Claude Code plugin |
| **libraries**: use Context7 MCP       | a Context7 MCP server        |
| `## graphify` section                 | `~/.claude/skills/graphify/` |
| `@RTK.md` include                     | `~/.claude/RTK.md`           |

Check each: `claude plugin list` for plugins, `claude mcp list` for MCP servers,
the file system for the rest. Show the user what was dropped.

Then rebuild the `## Shell Aliases` section from the user's `[shell_alias]`
entries across `conf.d/*.toml`: list only the aliases they kept that shadow a
standard command, with what each runs, and update the summary of the safe ones.

## 8. Scoped run (`for <app>`)

Touch only what belongs to that app:

1. **Upstream configures it** (its `[dotfiles]` entries, config files in
   `dotfiles/`, `conf.d` settings, env, aliases, tasks): bring those over the
   same way as a full run, and add its package or tool entry if the user's repo
   lacks one.
2. **Upstream doesn't have it:** declare it the way this repo would — a formula
   as `"brew:<name>"`, a cask as `"brew-cask:<name>"`, an App Store app as
   `"mas:<id>"`, a versioned dev tool in `[tools]` — in the fitting
   `conf.d/<topic>.toml`. Ask which kind when it's ambiguous. If the user has
   config files for it in `$HOME`, offer to move them into the mirror and add
   `[dotfiles]` entries.

Everything else in the repo stays untouched. Continue with step 9.

## 9. Apply the changes to the repo

1. Write the changes into `$REPO`.
2. Format and validate:

   ```shell
   mise x --cd="$REPO" -- mise run code:format --fix
   mise x --cd="$REPO" -- mise run code:lint
   ```

3. Check nothing personal from upstream slipped in:

   ```shell
   git -C "$REPO" grep -niE 'viraj|vicz|3125954|35455|/Users/'
   ```

   Every hit must be justified (e.g. the adopted `virajp/tap` tap, the
   `@askviraj/linter` hook, `/Users/Shared`) or removed.

## 10. Review

1. Show `git -C "$REPO" status` and the diff, grouped by the sections of step 6.
2. Ask whether to commit. If yes, commit with a conventional commit message
   (`ops:` for config, `docs:` for docs). Do not push.

## 11. Apply to the machine

Ask again before touching the machine, and say what a full converge does: it
restarts Finder, Dock and the menu bar (macOS defaults), changes the login shell
to fish, writes `/etc/pam.d/sudo_local` and `/etc/shells`, and installs every
declared package. List the parts they opted out of in step 6. If yes:

1. Link the global mise config to the repo (moves an existing `~/.config/mise`
   directory to `~/.config/mise.bak`):

   ```shell
   mise x --cd="$REPO" -- mise run setup:all
   ```

2. Preview, then converge — from `$HOME`, so only the global config is read:

   ```shell
   cd ~ && mise bootstrap --dry-run
   cd ~ && mise bootstrap
   ```

   `mise bootstrap` prompts for `sudo` where it needs it (Touch ID file,
   `/etc/shells`, `chsh`). If Docker isn't running, add `--skip compose` and
   tell the user to run `mise bootstrap --only compose` later.

3. Verify: `mise bootstrap status` and `mise run dotfiles:status` show nothing
   missing, and the identity applies — `git -C "$REPO" config user.email` prints
   their `github_email` (when `$REPO` sits under `projects_dir`).

## 12. Clean up

Delete the temp folder from step 2. Summarize for the user: what came over, what
was kept, what was dropped and why, anything they still need to do (e.g.
`fnox set …`, pushing the repo, launching OrbStack).
