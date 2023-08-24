#!/bin/bash

kill_zombies(){
	ZOMBIES=$(ps -eo pid,state | awk '$2=="Z" { print $1 }')

	if [[ -z $ZOMBIES ]]; then
		echo "No zombie processes, exiting..."
		exit 1
	else
		for pid in $ZOMBIES; do
			echo "Killing zombie process..."
			kill -9 $pid
		done
		echo "Done! Zombie processes killed"
		exit 0
	fi
}

kill_zombies
