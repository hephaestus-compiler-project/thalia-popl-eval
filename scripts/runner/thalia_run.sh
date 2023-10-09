#! /bin/bash
# Example run:
# ./runner_scripts/thalia_run.sh stdlib/kotlin-stdlib/json-docs/ example-libraries/ kotlin-bugs "--language kotlin" apache-commons-lang3
# ./runner_scripts/thalia_run.sh stdlib/kotlin-stdlib/json-docs/ example-libraries/ kotlin-bugs "--language kotlin"

basedir=$(dirname "$0")
stdlib=$1
libpath=$2
bugs=$3
args=$4
libname=$5

thalia="python /home/thalia/thalia/thalia.py"

run_thalia()
{
  local libpath=$1
  local libname=$(basename $libpath)
  local bugs=$2
  local args=$3

  if [[ ! -d "$libpath/json-docs" || -z $(find "$libpath/json-docs" -mindepth 1 -print -quit) ]]; then
    # Create API specification from javadoc
    language=java
    if grep -q -oP "\-\-language scala" <<< "$args"; then
      language=scala
    fi
    doc2json.sh -d "$(dirname $libpath)" -l $libname -L "$language"
    if [ $? -ne 0 ]; then
      return 1
    fi
  fi

  rm -rf libs

  # Create a directory containing API docs (in JSON format) coming from
  # the given stdlib and library being exercised.
  mkdir libs

  if [ -f $libpath/pom.xml ]; then
    # This is an external lib; so add it on top of stdlib
    cp $stdlib/* libs
  fi
  cp $libpath/json-docs/* libs

  if [ -f $libpath/pom.xml ]; then
    rm -rf ~/.m2
    mvn -f  $libpath/pom.xml dependency:tree -q
    mvn -f $libpath/dependency.xml dependency:tree -q

    classpath=$(mvn -f $libpath/pom.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
    depspath=$(mvn -f $libpath/dependency.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
    classpath="$classpath:$depspath"
  else
    classpath="$(pwd)"
  fi

  rulespath=$libpath/api-rules.json
  if [ ! -f $rulespath ]; then
    # Create api-rules.json based on common prefix
    ls $libpath/json-docs | $basedir/create-api-rules.py > $rulespath
  fi

  base_args="--batch 30 -P -L --transformations 0 \
    --max-depth 2 --generator api -k \
    --library-path "$classpath" --api-doc-path libs --api-rules $rulespath \
    --max-conditional-depth 3 --bugs $bugs $args"

  if [ ! -d $bugs/$libname-base ]; then
    echo " - base mode..."
    echo "$base_args --name $libname-base" | xargs $thalia > /dev/null
  fi
  if [ ! -d $bugs/$libname-erase ]; then
    echo " - type erasure mode (well-typed)..."
    echo "$base_args --name $libname-erase --erase-types" | xargs $thalia > /dev/null
  fi
  if [ ! -d $bugs/$libname-inject ]; then
    echo " - ill-typed mode..."
    echo "$base_args --name $libname-inject --inject-type-error" | xargs $thalia > /dev/null
  fi
  if [ ! -d $bugs/$libname-both ]; then
    echo " - type erasure mode (ill-typed)..."
    echo "$base_args --name $libname-both --erase-types --inject-type-error" | xargs $thalia > /dev/null
  fi
}

if [ -z $libpath ]; then
  echo "You need to specify the library path"
  exit 1
fi

if [ -z $stdlib ]; then
  echo "You need to specify the path for stdlib"
  exit 1
fi

if [ -z $bugs ]; then
    bugs="bugs"
fi

if [ ! -z $libname ]; then
  echo "Testing library $libname"
  run_thalia "$libpath/$libname" "$bugs" "$args"
  exit 0
fi

# Explore directories and run thalia
for lib in $libpath/*; do
    echo "Testing library $(basename $lib)"
    run_thalia "$lib" "$bugs" "$args"
done
