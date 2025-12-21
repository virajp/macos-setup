# Setup TouchID for sudo

> NOTE: This will be checked everytime `updateall` is called

This is required to use TouchID for sudo and needs to be done post every macOS update.

## Open the sudo utility

```shell
subl /etc/pam.d/sudo
```

## Add the following as the first line

```shell
auth       sufficient     pam_tid.so
```
