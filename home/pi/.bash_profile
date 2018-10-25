cat << EOF

              _________            __
   ____ ___  / ____/ (_)__  ____  / /_
  / __ '__ \/ /   / / / _ \/ __ \/ __/
 / / / / / / /___/ / /  __/ / / / /_
/_/ /_/ /_/\____/_/_/\___/_/ /_/\__/

======================================

This device is configured for automatic media playback from USB and network sources.

https://github.com/jtschoonhoven/mclient

COMMANDS
mhelp    - print additional instructions
mstart   - start background process
mstop    - stop background process
mrestart - restart background process
mterm    - force kill background process
mstatus  - show status of background process
mlog    - tail background process logs
mrefresh - refresh screen display

EOF

alias mhelp="less ~/mhelp.md"
alias mstart="sudo sv start /etc/service/mclient"
alias mstop="sudo sv stop /etc/service/mclient"
alias mrestart="sudo sv restart /etc/service/mclient"
alias mterm="sudo pkill omxplayer"
alias mstatus="sudo sv status /etc/service/mclient"
alias mlog="sudo tail -F /var/log/mclient/current"
alias mrefresh="fbset -depth 8 && fbset -depth 16"

