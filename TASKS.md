## `code:format`

Check or format files

- **Usage:** `code:format [--debug] [--fix]`

### Flags

- **`--debug`** — emit debug logs
- **`--fix`** — apply fixes

## `code:git-config`

Validate git-config

- **Usage:** `code:git-config [--fix]`

### Flags

- **`--fix`** — Remove forbidden configs from local git-config

## `code:lint`

Lint files

- **Usage:** `code:lint [--debug] [--fix]`

### Flags

- **`--debug`** — emit debug logs
- **`--fix`** — apply fixes

## `dotfiles:delete`

- **Usage:** `dotfiles:delete`

Delete symlinks for dotfiles

## `dotfiles:install`

- Depends: dotfiles:prep

- **Usage:** `dotfiles:install`

Create symlinks for dotfiles

## `dotfiles:status`

- Depends: dotfiles:prep

- **Usage:** `dotfiles:status`

Show status of dotfiles

## `setup:all`

- Depends: init

- **Usage:** `setup:all`

Setup the project: install precommit hooks, upgrade dependencies, clean up
cache, etc.

## `system:symlinks`

Scan $HOME for broken symlinks

- **Usage:** `system:symlinks [FLAGS]`

### Flags

- **`--deep`** — also scan Library, Downloads, Documents, Desktop, caches,
  node_modules, .git and app bundles
- **`--delete`** — delete the broken symlinks found, after confirmation
- **`--root <root>`** — directory to scan (defaults to $HOME)
