# Setup Hostname

## Hostname

### Check the ComputerName & HostName

```shell
scutil --get ComputerName && scutil --get LocalHostName
```

### Set the ComputerName & HostName

```shell
scutil --set ComputerName "<Name> MBP (<Year>)"
scutil --set LocalHostName "<Name>-MBP-<Year>"
```
