#! /bin/bash

outfile=$2
pardir=$(dirname $outfile)
mkdir -p $pardir

echo "package,mode,files" > $outfile

for libdir in $1/*; do
  base=$(basename $libdir)
  lib="${base%-*}"
  mode="${base##*-}"
  echo "$lib,$mode,$(ls $libdir/generator | wc -l)" >> "$outfile"
done
