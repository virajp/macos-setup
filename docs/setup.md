# Setup

Homebrew formulae, casks and Mac App Store apps are declared in
`[bootstrap.packages]` of the topic files in
[`dotfiles/.config/mise/conf.d/`](../dotfiles/.config/mise/conf.d/) and
installed by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html), which
pours Homebrew bottles itself. Development tools (global or per project) are
`mise` `[tools]`.

## Setup

The repo is public, so the [`setup`](../setup) script can be run directly from
GitHub. It installs Homebrew (which pulls in the Xcode Command Line Tools) and
`mise`, clones this repo to `~/Projects/github.com/virajp/macos-setup` if it
isn't already present, links `~/.config/mise` to `dotfiles/.config/mise` so the
global config exists, then runs `mise bootstrap --yes` — packages, dotfile
links, macOS defaults, fish as login shell and Touch ID for sudo.

```shell
curl -fsSL https://raw.githubusercontent.com/virajp/macos-setup/main/setup | sh
```

The script hands stdin back to the terminal before it starts, so the prompts
(Homebrew's "Press RETURN", `sudo`, the App Store sign-in check) work while
piped. `GITHUB_USER=<you> curl … | sh` clones a fork instead.

Afterwards, in a new terminal (fish is the login shell now):

```shell
tailscale up            # this node is new to the tailnet
# launch OrbStack once, then bring up qdrant:
mise bootstrap --only compose
```

The compose phase is skipped on the first run when Docker is not reachable —
OrbStack has just been installed and never launched.

## Reference

- [mise bootstrap](https://mise.jdx.dev/bootstrap.html)
- [Homebrew](https://brew.sh/)
- [`setup` script](../setup)
