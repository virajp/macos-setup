# macOS Setup

My personal macOS provisioning repo, driven by
[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): packages, dotfiles,
macOS defaults, login shell and Touch ID are all declared in the global mise
config ([`dotfiles/mise/conf.d/`](./dotfiles/mise/conf.d/)), plus a `mise` task
runner for the rest.

## Automated setup

The [`./setup`](./setup) script is the main entrypoint. It installs Homebrew and
`mise` if missing, links `~/.config/mise`, then runs `mise bootstrap` — Homebrew
formulae and App Store apps (`[bootstrap.packages]`), casks and VS Code
extensions via the Brewfile (`brew:casks`), macOS `defaults`
(`[bootstrap.macos.defaults]`), the fish login shell, Touch ID for sudo, and the
pmset/nvram power profile (`macos:power` task):

```shell
./setup
# or, once set up, converge directly:
mise bootstrap            # from any directory; --dry-run to preview
mise bootstrap status     # what differs
mise run dotfiles:install # (re)link the dotfiles — a repo task, not part of bootstrap
```

> On a truly fresh machine, run the one-liner in
> [docs/setup.md](./docs/setup.md) (`curl … | sh`) — it installs Homebrew and
> clones this repo before doing the same.

## Manual steps

- [Create account](./docs/account.md)
- [Setup Hostname](./docs/host.md)
- [Setup](./docs/setup.md)
- [Setup TouchID for sudo](./docs/touchid-sudo.md)
- [Install tools](./docs/tools.md)
- [AI tools](./docs/ai-tools/readme.md)

## Common tasks

Tasks are run with `mise` (list them with `mise tasks`):

```shell
mise bootstrap packages status  # system vs [bootstrap.packages]
mise bootstrap packages apply   # install what is missing
mise run dotfiles:install       # (re)symlink dotfiles
mise run dotfiles:status        # show which dotfile symlinks are missing
mise run code:format     # format files (dprint/taplo)
mise run code:lint       # lint files
mise run system:symlinks # find broken symlinks in $HOME (--deep, --delete)
```

See [dotfiles/CONFIG_DOCUMENTATION.md](./dotfiles/CONFIG_DOCUMENTATION.md) for
how the dotfiles are organized.

## Final steps: Update tools & macOS

```shell
# Update everything (the macOS settings / power profile part runs weekly)
updateall
updateall --force   # run the weekly part now

# Update macOS (works on zsh & fish only)
osx-upgrade
```

## Install these tools manually

- [Brave Browser](https://brave.com/)
- [Cloudflare Wrap](https://1.1.1.1/)
- [SnapDownloader](https://snapdownloader.com/downloads)
- [Spatial Media Metadata Injector](https://github.com/google/spatial-media/releases)
- [Insta360 Studio 2023](https://www.insta360.com/download/insta360-oners)
