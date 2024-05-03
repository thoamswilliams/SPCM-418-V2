#!/bin/sh

# *************************************
# Load script for spcm linux driver
# (c) Spectrum GmbH
# *************************************

module="spcm"
max_dev=15
extension="unknown"

# ----- we try to examine the kernel version
case `uname -r` in
    2.4.*) extension=".o";;
    *) extension=".ko";;
esac


# ----- invoke insmod -----
/sbin/insmod ./${module}${extension}
if [ $? != 0 ]; then
    echo "insmod command failed, please check output of dmesg"
    exit 1
fi

# ----- no udev installed -> create device nodes manually -----
if [ "`ps -e | grep -o udev`" = "" ] && [ "`ps -o pid -C udev`" = "  PID" ]; then
	echo "No udev detected, trying to create device nodes"
	# ----- remove stale nodes -----
	for index in `seq 0 $max_dev`; do
		rm -f /dev/${module}${index}
	done

	# ----- examine the major number of the loaded driver -----
	major=`cat /proc/devices | awk "\\$2==\"$module\" {print \\$1}"`

	if [ "$major" = "" ]; then
		# if kernel supports sysfs, but udev is not used
		major=`cat /proc/devices | awk "\\$2==\"misc\" {print \\$1}"`
		minor=`cat /proc/misc | grep spcm | sed 's/\([ 0-9]*\) \(spcm\)[0-9]*/\1 /'|tr -d '\n'`

		i = 0;
		for indexMinor in $minor; do
			# ----- generate the device nodes -----
			mknod /dev/${module}${index} c $major ${minor[$index]}
			let i=$i+1
		done
	else
		# no sysfs and no udev
		# ----- generate the device nodes -----
		for index in `seq 0 $max_dev`; do
			mknod /dev/${module}${index} c $major ${index}
		done
	fi

	# ----- change the access mode -----
	for index in `seq 0 $max_dev`; do
		chmod a+w /dev/${module}${index}
	done
else
	echo "udev detected"
fi

echo "kernel module "${module}${extension}" loaded properly"
