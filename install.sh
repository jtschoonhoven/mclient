#!/bin/sh
BASHRC_PATH="/home/pi/.bashrc"
BASH_MCLIENT_PATH="/home/pi/.bash_mclient"
DEPENDENCIES="runit runit-systemd vim x11-xserver-utils socat fbi"

# exit on failure
set -e

# ensure script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "permission denied (try sudo)"
  exit 1
fi

# install each package if not exists
for PACKAGE in $DEPENDENCIES; do
    if ! dpkg-query -l "$PACKAGE" >> /dev/null; then
        apt-get -y install "$PACKAGE"
    else
        echo "$PACKAGE is already installed"
    fi
done

# copy user files to device
cd /home/pi
mkdir -p /mnt/usb
mkdir -p /var/log/mclient
cp -vr /home/pi/mclient/home/* /home
cp -vr ./mclient/etc/* /etc

# initialize runit by symlinking /etc/service (if not exists)
if [ ! -L /etc/service ]; then
    ln -s /etc/sv/mclient /etc/service/mclient
fi

# source .bash_mclient from .bashrc if not already done
if ! cat $BASHRC_PATH | grep "source /home/pi/.bash_mclient" >> /dev/null; then
    echo $BASH_MCLIENT_PATH >> $BASHRC_PATH
fi

echo "install completed successfully: please reboot to initialize mclient"
