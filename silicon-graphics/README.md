# Silicon Graphics firmware control #

## Supported machines ##

* Indigo R3000
* Indy
* Indigo²
* O2
* Octane
* Octane2
* Origin200

## Implemented functionality ##

All functionality requires serial console access to the respective machine. Configure the respective serial port and serial console configuration in `config/config.tcl`.

Default configuration:
```
########################################################################
# Serial port and prompt configuration
########################################################################
set _serialPort "/dev/ttyUSB0"
set _serialBaudRate "9600"
set _serialBits "cs8"
set _serialParity "-parenb"
set _serialStopBit "-cstopb"

set _prompt "> "
```

### Generic functionality ###

You can use the shorthands provided by expect scripts named after the respective PROM command with the respective switches of that PROM command. For the help switch (`-h`) to actually work you need to be connected to the serial console of an active machine running the PROM monitor. To send arbitrary PROM commands, use the `send-prom-command.exp` script with the PROM commandline as arguments.

* `hinv` (via `hinv.exp`)
* `printenv` (via `printenv.exp`)
* `setenv` (via `setenv.exp`)
* `unsetenv` (via `unsetenv.exp`)
* sending arbitrary PROM commands (via `send-prom-command.exp`, e.g. `send-prom-command.exp "hinv -v"`)

All these scripts can be used directly from the commandline or from within shell scripts.

Some machines have specific versions of some PROM commands (e.g. `hinv` on the Indigo R3000) or unique PROM commands (like `off` on the Indy) or PROM commands not generally available on other machines (like for example `system` on Indigo²). These are handled by the machine specific functionality in the respective subdirectories. There is no machine detection yet, so you have to use the machine specific version of a specific command.

For programmatical access to the machines via expect you need to source the respective expect "library" script. For basic functionality like entering the PROM monitor or sending a PROM command you need to source `fw-control.exp`. The configuration is automatically sourced by this library. An examplary command list could look like this:
```
#!/usr/bin/expect

source fw-control.exp

exp_spawn -open [open $_serialPort w+]
exp_stty raw < $_serialPort
exp_stty ispeed $_serialBaudRate ospeed $_serialBaudRate raw -echo $_serialBits $_serialParity $_serialStopBit onlcr < $_serialPort

enterCommandMonitor

sendPromCommand "printenv"

sendPromCommand "init"

enterCommandMonitor

sendPromCommand "hinv -v"

exit
```

Some machines have unique functionality (like setting the Ethernet MAC address on the Indy) that can for now only be used from expect scripts. For this you have to source the respective `[...]-fw-control.exp` library which itself sources the `fw-control.exp` lib. An exemplary command list for the O2 could look like this:
```
#!/usr/bin/expect

source o2-fw-control.exp

exp_spawn -open [open $_serialPort w+]
exp_stty raw < $_serialPort
exp_stty ispeed $_serialBaudRate ospeed $_serialBaudRate raw -echo $_serialBits $_serialParity $_serialStopBit onlcr < $_serialPort

enterCommandMonitor

sendPromCommand "printenv"

sendPromCommand "init"

enterCommandMonitor

sendPromCommand "hinv -v -t -p"

sendPromCommand "date"

setDate

exit
```

### Machine specific functionality ###

#### Indigo R3000 ####

* `hinv` (via `indigo/hinv.exp`)

#### Indy ####

* `off` (via `indy/off.exp`)
* set Ethernet MAC address (via `setMacAddress` in `indy/indy-fw-control.exp`)
* set time and date (via `setDate` in `indy/indy-fw-control.exp`)

#### Indigo² ####

* `system` (via `indigo2/system.exp`)

#### O2 ####

* set time and date (via `setDate` in `o2/o2-fw-control.exp`)

#### Octane(2) ####

* `system` (via `octane/system.exp`)

#### Origin200 ####

* `hinv` (via `origin200/hinv.exp`)

## What can I do with it? ##

Still no idea what you can do with these scripts? Here are a few examples:

* Reconfigure Ethernet MAC address and time and date on an Indy with depleted NVRAM/TODclock battery before starting any OS
* Set date and time on an O2 with depleted NVRAM/TODclock battery before starting any OS
* Switch between boot from disk, disc or network boot programmatically
* Gather hardware information for taking inventory
* ...
