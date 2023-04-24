# Setup TouchID for sudo

> **Note:** required post every macOS upgrade.

```bash
# Open the sudo utility
subl /etc/pam.d/sudo

# Add the following as the first line
auth       sufficient     pam_tid.so
```
