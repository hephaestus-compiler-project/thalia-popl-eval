#!/bin/bash
KOTLIN_JAR=/home/ubuntu/.sdkman/candidates/kotlin/1.8.20/lib/kotlin-compiler.jar
JACOCO=/home/ubuntu/coverage/
JAVA_8=/home/ubuntu/.sdkman/candidates/java/8.0.265-open/bin/java
JAVA_11=/home/ubuntu/.sdkman/candidates/java/11.0.2-open/bin/java
GROOVY_JAR=/home/ubuntu/.sdkman/candidates/groovy/4.0.12/lib/groovy-4.0.12.jar
SCALA_CP="/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-library-2.13.10.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-library_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-asm-9.4.0-scala-1.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/compiler-interface-1.3.5.jar:/home/ubuntu/.sdkman/candidates/scala/curren
t/lib/scala3-interfaces-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-compiler_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/tasty-core_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-staging_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-tasty-inspector_3-3.3.0.jar:/home/ubuntu/.sdk
man/candidates/scala/current/lib/jline-reader-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-jna-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jna-5.3.1.jar::"
SCALA_JAR="/home/ubuntu/.sdkman/candidates/scala/current"
final=final


lang=$1
if [ "$lang" = "scala" ]; then
    SOURCES=$SCALA_JAR
elif [ "$lang" = "kotlin" ]; then
    SOURCES=$KOTLIN_JAR
elif [ "$lang" = "groovy" ]; then
    SOURCES=$GROOVY_JAR
else
    echo "Unknown lang: $lang"
    exit 1
fi

runs="com-fasterxml-jackson-core-jackson-databind-base    com-google-guava-guava-both              org-mockito-mockito-core-both    org-slf4j-slf4j-api-erase
com-fasterxml-jackson-core-jackson-databind-both    com-google-guava-guava-erase           org-mockito-mockito-core-erase   org-slf4j-slf4j-api-inject
com-fasterxml-jackson-core-jackson-databind-erase   com-google-guava-guava-inject          org-mockito-mockito-core-inject
com-fasterxml-jackson-core-jackson-databind-inject  org-apache-commons-commons-lang3-base  org-slf4j-slf4j-api-base
com-google-guava-guava-base                         org-mockito-mockito-core-base          org-slf4j-slf4j-api-both"

# Initialize variables
base=""
both=""
erase=""
inject=""

for line in $runs; do
    # Split the line by whitespace into library and mode
    read -r library <<< "$line"

    # Extract the library name (before the last hyphen)
    library_name="${library%-*}"

    # Extract the mode (after the last hyphen)
    mode="${library##*-}"

    # Create the corresponding variable with the desired string
    case "$mode" in
        base)
            base="$base final/$library_name/base.exec"
            ;;
        both)
            both="$both final/$library_name/both.exec"
            ;;
        erase)
            erase="$erase final/$library_name/erase.exec"
            ;;
        inject)
            inject="$inject final/$library_name/inject.exec"
            ;;
        *)
            echo "Unknown mode: $mode"
            ;;
    esac
done

mkdir thalia
mkdir thalia-res

# Print the values of the variables
echo "base: $base"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $base --destfile thalia/${lang}-base.exec
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report thalia/${lang}-base.exec --classfiles $SOURCES --csv thalia-res/${lang}-base.csv
echo "erase: $erase"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $erase --destfile thalia/${lang}-erase.exec
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report thalia/${lang}-erase.exec --classfiles $SOURCES --csv thalia-res/${lang}-erase.csv
echo "inject: $inject"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $inject --destfile thalia/${lang}-inject.exec
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report thalia/${lang}-inject.exec --classfiles $SOURCES --csv thalia-res/${lang}-inject.csv
echo "both: $both"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $both --destfile thalia/${lang}-both.exec
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report thalia/${lang}-both.exec --classfiles $SOURCES --csv thalia-res/${lang}-both.csv
echo "all: $both"
$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge thalia/${lang}-base.exec thalia/${lang}-erase.exec thalia/${lang}-inject.exec thalia/${lang}-both.exec --destfile thalia/${lang}-all.exec
$JAVA_11 -jar $JACOCO/lib/jacococli.jar report thalia/${lang}-all.exec --classfiles $SOURCES --csv thalia-res/${lang}-all.csv
