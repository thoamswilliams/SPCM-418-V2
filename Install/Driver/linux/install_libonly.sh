#!/bin/bash

# *************************************
# Install Script for spcm library
# (c) Spectrum GmbH
# *************************************


# ***** error check function *****
error_exit()
    {
    echo
    echo "************************************************************"
    echo $1
    echo "************************************************************"
    echo
    exit 1
    }

check_error()
    {
    if [ $? != 0 ]; then
        error_exit "$1"
    fi
    }


# *************************************
# ***** main function starts here *****
# *************************************

# give a help screen if requested
case $1 in
    -h | --h | -? | --? | -help | --help | /? | \?) {
        echo
        echo "Spectrum spcm library install script"
        echo "-----------------------------------"
        echo "Please call with ./install_libonly.sh"
        echo "This script requires root privileges to run!"
        echo
        exit 1
        };;
esac

if [ `id -u` != 0 ]; then
    error_exit "This script requires root privileges to run!"

fi

# ----- see which system is used (32 or 64 bit) -----
CPU_TYPE=`uname -m`
case ${CPU_TYPE} in
    i386)   SYSTEM_WIDTH="32bit";;
    i486)   SYSTEM_WIDTH="32bit";;
    i586)   SYSTEM_WIDTH="32bit";;
    i686)   SYSTEM_WIDTH="32bit";;
    x86_64) SYSTEM_WIDTH="64bit";;
    amd64)  SYSTEM_WIDTH="64bit";;
    *) error_exit "CPU type "${CPU_TYPE}" not supported yet";;
esac

# ----- check which package we should try to install -----
# SUSE
if [ -e /etc/SuSE-release ] || [ -e /etc/SUSE-brand ]; then
    FORMAT=RPM

# Fedora    
elif [ -e /etc/fedora-release ]; then
    FORMAT=RPM

# Redhat
elif [ -e /etc/redhat-release ]; then
    FORMAT=RPM

# Debian/Ubuntu
elif [ -e /etc/debian_version ]; then
    FORMAT=DEB

else
    FORMAT=RAW
fi


# ----- now we start the installation -----
if [ "$FORMAT" == "RPM" ]; then
    echo "Installing library"
    pushd libs >/dev/null
    if [ "${SYSTEM_WIDTH}" == "32bit" ]; then
        rpm -Uhv --force ./libspcm_linux-*.i586.rpm
    else
        rpm -Uhv --force ./libspcm_linux-*.x86_64.rpm
    fi
    if [ $? != 0 ]; then
        echo "Library installation failed."
        popd >/dev/null
        exit 1
    fi
    popd >/dev/null

elif [ "$FORMAT" == "DEB" ]; then
    echo "Installing library"
    pushd libs >/dev/null
    if [ "${SYSTEM_WIDTH}" == "32bit" ]; then
        dpkg -i ./libspcm-linux-*.i386.deb
    else
        dpkg -i ./libspcm-linux-*.amd64.deb
    fi
    if [ $? != 0 ]; then
        echo "Library installation failed."
        popd >/dev/null
        exit 1
    fi
    popd >/dev/null

elif [ "$FORMAT" == "RAW" ]; then
    echo "Installing library"
    pushd libs >/dev/null
    if [ "${SYSTEM_WIDTH}" == "32bit" ]; then
        cp ./spcm_linux_32bit_stdc++6.so /usr/lib/libspcm_linux.so
    else
        cp ./spcm_linux_64bit_stdc++6.so /usr/lib64/libspcm_linux.so
    fi
    if [ $? != 0 ]; then
        echo "Library installation failed."
        popd >/dev/null
        exit 1
    fi
    popd >/dev/null

fi

echo
echo "Library was installed sucessfully."
echo

exit 0

