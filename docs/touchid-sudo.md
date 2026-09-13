# Setup TouchID for sudo

> NOTE: This is automated — `mise bootstrap` (and `updateall`) declares the file
> in `[bootstrap.files."/etc/pam.d/sudo_local"]` (`dotfiles/mise.toml`) and
> writes it (with `sudo`) when it differs; a no-op afterwards.

Touch ID for `sudo` is configured in `/etc/pam.d/sudo_local`, not
`/etc/pam.d/sudo`. macOS overwrites `/etc/pam.d/sudo` on every system update;
`sudo_local` is the drop-in that `/etc/pam.d/sudo` includes, and it survives
updates — so this no longer has to be redone after each macOS upgrade.

The file holds a single line:

```shell
auth       sufficient     pam_tid.so
```

## Manual setup

Only needed on a macOS too old to include `sudo_local` in `/etc/pam.d/sudo`
(check with `grep sudo_local /etc/pam.d/sudo`).

```shell
sudo subl /etc/pam.d/sudo
```

Add the line above as the first line of the file.
