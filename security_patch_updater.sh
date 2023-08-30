#!/bin/bash

SERVER_LIST=("192.168.1.100" "example.com" "10.0.0.5")
SSH_KEY="/path/to/key"
SSH_USER="user"

for server in "${SERVER_LIST[@]}"; do
    echo "Server update: $server"

    ssh -i "$SSH_KEY" "$SSH_USER@$SERVER" << EOF 
	if sudo apt update -y; then
            echo "Update successful."

            if sudo apt upgrade -y; then
                echo "Upgrade successful."
            else
                echo "Upgrade failed."
	    fi

	    if sudo apt dist-upgrade -y; then
                echo "Dist-upgrade successful."
            else
                echo "Dist-upgrade failed."
            fi

	    if sudo apt autoremove -y; then
                echo "Autoremove successful."
            else
                echo "Autoremove failed."
	    fi

        else
            echo "Update failed."
        fi
EOF

    echo "Update done for: $server"
done

