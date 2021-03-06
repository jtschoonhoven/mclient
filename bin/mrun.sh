#!/bin/bash
DEFAULT_COMMAND="uptime"
HOSTS=()

help() {
cat << EOF

DESCRIPTION
    execute shell commands across multiple remote hosts

USAGE
    ./mrun --user pi --command "sudo reboot" --host 127.0.0.1 --host 127.0.0.2

EOF
}

# parse args https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
while (( "$#" )); do
    case "$1" in
        -u|--user)
            USER=$2
            shift 2
            ;;
        -h|--host)
            HOST=$2
            HOSTS+=( $HOST )
            shift 2
            ;;
        -c|--command)
            COMMAND=$2
            shift 2
            ;;
        --) # end argument parsing
            shift
            break
            ;;
        -*|--*=) # unsupported flags
            echo "invalid option $1" >&2
            help
            exit 1
            ;;
    esac
done

# at least one host is required
if [ -z $HOST ]; then
    echo "ERROR: --host (-h) is a required argument" >&2
    help
    exit 1
fi

# use default if command is not specified
if [ -z "${COMMAND}" ]; then
    COMMAND=$DEFAULT_COMMAND
fi

for host in ${HOSTS[@]}; do
    command="ssh ${USER}@${host} ${COMMAND}"
    echo "executing command for ${USER}@${host}"
    eval ${command} 2>&1
done

echo "success"
