#!/bin/bash
declare id=""        # string of at most 10 characters
declare -a id_millis # the <=9 millisecond differences between the <=10 letters
declare pw           # string of at most 20 characters
declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
volunteer=$1
test_code=$2
index=0

echo "Enter a user name"
# read a single character
while read -n1 key; do
    # if key = Escape key
    if [ $key == $'\e' ]; then
        break
    fi

    id=$id$key
    id_millis[$index]=$(date +%s%3N)

    ((index += 1))
    if [ $index -gt 9 ]; then
        break
    fi
done

index=0
echo ""

echo "Enter a password"
# read a single character
while read -n1 key; do
    # if key = Escape key
    if [ $key == $'\e' ]; then
        break
    fi

    pw=$pw$key
    pw_millis[$index]=$(date +%s%3N)

    ((index += 1))
    if [ $index -gt 19 ]; then
        break
    fi
done

index=0
echo ""

echo "${id}"
echo "${pw}"

for ((i = 0; i < 1; i++)); do
    echo ""
    #echo "${id:i:1}"
    #delay=$((${id_millis[i+1]} - ${id_millis[i]}))
    #echo " ${id:i:2}: ${delay}"
done

read
