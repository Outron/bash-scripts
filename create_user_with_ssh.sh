#!/bin/bash

if [[ "$EUID" != 0 ]]; then
	echo "Script must be run by root"
	exit 1 
fi 

if [[ "$#" != 3 ]]; then
	echo "Usage: $0 <username> <password> <name surname>"
	exit 2
fi

USERNAME="$1"
PASSWORD="$2"
FULLNAME="$3"

useradd -m -c "$FULLNAME" "$USERNAME"
if [[ "$?" != 0 ]]; then
    echo "Error, user cannot be created"
    exit 3
fi

echo "$USERNAME:$PASSWORD" | chpasswd
if [[ "$?" != 0 ]]; then
    echo "Error, password cannot be set"
    exit 4
fi

chown -R "$USERNAME:$USERNAME" /home/"$USERNAME"
chmod 700 /home/"$USERNAME"

mkdir -p /home/"$USERNAME"/.ssh
chmod 700 /home/"$USERNAME"/.ssh
touch /home/"$USERNAME"/.ssh/authorized_keys
chmod 600 /home/"$USERNAME"/.ssh/authorized_keys

echo "User $USERNAME created succesfully"
exit 0
