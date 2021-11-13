#!/bin/bash

file="ATmega8u2Code/UnoJoy.hex"
echo Trying to program $file onto Arduino Uno R1/R2...
dfu-programmer at90usb82 flash $file

exit_code=$?

if [ $exit_code = 127 ]; then
	echo "Seems like the dfu-programmer is not installed. You can install it by typing: sudo apt install dfu-programmer"
elif [ $exit_code != 0 ]; then
	echo "We didn't find the R1/R2 model, checking for an R3..."
	dfu-programmer atmega16u2 flash $file
	if [ $? != 0 ]; then
		echo
		echo "dfu-programmer couldn't connect to the Arduino..."
		echo "Did you put the Arduino into DFU mode?"
		echo "Did you run the script as a root user?"
	else
		echo
		echo "Unplug your Arduino and plug it back in. It's a joystick now!"
	fi
else
	echo
	echo "Unplug your Arduino and plug it back in. It's a joystick now!"
fi
