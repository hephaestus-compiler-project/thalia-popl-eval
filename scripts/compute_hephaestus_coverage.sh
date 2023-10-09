#!/bin/bash
# Script to get coverage for a single library
# Example usage:
#
# First we need to load set the system variables
# ./scripts/config.sh /home/thalia/coverage/jacoco/ /home/thalia/.sdkman/
# The we can compute the coverage
# ./scripts/compute_hephaestus_coverage.sh hephaestus_groovy coverage_example/hephaestus groovy

# Check for the correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <programs> <results> <language>"
    exit 1
fi

programs="$1"
results="$2"
language="$3"

if [ ! -d "$programs" ]; then
    echo "Error: $programs is not a directory."
    exit 1
fi

# Check if results path already exists
if [ -e "$results" ]; then
    echo "Error: $results path already exists."
    exit 1
fi

# List of required environment variables
required_env_vars=("KOTLIN_JAR" "JACOCO" "JAVA_8" "JAVA_11" "GROOVY_JAR" "SCALA_CP" "SCALA_JAR")

# Loop through each variable and check if it's set and not empty
for var in "${required_env_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set or is empty."
        exit 1
    fi
done

# Check if language is one of the specified values
case "$language" in
    scala|kotlin|groovy)
        # valid language
        ;;
    *)
        echo "Error: Invalid language. Must be 'scala', 'kotlin', or 'groovy'."
        exit 1
        ;;
esac

case "$language" in
    kotlin)
        program_template="program.kt"
        ;;
    scala)
        program_template="program.scala"
        ;;
    groovy)
        program_template="Main.groovy"
        ;;
    *)
        echo "Error: Invalid language. Must be 'scala', 'kotlin', or 'groovy'."
        exit 1
        ;;
esac

if [ "$language" = "scala" ]; then
    SOURCES=$SCALA_JAR
elif [ "$language" = "kotlin" ]; then
    SOURCES=$KOTLIN_JAR
elif [ "$language" = "groovy" ]; then
    SOURCES=$GROOVY_JAR
else
    echo "Unknown lang: $language"
    exit 1
fi

# Results dir:
# ${results}/results/$lang-{all,base,inject,erase}.csv
# ${results}/inter/$lang/{base,inject,erase}/$iter.exec
# ${results}/inter/$lang-{all,base,inject,erase}.exec
mkdir -p $results
mkdir -p $results/results
mkdir -p $results/inter/$language

#heph_groovy/erase/generator/iter_1/
process_files() {
    local result="$1"
    local mode="$2"
    local temp_mode="$mode"
    local language="$3"

    if [ "$mode" == "base" ]; then
        temp_mode="erase"
    fi
    if [ "$mode" = "erase" ]; then
        local mode_programs=$programs/$temp_mode/transformations/
    else
        local mode_programs=$programs/$temp_mode/generator/
    fi
    # Loop through the files in $mode_path/generator
    echo "Processing: $mode_programs"
    for iter in $(ls $mode_programs); do
        if [ "$mode" = "erase" ]; then
            local program_path="$mode_programs/$iter/0/$program_template"
        else
            local program_path="$mode_programs/$iter/$program_template"
        fi
        if [ ! -f "$program_path" ]; then
            echo "Skipping: $program_path (Does not exist)"
            continue
        fi
        target=$result/inter/$language/${mode}/${iter}.exec
        if [ "$language" = "scala" ]; then
            command="$JAVA_11 -Xmx768m -Xms768m -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -classpath $SCALA_CP -Dscala.usejavacp=true -Dscala.home=$SCALA_JAR dotty.tools.MainGenericCompiler $program_path"
        elif [ "$language" = "groovy" ]; then
            command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $GROOVY_JAR org.codehaus.groovy.tools.FileSystemCompiler --compile-static $program_path"
        else
            command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $KOTLIN_JAR org.jetbrains.kotlin.cli.jvm.K2JVMCompiler -nowarn $program_path"
        fi
        eval "$command"
    done
    echo "Done Processing: $programs/$mode/generator/"
    
    # Get full paths of all files in the merger directory
    exec_file_paths=$(find $result/inter/$language/${mode} -type f)
    exec_file_paths_single=$(echo $exec_file_paths | tr '\n' ' ')

    echo "Merge results in $result/inter/${language}-${mode}.exec"
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $exec_file_paths_single --destfile $result/inter/${language}-${mode}.exec
    echo "Extract results in $result/results/${language}-${mode}.csv"
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $result/inter/${language}-${mode}.exec --classfiles $SOURCES --csv $result/results/${language}-${mode}.csv
}

process_files $results "base" $language
process_files $results "erase" $language
process_files $results "inject" $language

echo "Merge all"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $results/inter/${language}-base.exec \
     $results/inter/${language}-erase.exec \
     $results/inter/${language}-inject.exec \
     --destfile $results/inter/${language}-all.exec
echo "Extracting all"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report $results/inter/${language}-all.exec \
    --classfiles $SOURCES --csv $results/results/${language}-all.csv
