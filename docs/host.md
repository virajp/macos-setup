# Setup Hostname & Diskname

## Hostname

### Check the ComputerName & HostName

```shell
scutil --get ComputerName && scutil --get LocalHostName
```

### Set the ComputerName & HostName

```shell
scutil --set ComputerName "Vicz MBP (2023)"
scutil --set LocalHostName "Vicz-MBP-2023"
```

## Diskname

> - List all the volumes

```shell
diskutil list internal virtual | grep Volume | grep -Eiv "preboot|recovery|vm|macOS"
```

> - Rename the volume

```shell
diskutil renameVolume "disk3s5" "Data"
```
