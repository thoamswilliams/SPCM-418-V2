#!/bin/sh

# *************************************
# unload script for spcm4 linux driver
# (c) Spectrum GmbH
# *************************************

module="spcm4"
max_dev=15


# ----- invoke rmmod -----
/sbin/rmmod ./${module}
if [ $? != 0 ]; then
    echo "rmmod command failed, please check output of dmesg"
    exit 1
fi

# ----- if udev is not installed we have to remove nodes manually -----
if [ "`ps -e | grep -o udev`" = "" ] && [ "`ps -o pid -C udev`" = "  PID" ]; then
	# ----- remove stale nodes -----
	for index in `seq 0 $max_dev`; do
		rm -f /dev/${module}${index}
	done
fi


echo "kernel module "${module}" sucessfully removed"
