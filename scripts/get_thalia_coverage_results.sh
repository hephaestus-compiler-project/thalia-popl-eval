#!/bin/bash
# Check for the correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <initial-coverage> <target> <language>"
    exit 1
fi

initial=$1
target=$2/results
language=$3

mkdir -p $target

cp $initial/all.csv $target/${language}-all.csv
cp $initial/base.csv $target/${language}-base.csv
cp $initial/both.csv $target/${language}-both.csv
cp $initial/erase.csv $target/${language}-erase.csv
cp $initial/inject.csv $target/${language}-inject.csv
