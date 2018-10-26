#!/bin/sh

# exit on failure
set -e

# ensure script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "permission denied (try sudo)"
  exit 1
fi

apt-get update
apt-get -y upgrade                    # upgrade all existing packages
apt-get -y install runit              # manage daemon processes
apt-get -y install runit-systemd      # runit dependency
apt-get -y install vim                # useful text editor
apt-get -y install x11-xserver-utils  # tools for fixing display errors on video playback
apt-get -y install socat              # for network debugging
apt-get -y install fbi                # displays images
