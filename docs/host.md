# Setup Hostname & Diskname

## Hostname

### Check the ComputerName & HostName

```bash
scutil --get ComputerName && scutil --get LocalHostName
```

### Set the ComputerName & HostName

```bash
scutil --set ComputerName "Vicz MBP (2023)"
scutil --set LocalHostName "Vicz-MBP-2023"
```

## Diskname

> - List all the volumes

```bash
diskutil list internal virtual | grep Volume | grep -Eiv "preboot|recovery|vm|macOS"
```

> - Rename the volume

```bash
diskutil renameVolume "disk3s5" "Data"
```
