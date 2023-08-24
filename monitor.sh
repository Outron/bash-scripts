#!/bin/bash

OUTPUT_FILE=monitoring_data.txt

CPU_USAGE=$(top -b -n 1 | grep "%Cpu" | awk '{print $2}')
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df -h | grep "/$" | awk '{print $5}')

CPU_THRESHOLD=85
MEM_THRESHOLD=80
DISK_THRESHOLD=80

#saving to file
echo "Time: $(date)" > "$OUTPUT_FILE"
echo " ___________________________" >> "$OUTPUT_FILE"
echo "|  Parameter  |    Usage    |" >> "$OUTPUT_FILE"
echo "|-------------|-------------|" >> "$OUTPUT_FILE"
echo "|  CPU        |    $CPU_USAGE%     |" >> "$OUTPUT_FILE"
echo "|  MEMORY     |    $MEM_USAGE% |" >> "$OUTPUT_FILE"
echo "|  DISK       |    $DISK_USAGE       |" >> "$OUTPUT_FILE"
echo "|_____________|_____________|" >> "$OUTPUT_FILE"

if [[ $CPU_USAGE > $CPU_THRESHOLD ]]; then
	echo "ALERT! CPU USAGE EXCEEDED $CPU_THRESHOLD%" >> "$OUTPUT_FILE"
fi

if [[ $MEM_USAGE > $MEM_THRESHOLD ]]; then
        echo "ALERT! MEM USAGE EXCEEDED $MEM_THRESHOLD%" >> "$OUTPUT_FILE"
fi

if [[ $DISK_USAGE > $DISK_THRESHOLD ]]; then
        echo "ALERT! DISK USAGE EXCEEDED $DISK_THRESHOLD%" >> "$OUTPUT_FILE"
fi

exit 0


