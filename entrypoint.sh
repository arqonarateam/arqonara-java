#!/bin/bash

TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Set the prompt prefix and color
PREFIX_DOCKER=${PREFIX_DOCKER:-"container@pterodactyl~ "}
PREFIX_COLOR=${PREFIX_COLOR:-"\033[1m\033[33m"}

/usr/local/bin/entrypoint --here || exit 1

# Print Java version
printf "%b%s\033[0mjava -version\n" "$PREFIX_COLOR" "$PREFIX_DOCKER"
java -version

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "%b%s\033[0m%s\n" "$PREFIX_COLOR" "$PREFIX_DOCKER" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
