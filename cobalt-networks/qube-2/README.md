# Cobalt Networks firmware control #

## Implemented functionality ##

* network boot for RaQ, (Cache)RaQ 2 and Qube 2: CoLo can be loaded directly from the network (per default assumed as `/boot/vmlinux.gz` in the NFS root FS that is given by your DHCP/BOOTP server)

* used serial port can be either given via the configuration file or via CLI - the latter takes precedence:

```
$ ./network-boot.exp /dev/ttyUSB1
```

## Required configuration ##

* After startup the machine has to enter the firmware automatically for the tool to be able to take control. This can be done by hitting space and entering `clearbfd` after the `Cobalt: ` prompt appears.

