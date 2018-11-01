# mclient

Raspberry Pi kiosk mode for automatic media playback from drive and network sources.

## Setup

Copy all files in this directory to a Raspberry Pi with a fresh install of Raspbian OS.

```sh
# ssh to Raspberry Pi
ssh pi@xxx.xxx.x.x

# download and install mclient
cd /home/pi
git clone https://github.com/jtschoonhoven/mclient.git

# install mclient to /usr/local/bin
sudo ./mclient/install_client

# optionally set a static IP (overwrites /etc/dhcpcd.conf)
sudo ./mclient/install_static_ip --subnet xxx --host xxx

# optionally install service to run mclient forever in background
sudo ./mclient/install_service

# reboot to apply all changes
sudo reboot
```

## Usage

After service install and reboot, `mclient` will always be running in the background. Media will be displayed full-screen when detected.

```
mhelp    - print additional instructions
mstart   - start background process
mstop    - stop background process
mrestart - restart background process
mrun     - run process in the foreground
mterm    - force kill background process
mstatus  - show status of background process
mlog     - tail background process logs
mrefresh - refresh screen display
```

See [mhelp.md](https://github.com/jtschoonhoven/mclient/blob/master/home/pi/mclient_help.md) for more info.
