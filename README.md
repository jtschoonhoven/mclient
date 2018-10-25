# mclient

Raspberry Pi configuration for easy, automatic media playback from USB and network sources.

## Setup

Copy all files in this directory to a Raspberry Pi with a fresh install of Raspbian OS.

```sh
# ssh to Raspberry Pi
ssh pi@xxx.xxx.x.x

# download and install dependencies
git clone https://github.com/jtschoonhoven/mclient.git
./mclient/setup.sh

# copy configuration
# CAUTION: this overwrites .bashrc .bash_profile and dhcpcd.conf
sudo cp -vr ./mclient/home/* /home
sudo cp -vr ./mclient/etc/* /etc
source .bash_profile

# restart
sudo reboot
```

## Usage

After install and reboot, `mclient` will always be running in the background. Media will be displayed full-screen when detected.

```
mhelp    - print additional instructions
mstart   - start background process
mstop    - stop background process
mrestart - restart background process
mterm    - force kill background process
mstatus  - show status of background process
mlog     - tail background process logs
mrefresh - refresh screen display
```

See [mhelp.md](https://github.com/jtschoonhoven/mclient/blob/master/home/pi/mhelp.md) for more info.
