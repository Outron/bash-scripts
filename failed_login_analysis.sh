#!/bin/bash

AUTH_LOG="/var/log/auth.log"

if [[ ! -f "$AUTH_LOG" ]]; then
    echo "Log file does not exists."
    exit 1
fi

if [[ ! -r "$AUTH_LOG" ]]; then
    echo "No permissions to read log file"
    exit 2
fi

FAILED_ATTEMPS=$(grep "Failed password" "$AUTH_LOG" | awk '{ print $11 }' | sort | uniq | wc -l)

echo "Number of failed login attempts: $FAILED_ATTEMPTS"

exit 0
