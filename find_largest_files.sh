#!/bin/bash

find_largest_files() {
    OUTPUT_FILE="largest_files.txt"
    PLACE=$(read -p "Type place where to find files: (e.g. /home) ")
    echo "Finding the 10 largest files..."

    # Use find to search for all files, sort them by size (descending), and get the top 10
    find $place -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 > "$OUTPUT_FILE"
   
    echo "10 largest files saved to $OUTPUT_FILE"
    exit 0
}

find_largest_files
