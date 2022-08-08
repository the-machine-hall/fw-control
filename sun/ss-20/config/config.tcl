########################################################################
# Serial port and configuration
########################################################################
# NOTICE: The used serial port can also be set as first argument to
# `reprogram-idprom.exp`.
set _serialPort "/dev/ttyUSB0"
set _serialBaudRate "9600"
set _serialBits "cs8"

########################################################################
# Other variables
########################################################################
# Not sure if this also works for MP machines (which have a
# "{CPU_NUMBER} ok " prompt)
set _prompt "ok "

# SPARCstation 10 and 20 and SPARCclassic have the real machine type
# available as a variable, so you can use the string "real-machine-type"
# with these machines to access the content of this variable during
# execution. For other machines you might have to determine the type by
# other means. Just enter the real machine type as number then.
set _realMachineType "real-machine-type"

# Set the MAC address bytes. The first three bytes are fixed to:
#
# 8:0:20
# | | |
# | | Byte 2
# | Byte 1
# Byte 0
#
# NOTICE: Although untested, do not use leading zeroes!
set _macAddressByte3 "55"
set _macAddressByte4 "20"
set _macAddressByte5 "2"

