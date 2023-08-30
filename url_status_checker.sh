#!/bin/bash

URL_FILE="url.txt"
# check if file with urls exists
if [[ -f "$URL_FILE" ]]; then
    echo "Plik z listą adresów URL nie istnieje."
    exit 1
fi

while read -r url; do
    # get url respose with curl
    response=$(curl -Is "$url" | head -n 1 | awk '{print $2}')

    if [[ "$response" -eq 200 || "$response" -eq 301 || "$response" -eq 302 ]]; then
        echo "URL $url jest dostepny. Status: $response"
    else
	echo "URL $url jest niedostepny. Status: $response"
    fi

done < "$URL_FILE"

exit 0
