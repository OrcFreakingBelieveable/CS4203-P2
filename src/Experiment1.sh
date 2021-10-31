#!/bin/bash
# usage $ ./Experiment1.sh <test case>
output_file="Experiment1.csv"
test_case=$1
ids=("aaaaa" "edward" "jc311" "MrBig")
passwords=("123456789" "wedfvbghyu" "Password1" "s3cr3t")

function readID {
    # read ID
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
    
    echo ""
    
    # add ID and keystroke dynamics to CSV
    echo -n ",$id" >>$output_file
    for ((i = 0; i < $id_index - 1; i++)); do
        delay=$((${id_millis[i + 1]} - ${id_millis[i]}))
        echo -n ",$delay" >>$output_file
    done
    for ((i = $id_index; i < 10; i++)); do
        echo -n "," >>$output_file
    done
}

function readPW {
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
    
    echo ""
    
    echo -n ",$pw" >>$output_file
    for ((i = 0; i < $pw_index - 1; i++)); do
        delay=$((${pw_millis[i + 1]} - ${pw_millis[i]}))
        echo -n ",$delay" >>$output_file
    done
    for ((i = $pw_index; i < 19; i++)); do
        echo -n "," >>$output_file
    done
    
}

# get baseline from one volunteer
test_code=2
volunteer=test_case
for ((r = 0; r < 5; r++)); do # 5 repetitions to set the baseline
    clear
    
    id=""                # string of at most 10 characters
    declare -a id_millis # the <=9 millisecond differences between the <=10 letters
    pw=""                # string of at most 20 characters
    declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
    id_index=0           # the actual length of the ID
    pw_index=0           # the actual length of the PW
    
    echo -n "$volunteer,1,$test_case,$test_code" >>$output_file
    
    echo "Volunteer $volunteer, please choose a rhythm to type to and stick with it"
    
    echo "Type \"${ids[test_case]}\", then press the Esc key"
    readID
    
    echo "Type \"${passwords[test_case]}\", then press the Esc key"
    readPW
    
    echo "" >>$output_file  # end of line
    
    # if ID or password were incorrect then allow another attempt - timings will be exluded from analysis
    if [[ "$id" != "${ids[test_case]}" || "$pw" != "${passwords[test_case]}" ]]; then
        ((r--))
    fi
done

# all volunteers attempt to mimic the baseline
test_code=3
for ((v = 0; v < 4; v++)); do
    for ((r = 0; r < 5; r++)); do # 3 attempts to mimic the baseline
        clear
        
        id=""                # string of at most 10 characters
        declare -a id_millis # the <=9 millisecond differences between the <=10 letters
        pw=""                # string of at most 20 characters
        declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
        id_index=0           # the actual length of the ID
        pw_index=0           # the actual length of the PW
        
        echo -n "$v,$test_code,$test_case,1" >>$output_file
        
        echo "Volunteer $v, please choose a rhythm to type to and stick with it"
        
        echo "Type ${ids[test_case]} with, then press the Esc key"
        readID
        
        echo "Type ${passwords[test_case]}, then press the Esc key"
        readPW
        
        echo "" >>$output_file  # end of line
        
        # if ID or password were incorrect then allow another attempt - timings will be exluded from analysis
        if [[ "$id" != "${ids[test_case]}" || "$pw" != "${passwords[test_case]}" ]]; then
            ((r--))
        fi
    done
done
