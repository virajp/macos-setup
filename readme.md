# macOS Setup

My personal macOS provisioning repo: a Homebrew `brewfile`, dotfiles managed
with [GNU Stow](https://www.gnu.org/software/stow/), and a `mise` task runner
that ties everything together.

## Automated setup

The [`./setup`](./setup) script is the main entrypoint. It installs Homebrew if
missing, installs everything in
[`dotfiles/homebrew/brewfile`](./dotfiles/homebrew/brewfile), symlinks the
dotfiles via `mise run stow:install`, and applies the macOS defaults in
[`utils/macos-setup`](./utils/macos-setup):

```shell
./setup
```

> On a truly fresh machine, run the one-liner in
> [docs/setup.md](./docs/setup.md) — it installs Homebrew and clones this repo
> before running `./setup`.

## Manual steps

- [Create account](./docs/account.md)
- [Setup Hostname](./docs/host.md)
- [Setup](./docs/setup.md)
- [Configure Shell](./docs/shell.md)
- [Setup TouchID for sudo](./docs/touchid-sudo.md)
- [Install tools](./docs/tools.md)
- [AI tools](./docs/ai-tools/readme.md)

## Common tasks

Tasks are run with `mise` (list them with `mise tasks`):

```shell
mise run brew:gen        # regenerate the brewfile from installed packages
mise run brew:check      # check the system against the brewfile
mise run stow:install    # (re)symlink dotfiles
mise run stow:simulate   # dry-run the symlinking
mise run code:format     # format files (dprint/taplo)
mise run code:lint       # lint files
```

See [dotfiles/CONFIG_DOCUMENTATION.md](./dotfiles/CONFIG_DOCUMENTATION.md) for
how the dotfiles are organized.

## Final steps: Update tools & macOS

```shell
# Update everything
updateall

# Update macOS (works on zsh & fish only)
osx-upgrade
```

## Install these tools manually

- [Brave Browser](https://brave.com/)
- [Cloudflare Wrap](https://1.1.1.1/)
- [SnapDownloader](https://snapdownloader.com/downloads)
- [Spatial Media Metadata Injector](https://github.com/google/spatial-media/releases)
- [Insta360 Studio 2023](https://www.insta360.com/download/insta360-oners)
