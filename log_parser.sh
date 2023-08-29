#!/bin/bash

LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="result.txt"

if [[ $# != 1 ]]; then
	echo "Usage: $0 <specific_value>"
	exit 1
fi

SPECIFIC_VALUE="$1"

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
	echo "Log file does not exists"
	exit 2
fi

# Check permissons
if [[ ! -r "$LOG_FILE" ]]; then
    echo "Brak uprawnień do odczytu pliku dziennika logów."
    exit 1
fi

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Analize log file to find given value
FOUND_LINES=$(grep "$SPECIFIC_VALUE" "$LOG_FILE")

# Check if something was found

if [[ -z $FOUND_LINES ]]; then
	echo "Search value not found"
	exit 0
fi

echo "$TIMESTAMP"
echo "$FOUND_LINES"
echo "$FOUND_LINES" >> "$OUTPUT_FILE"
echo "Founded value saved in output file: $OUTPUT_FILE"

exit 0
