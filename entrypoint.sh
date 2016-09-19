#!/bin/bash

# Setup a user account from environment:
#   LOCAL_USERNAME
#   LOCAL_UID
USERNAME=${LOCAL_USERNAME:-user}
USER_ID=${LOCAL_UID:-1000}

if [ "$USERNAME" == "root" ]; then
    echo "Running as root"
    exec "$@"
else
    echo "Running with $USERNAME:$USER_ID"
    useradd -u "$USER_ID" -m "$USERNAME"
    exec sudo -u "$USERNAME" "$@"
fi
