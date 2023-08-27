#!/bin/bash

if [ "$#" -eq 1 ]; then
    # one number of days given
    days="$1"
    find . -type f -ctime -$days -exec du -h {} \;

elif [ "$#" -eq 2 ]; then
    # if 2 dates given
    from_date="$1"
    to_date="$2"
    find . -type f -newermt "$from_date" ! -newermt "$to_date" -exec du -h {} \;

else
    echo "Użycie: $0 <ilość_dni | data_początkowa data_końcowa>"
    exit 0

fi

