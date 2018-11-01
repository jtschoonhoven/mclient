#!/bin/sh
BASHRC_PATH="/home/pi/.bashrc"
BASH_MCLIENT_PATH="/home/pi/.bash_mclient"
DEPENDENCIES="git runit runit-systemd vim x11-xserver-utils socat fbi"

# exit on failure
set -e

# ensure script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "permission denied (try sudo)"
  exit 1
fi

# install each package if not exists
for PACKAGE in $DEPENDENCIES; do
    if ! dpkg-query -l "$PACKAGE" > /dev/null; then
        apt-get -y install "$PACKAGE"
    else
        echo "$PACKAGE is already installed"
    fi
done

# create required directories if not exist
mkdir -p /mnt/usb
mkdir -p /etc/sv/mclient
mkdir -p /var/log/mclient

# copy files to device
cp -vr /home/pi/mclient/home/pi /home
cp -vr /home/pi/mclient/etc/sv/mclient /etc/sv
cp -vr /home/pi/mclient/usr/local/bin /usr/local

# initialize runit by symlinking /etc/service (if not exists)
if [ ! -L /etc/service ]; then
    ln -s /etc/sv /etc/service
fi

# source .bash_mclient from .bashrc if not already done
if ! cat $BASHRC_PATH | grep "source /home/pi/.bash_mclient" >> /dev/null; then
    echo "source $BASH_MCLIENT_PATH" >> $BASHRC_PATH
fi

echo "install completed successfully: please reboot to initialize mclient"
