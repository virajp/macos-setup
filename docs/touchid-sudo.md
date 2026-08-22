# Setup TouchID for sudo

> NOTE: This is automated — `updateall` runs `mise run upgrade:touch-id`, which
> configures it on first run and is a no-op afterwards.

Touch ID for `sudo` is configured in `/etc/pam.d/sudo_local`, not
`/etc/pam.d/sudo`. macOS overwrites `/etc/pam.d/sudo` on every system update;
`sudo_local` is the drop-in that `/etc/pam.d/sudo` includes, and it survives
updates — so this no longer has to be redone after each macOS upgrade.

The task writes a single line, prompting for `sudo` once:

```shell
auth       sufficient     pam_tid.so
```

## Manual setup

Only needed on a macOS too old to include `sudo_local` (the task detects this
and says so).

```shell
sudo subl /etc/pam.d/sudo
```

Add the line above as the first line of the file.
