#!/bin/bash
# Script to get coverage for a single library
# Example usage:
#
# First we need to load set the system variables
# ./scripts/config.sh /home/thalia/coverage/jacoco/ /home/thalia/.sdkman/
# The we can compute the coverage
# ./scripts/compute_coverage.sh example-scala-programs/guava/pom.xml example-scala-programs/guava/programs results/guava scala
# This will produce the following:
#
# tree results/guave
#

# Check for the correct number of arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <pom> <dependency-pom> <programs> <results> <language>"
    exit 1
fi

pom="$1"
dependency="$2"
programs="$3"
results="$4"
language="$5"

# Check if pom and dependency are files and programs is a directory
if [ ! -f "$pom" ]; then
    echo "Error: $pom is not a file."
    exit 1
fi

if [ ! -f "$dependency" ]; then
    echo "Error: $dependency is not a file."
    exit 1
fi

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
# ${results}/${mode}/${iter}.exec
# ${results}/${mode}.exec
# ${results}/${mode}.csv
# ${results}/all.exec
# ${results}/all.csv
mkdir -p $results
    
classpath=$(mvn -f $pom dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
depspath=$(mvn -f $dependency dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
classpath="$classpath"

# Loop over every file in the programs path
for mode_path in "$programs"/*; do
    if [ -d "$mode_path" ]; then
        # Extract the mode from the file name
        mode=$(basename "$mode_path" | awk -F'-' '{print $NF}')

        # Check if the mode is one of the specified strings
        case "$mode" in
            base|both|erase|inject)
                echo "Processing: ${mode_path}/generator/"
                mode_results=$results/$mode
                mkdir -p $mode_results
                # Loop through the files in $mode_path/generator
                for iter in $(ls $mode_path/generator/); do
                    program_path="$mode_path/generator/$iter/$program_template"
                    target=${mode_results}/${iter}.exec
                    if [ "$language" = "scala" ]; then
                        command="$JAVA_11 -Xmx768m -Xms768m -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -classpath $SCALA_CP:$classpath -Dscala.usejavacp=true -Dscala.home=$SCALA_JAR dotty.tools.MainGenericCompiler $program_path"
                    elif [ "$language" = "groovy" ]; then
                        command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $GROOVY_JAR:$classpath org.codehaus.groovy.tools.FileSystemCompiler --compile-static $program_path"
                    else
                        command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $KOTLIN_JAR:$classpath org.jetbrains.kotlin.cli.jvm.K2JVMCompiler $program_path"
                    fi
                    eval "$command"
                    if [ ! -f "$program_path" ]; then
                        echo "Skipping: $program_path (Does not exist)"
                        continue
                    fi
                done
                echo "Done Processing: ${mode_path}/generator/"
                # Get full paths of all files in the merger directory
                exec_file_paths=$(find $mode_results -type f)
                # If you want them in a single variable separated by spaces:
                exec_file_paths_single=$(echo $exec_file_paths | tr '\n' ' ')

                echo "Merge results in $results/$mode.exec"
                $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $exec_file_paths_single --destfile $results/$mode.exec
                echo "Extract results in $results/$mode.csv"
                $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $results/$mode.exec --classfiles $SOURCES --csv $results/$mode.csv
                ;;
            *)
                echo "Skipping: $mode_path (mode: $mode)"
                ;;
        esac
    fi
done
