#!/bin/bash
# Script to run hephaestus in all modes for a specific amount of time
# Example usage:
#
# ./scripts/config.sh /home/thalia/coverage/jacoco/ /home/thalia/.sdkman/
# The we can run hephaestus
# ./scripts/hephaestus_run.sh lang time result

hephaestus="python /home/thalia/hephaestus/hephaestus.py"

# Check for the correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <lang> <time> <result>"
    exit 1
fi

lang="$1"
# seconds
time="$2" 
time=$((time / 3))
base_erase=$((time + time))
result="$3"

# Check if language is one of the specified values
case "$lang" in
    scala|kotlin|groovy)
        # valid language
        ;;
    *)
        echo "Error: Invalid language. Must be 'scala', 'kotlin', or 'groovy'."
        exit 1
        ;;
esac

echo "hephaestus base and erase"
$hephaestus --bugs $result \
    --name ${lang}_erase --language $lang \
    --seconds $base_erase --batch 10 --workers 2 --transformations 1 \
    --keep-all -P

echo "hephaestus inject"
$hephaestus --bugs $result \
    --name ${lang}_inject --language $lang \
    --seconds $time --batch 10 --workers 2 --transformations 0 \
    --keep-all 
