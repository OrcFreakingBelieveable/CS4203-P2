#!/bin/bash
output_file=$1
volunteer=$2
test_code=$3
repetitions=$4

for ((j = 0; j < $repetitions; j++)); do

    clear
    id=""                # string of at most 10 characters
    declare -a id_millis # the <=9 millisecond differences between the <=10 letters
    pw=""                # string of at most 20 characters
    declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
    id_index=0           # the actual length of the ID
    pw_index=0           # the actual length of the PW

    echo -n "$volunteer,$test_code" >>$output_file

    echo "Enter a user name"
    # read a single character
    while read -n1 key; do
        # if key = Escape key
        if [ $key == $'\e' ]; then
            break
        fi

        id=$id$key
        id_millis[$id_index]=$(date +%s%3N)

        ((id_index += 1))
        if [ $id_index -gt 9 ]; then
            break
        fi
    done

    echo -n ",$id" >>$output_file
    for ((i = 0; i < $id_index - 1; i++)); do
        delay=$((${id_millis[i + 1]} - ${id_millis[i]}))
        echo -n ",$delay" >>$output_file
    done
    for ((i = $id_index; i < 10; i++)); do
        echo -n "," >>$output_file
    done
    echo ""

    echo "Enter a password"
    # read a single character
    while read -n1 key; do
        # if key = Escape key
        if [ $key == $'\e' ]; then
            break
        fi

        pw=$pw$key
        pw_millis[$pw_index]=$(date +%s%3N)

        ((pw_index += 1))
        if [ $pw_index -gt 19 ]; then
            break
        fi
    done

    echo -n ",$pw" >>$output_file
    for ((i = 0; i < $pw_index - 1; i++)); do
        delay=$((${pw_millis[i + 1]} - ${pw_millis[i]}))
        echo -n ",$delay" >>$output_file
    done
    for ((i = $pw_index; i < 20; i++)); do
        echo -n "," >>$output_file
    done

    echo ""
    echo "" >>$output_file

done
