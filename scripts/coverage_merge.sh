#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <hephaestus> <thalia> <target> <language>"
    exit 1
fi

heph_res="$1"
thalia_res="$2"
target_res="$3"
language="$4"

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

mkdir -p $target_res/res

#groovy-all.exec  groovy-base.exec  groovy-erase.exec  groovy-inject.exec
#all.csv          base-both.csv    base.csv         base-erase.csv   base-inject.csv  both.csv         erase.csv        inject.csv       res/
echo "Merge base"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $heph_res/${language}-base.exec $thalia_res/base.exec --destfile $target_res/res/$language-base.exec
echo "Extract base"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report $target_res/res/$language-base.exec --classfiles $SOURCES --csv $target_res/$language-base.csv
echo "Merge all"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $heph_res/${language}-all.exec $thalia_res/all.exec --destfile $target_res/res/$language-all.exec
echo "Extract all"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report $target_res/res/$language-all.exec --classfiles $SOURCES --csv $target_res/$language-all.csv
echo "Merge erase"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $heph_res/${language}-erase.exec $thalia_res/erase.exec --destfile $target_res/res/$language-erase.exec
echo "Extract erase"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report $target_res/res/$language-erase.exec --classfiles $SOURCES --csv $target_res/$language-erase.csv
echo "Merge inject"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $heph_res/${language}-inject.exec $thalia_res/inject.exec --destfile $target_res/res/$language-inject.exec
echo "Extract inject"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report $target_res/res/$language-inject.exec --classfiles $SOURCES --csv $target_res/$language-inject.csv
