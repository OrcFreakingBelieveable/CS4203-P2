#!/bin/bash
# usage $ ./Experiment2.sh <volunteer>
output_file="Experiment1.csv"
volunteer=$1
test_codes=(1 4 5 6 7)
test_descriptions=( "with no impediment" "with taped fingers" "with your non-dominant hand" "whilst standing" "with cold hands")
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
    for ((i = $pw_index; i < 20; i++)); do
        echo -n "," >>$output_file
    done
    
}

for ((test_code = 0; test_code < 5; test_code++)); do       # 5 impediments
    for ((test_case = 0; test_case < 4; test_case++)); do   # 4 test cases
        for ((r = 0; r < 3; r++)); do                       # 3 repetitions to attempt to log in
            clear
            
            id=""                # string of at most 10 characters
            declare -a id_millis # the <=9 millisecond differences between the <=10 letters
            pw=""                # string of at most 20 characters
            declare -a pw_millis # the <=19 millisecond differences between the <=20 letters
            id_index=0           # the actual length of the ID
            pw_index=0           # the actual length of the PW
            
            echo -n "$volunteer,2,$test_case,${test_codes[test_code]}" >>$output_file
            
            echo "Type \"${ids[test_case]}\" ${test_descriptions[test_code]}, then press the Esc key"
            readID
            
            echo "Type \"${passwords[test_case]}\" ${test_descriptions[test_code]}, then press the Esc key"
            readPW
            
            echo "" >>$output_file  # end of line
            
            # if ID or password were incorrect then allow another attempt - timings will be exluded from analysis
            if [[ "$id" != "${ids[test_case]}" || "$pw" != "${passwords[test_case]}" ]]; then
                ((r--))
            fi
        done
    done
done