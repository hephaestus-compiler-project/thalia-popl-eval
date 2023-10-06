#! /bin/bash
#

groovy_size=$1/groovy-size.csv
if [ ! -f $groovy_size ]; then
  echo "Cannot find $groovy_size file"
  exit 1
fi

kotlin_size=$1/kotlin-size.csv
if [ ! -f $kotlin_size ]; then
  echo "Cannot find $kotlin_size file"
  exit 1
fi

scala_size=$1/scala-size.csv
if [ ! -f $scala_size ]; then
  echo "Cannot find $scala_size" file
  exit 1
fi

compute_metrics()
{
  local file=$1
  base=$(basename $file)
  local lang=$(echo "$base" | cut -d'-' -f1)

  awk -F',' -v var=$lang '
  BEGIN {
    sum1 = 0
    sum2 = 0
    count = 0
  }
  NR > 1 {
    sum1 += $1
    sum2 += $2
    count++
  }
  END {
    printf "(%s) Average size in kB: %.2f\n", var, sum1/count
    printf "(%s) Average size in LoC: %.0f\n", var, sum2/count
  }' $file
}

compute_metrics $groovy_size
echo
compute_metrics $kotlin_size
echo
compute_metrics $scala_size
