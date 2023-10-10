#!/bin/bash
# Script to get coverage for a single library
# Example usage:
#
# First we need to load set the system variables
# ./scripts/config.sh /home/thalia/coverage/jacoco/ /home/thalia/.sdkman/
# The we can compute the coverage
# ./scripts/compute_coverage.sh example-libraries scala-bugs results/scala scala
# This will produce the following:
#
# tree results/scala
#

# Check for the correct number of arguments
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <pom-directory> <programs> <results> <language>"
    exit 1
fi

pom="$1"
programs="$2"
results="$3"
language="$4"

# Check if pom is a directory
if [ ! -d "$pom" ]; then
    echo "Error: $pom is not a directory."
    exit 1
fi

if [ ! -d "$programs" ]; then
    echo "Error: $programs is not a directory."
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

# Loop over every file in the programs path
for mode_path in "$programs"/*; do
    project_name_mode=${mode_path#*//}
    project_name=${project_name_mode%-*}
    project_name=$(basename $project_name)
    if [ -d "$mode_path" ]; then
        # Extract the mode from the file name
        mode=$(basename "$mode_path" | awk -F'-' '{print $NF}')
        # Add the mode to the associative array
        classpath=$(mvn -f ${pom}/${project_name}/pom.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
        depspath=$(mvn -f ${pom}/${project_name}/dependency.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)
        classpath="$classpath:$depspath"

        # Check if the mode is one of the specified strings
        case "$mode" in
            base|both|erase|inject)
                echo "Processing: ${mode_path}/generator/"
                mode_results=$results/$project_name/res/$project_name_mode
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
                        command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $KOTLIN_JAR:$classpath org.jetbrains.kotlin.cli.jvm.K2JVMCompiler -classpath $classpath -nowarn $program_path" 
                    fi
                    eval "$command" 2> /dev/null
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

                echo "Merge results in $results/$project_name/res/$mode.exec"
                $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $exec_file_paths_single --destfile $results/$project_name/res/$mode.exec
                echo "Extract results in $results/$project_name/$mode.csv"
                $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $results/$project_name/res/$mode.exec --classfiles $SOURCES --csv $results/$project_name/$mode.csv
                ;;
            *)
                echo "Skipping: $mode_path (mode: $mode)"
                ;;
        esac
    fi
done

echo "Proceed to computing all and base-* for all projects"
for project in $(ls $results); do
    echo "Project: $project"
    project_path=$results/$project
    project_path_res=$project_path/res
    # all
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $project_path_res/*.exec --destfile $project_path_res/all.exec
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $project_path_res/all.exec --classfiles $SOURCES --csv $project_path/all.csv
    # base-both
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $project_path_res/{base,both}.exec --destfile $project_path_res/base-both.exec
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $project_path_res/base-both.exec --classfiles $SOURCES --csv $project_path/base-both.csv
    # base-erase
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $project_path_res/{base,erase}.exec --destfile $project_path_res/base-erase.exec
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $project_path_res/base-erase.exec --classfiles $SOURCES --csv $project_path/base-erase.csv
    # base-inject
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $project_path_res/{base,inject}.exec --destfile $project_path_res/base-inject.exec
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $project_path_res/base-inject.exec --classfiles $SOURCES --csv $project_path/base-inject.csv
done

# Merge all libraries into $results/combination
echo "Proceed to merging all projects"
modes="all base both erase inject base-both base-erase base-inject"
mkdir -p $results/combination/res
for mode in $modes; do
    echo "Merge results in $results/combination/res/$mode.exec"
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $results/*/res/$mode.exec --destfile $results/combination/res/$mode.exec
    echo "Extract results in $results/combination/$mode.csv"
    $JAVA_11 -jar $JACOCO/lib/jacococli.jar report $results/combination/res/$mode.exec --classfiles $SOURCES --csv $results/combination/$mode.csv
done
