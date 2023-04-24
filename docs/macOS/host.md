# Set up Hostname & Diskname

## Hostname

```bash
# Setup Hostname / Machine Name
scutil --set ComputerName "Vicz MBP (2020)"
scutil --get ComputerName

scutil --set LocalHostName "Vicz-MBP-2020"
scutil --get LocalHostName
```

## Diskname

```bash
# Use this command to list all the volumes
diskutil list | grep Volume | grep -Eiv "preboot|recovery|vm"
diskutil renameVolume "disk3s1" "OSX"
diskutil renameVolume "disk3s5" "Data"
```
