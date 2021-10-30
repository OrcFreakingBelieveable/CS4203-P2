#!/bin/bash
# usage $ ./Baselines.sh <volunteer>
output_file="Baselines.csv"
volunteer=$1
test_code=0
ids=("aaaaa" "edward" "jc311" "MrBig")
passwords=("123456789" "wedfvbghyu" "Password1" "s3cr3t")

for ((tc = 0; tc < 4; tc++)); do  # 4 test cases
    for ((r = 0; r < 5; r++)); do # 5 repetitions to establish a baseline
        clear

        id=""                # string of at most 10 characters
        declare -a id_millis # the <=9 millisecond differences between the <=10 letters
        pw=""                # string of at most 20 characters
        declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
        id_index=0           # the actual length of the ID
        pw_index=0           # the actual length of the PW

        echo -n "$volunteer,$test_code,$tc,0" >>$output_file

        echo "Type ${ids[tc]}, then press the Esc key"
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

        # add ID and keystroke dynamics to CSV
        echo -n ",$id" >>$output_file
        for ((i = 0; i < $id_index - 1; i++)); do
            delay=$((${id_millis[i + 1]} - ${id_millis[i]}))
            echo -n ",$delay" >>$output_file
        done
        for ((i = $id_index; i < 10; i++)); do
            echo -n "," >>$output_file
        done
        echo ""

        echo "Type ${passwords[tc]}, then press the Esc key"
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

        # add PW and keystroke dynamics to CSV
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
done
