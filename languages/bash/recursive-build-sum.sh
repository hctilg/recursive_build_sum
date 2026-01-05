#!/bin/bash

# Recursive Build Sum Algorithm in Bash

# Global arrays
declare -a ARR
declare -a USED

find_sum() {
    local value=$1
    local index=$2
    local sum=$3
    local len=${#ARR[@]}

    if (( index < 0 )); then
        if (( value == 0 )); then
            local result=""
            for (( i = len - 1; i >= 0; i-- )); do
                if [[ "${USED[$i]}" == "true" ]]; then
                    result+="${ARR[$i]}+"
                fi
            done
            # Remove trailing + and add =sum
            result="${result%+}=$sum"
            echo "$result"
        fi
        return
    fi

    if (( value == ARR[index] )); then
        USED[$index]="true"
        find_sum 0 $((index - 1)) $sum

        USED[$index]="false"
        find_sum $value $((index - 1)) $sum
    elif (( value < ARR[index] )); then
        USED[$index]="false"
        find_sum $value $((index - 1)) $sum
    elif (( value > ARR[index] )); then
        USED[$index]="true"
        find_sum $((value - ARR[index])) $((index - 1)) $sum

        USED[$index]="false"
        find_sum $value $((index - 1)) $sum
    fi
}

# Main
read -p "please type the size of array : " n

read -p "type your array numbers: " -a numbers

for (( i = 0; i < n; i++ )); do
    USED[$i]="false"
done

read -p "please type your sum that we will try to build it with array numbers : " sum

# Sort the array and store in ARR
IFS=$'\n' ARR=($(sort -n <<<"${numbers[*]}")); unset IFS

find_sum $sum $((n - 1)) $sum
