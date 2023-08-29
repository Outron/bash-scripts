#!/bin/bash

SOURCE_PATH="/home/dawid"
DESTINATION_USER="username"
DESTINATION_HOST="remote_address"
DESTINATION_PATH="/path/to/destination"

# Check if source path exists
if [[ ! -d "$SOURCE_PATH" ]]; then
    echo "Source path does not exist."
    exit 1
fi

# Check if destination host is reachable
ping -c 1 "$DESTINATION_HOST" > /dev/null
if [[ $? != 0 ]]; then
    echo "Destination host is not reachable."
    exit 2
fi


rsync -avz "$SOURCE_PATH" "$DESTINATION_USER@$DESTINATION_HOST:$DESTINATION_PATH"

if [ $? == 0 ]; then
    echo "Files have been copied to the remote host."
else
    echo "An error occurred during copying."
    exit 3
fi

exit 0
