# Sun OpenBootPROM firmware control #

## Implemented functionality ##

* Automatic reprogramming of values in the IDPROM (mainly the last three bytes of the Ethernet MAC address). This allows to use a Sun machine with drained NVRAM battery without prior repair as long as the machine is powered on or standby power is provided to the NVRAM chip.

**Currently only available internally:**

* show banner message

* show IDPROM contents

* print NVRAM environment

* set NVRAM variable to value

* reset machine

* set NVRAM defaults

## Required configuration ##

* None so far, the tool takes control as soon as the sent break signal is accepted by the firmware.

