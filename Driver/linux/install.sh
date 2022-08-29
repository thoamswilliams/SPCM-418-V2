#!/bin/bash

# *************************************
# Install Script for spcm/spcm4 linux driver
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
        echo "Spectrum spcm driver install script"
        echo "-----------------------------------"
        echo "Please call with ./install.sh"
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



# ----- see which processor type we have (single or SMP) -----
linux_version=`uname -v | grep -o SMP`
case ${linux_version} in
    *SMP*) CPU="smp";;
    *)     CPU="single";;
esac


# ----- check which kernel module we should try to install -----
KERNEL_MODULE_DIR=""
# SUSE
if [ -e /etc/SuSE-release ]; then
    KERNEL_MODULE_DIR=suse`grep VERSION /etc/SuSE-release|sed 's/[^0-9]*\([0-9]*\).\([0-9]\)/\1\2/'`_${SYSTEM_WIDTH}_$CPU
    FORMAT=RPM

# SUSE since 15.0
elif [ -e /etc/SUSE-brand ]; then
    KERNEL_MODULE_DIR=suse`grep VERSION /etc/SUSE-brand|sed 's/[^0-9]*\([0-9]*\).\([0-9]\)/\1\2/'`_${SYSTEM_WIDTH}_$CPU
    FORMAT=RPM

# Fedora    
elif [ -e /etc/fedora-release ]; then
    KERNEL_MODULE_DIR=fedora`cat /etc/fedora-release | sed 's/[^0-9]*\([0-9]*\)[^0-9]*/\1/'`_${SYSTEM_WIDTH}_$CPU
    FORMAT=RPM

# Redhat
elif [ -e /etc/redhat-release ]; then
    KERNEL_MODULE_DIR=redhat`grep -o -e [0-9] /etc/redhat-release`0_${SYSTEM_WIDTH}_$CPU
    FORMAT=RPM

