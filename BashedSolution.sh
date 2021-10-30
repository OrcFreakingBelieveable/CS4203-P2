#!/bin/bash
letters=()
millis=()
echo "Enter a password"
# read a single character
while read -n1 key; do
    # if key = Escape key
    if [ $key == $'\e' ]; then
        break
    fi
    letters=(${letters[@]} $key)
    millis=(${millis[@]} $(date +%s%3N))
done
echo ""
for ((i = 0; i < ${#letters[@]} - 1; i++)); do
    delay=$((${millis[i+1]} - ${millis[i]}))
    echo "${letters[i]}${letters[i+1]}: ${delay}"
done

read  