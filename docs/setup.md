# Setup

Homebrew formulae and Mac App Store apps are declared in `[bootstrap.packages]`
of [`dotfiles/mise/conf.d/packages.toml`](../dotfiles/mise/conf.d/packages.toml)
and installed by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html), which
pours Homebrew bottles itself. Casks (GUI apps, fonts) and VS Code extensions
stay on `Homebrew`, declared in
[`dotfiles/homebrew/brewfile`](../dotfiles/homebrew/brewfile) and applied by the
`brew:casks` task. Development tools (global or per project) are `mise`
`[tools]`.

## Setup

The repo is public, so the [`setup`](../setup) script can be run directly from
GitHub. It installs Homebrew (which pulls in the Xcode Command Line Tools) and
`mise`, clones this repo to `~/Projects/github.com/virajp/macos-setup` if it
isn't already present, links `~/.config/mise` to `dotfiles/mise` so the global
config exists, runs `mise bootstrap --yes` — packages, macOS defaults, fish as
login shell, Touch ID for sudo, and the pmset/nvram power profile (this last
part prompts for `sudo`) — and finally `mise run dotfiles:install` to link the
dotfiles.

```shell
curl -fsSL https://raw.githubusercontent.com/virajp/macos-setup/main/setup | sh
```

The script hands stdin back to the terminal before it starts, so the prompts
(Homebrew's "Press RETURN", `sudo`, the App Store sign-in check) work while
piped. `GITHUB_USER=<you> curl … | sh` clones a fork instead.

Afterwards, in a new terminal (fish is the login shell now):

```shell
tailscale up            # this node is new to the tailnet
pitchfork boot enable   # start mempalace at login, see mempalace.md
# launch OrbStack once, then bring up qdrant:
mise bootstrap --only compose
```

The compose phase is skipped on the first run when Docker is not reachable —
OrbStack has just been installed and never launched.

## Reference

- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
- [Homebrew](https://brew.sh/)
- [`setup` script](../setup)