# Debian/Ubuntu
elif [ -e /etc/debian_version ]; then
    # check for ubuntu
    if [ -e /usr/bin/lsb_release ]; then
        DISTRI=`lsb_release -is`
        if [ "$DISTRI" = "Ubuntu" ]; then
            KERNEL_MODULE_DIR=ubuntu_`lsb_release -rs`_${SYSTEM_WIDTH}_$CPU
        elif [ "$DISTRI" = "Debian" ]; then
            DEB_VER=`lsb_release -rs`
            if [[ $DEB_VER == 10 ]]; then
                # ***** Debian 10 Buster
                # lsb_release does not print subversions
                echo "Debian 10 Buster found"
                KERNEL_MODULE_DIR=debian_100_buster_${SYSTEM_WIDTH}_$CPU
            elif [[ $DEB_VER == 9.* ]]; then
                # ***** Debian 9.x Stretch
                echo "Debian 9.x Stretch found"
                KERNEL_MODULE_DIR=debian_90_stretch_${SYSTEM_WIDTH}_$CPU
            elif [[ $DEB_VER == 8.* ]]; then
                # ***** Debian 8.x Jessie
                echo "Debian 8.x Jessie found"
                KERNEL_MODULE_DIR=debian_80_jessie_${SYSTEM_WIDTH}_$CPU
            elif [[ $DEB_VER == 7.* ]]; then
                # ***** Debian 7.x Wheezy
                echo "Debian 7.x Wheezy found"
                KERNEL_MODULE_DIR=debian_70_wheezy_${SYSTEM_WIDTH}_$CPU
            elif [[ $DEB_VER == 6.* ]]; then
                # ***** Debian 6.x Squeeze 
                echo "Debian 6.x Squeeze found"
                KERNEL_MODULE_DIR=debian_60_squeeze_${SYSTEM_WIDTH}_$CPU
            fi
        fi
    else
        # ***** if debian *****
        # lsb_release is not always available, so we also check all available Debian releases here
        DEB_VER=`cat /etc/debian_version`

        if [[ $DEB_VER == 10.* ]]; then
            # ***** Debian 10.x Buster
            echo "Debian 10.x Buster found"
            KERNEL_MODULE_DIR=debian_100_buster_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 9.* ]]; then
            # ***** Debian 9.x Stretch
            echo "Debian 9.x Stretch found"
            KERNEL_MODULE_DIR=debian_90_stretch_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 8.* ]]; then
            # ***** Debian 8.x Jessie
            echo "Debian 8.x Jessie found"
            KERNEL_MODULE_DIR=debian_80_jessie_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 7.* ]]; then
            # ***** Debian 7.x Wheezy
            echo "Debian 7.x Wheezy found"
            KERNEL_MODULE_DIR=debian_70_wheezy_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 6.* ]]; then
            # ***** Debian 6.x Squeeze 
            echo "Debian 6.x Squeeze found"
            KERNEL_MODULE_DIR=debian_60_squeeze_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 5.* ]]; then
            # ***** Debian 5.x Lenny
            echo "Debian 5.x Lenny found"
            KERNEL_MODULE_DIR=debian_50_lenny_${SYSTEM_WIDTH}_$CPU
        elif [[ $DEB_VER == 4.* ]]; then
            # ***** Debian 4.x Etch
            echo "Debian 4.x Etch found"
            KERNEL_MODULE_DIR=debian_40_etch_${SYSTEM_WIDTH}_$CPU
        elif [ "$DEB_VER" = "3.1" ]; then
            # ***** Debian 3.1 Sarge
            echo "Debian 3.1 Sarge found"
            if [ "`uname -r|grep -o 2.6.8`" = "2.6.8" ]; then
                KERNEL_MODULE_DIR=debian_31_sarge2608_${SYSTEM_WIDTH}_$CPU
            elif [ "`uname -r|grep -o 2.4.27`" = "2.4.27" ]; then
                KERNEL_MODULE_DIR=debian_31_sarge2427_${SYSTEM_WIDTH}_$CPU
            fi
        fi
    fi
    FORMAT=DEB
fi

if [ "$KERNEL_MODULE_DIR" = "" ]; then
    echo
    echo "No pre-compiled modules available for your distribution."
    echo
    FORMAT=RAW
else
    echo
    echo "Trying to install kernel modules from $KERNEL_MODULE_DIR"
    echo
fi


# ----- now we start the installation -----
SHOW_NDA_MESSAGE=0
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

    echo
    echo "Installing kernel modules"
    pushd $KERNEL_MODULE_DIR >/dev/null
    if [ $? != 0 ]; then
        echo "No matching kernel module found."
        SHOW_NDA_MESSAGE=1
    else
        rpm -Uhv --force spcm*.rpm
        if [ $? != 0 ]; then
            echo "Kernel module installation failed."
            popd >/dev/null
            exit 1
        fi
        popd >/dev/null
    fi

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

    echo
    echo "Installing kernel modules"
    pushd $KERNEL_MODULE_DIR >/dev/null
    if [ $? != 0 ]; then
        echo "No matching kernel module found."
        SHOW_NDA_MESSAGE=1
    else
        dpkg -i spcm*.deb
        if [ $? != 0 ]; then
            echo "Kernel module installation failed."
            popd >/dev/null
            exit 1
        fi
        popd >/dev/null
    fi

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

    SHOW_NDA_MESSAGE=1
fi

if [ $SHOW_NDA_MESSAGE -eq 1 ]; then
    # since we only deliver pre-compiled modules for RPM and DEB based systems, you will need a NDA here
    echo "You will need to compile a matching driver module yourself."
    echo "Please see http://spectrum-instrumentation.com/en/how-compile-linux-kernel-driver for details."
    exit 1
fi

echo
echo "All driver files installed sucessfully."
echo "The driver will be loaded automatically on system start."
echo

exit 0

