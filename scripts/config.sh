#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <jacoco> <sdkman>"
    exit 1
fi

jacoco="$1"
sdkman="$2"

export KOTLIN_JAR=${sdkman}/candidates/kotlin/1.8.20/lib/kotlin-compiler.jar
export JACOCO=${jacoco}
export JAVA_8=${sdkman}/candidates/java/8.0.265-open/bin/java
export JAVA_11=${sdkman}/candidates/java/11.0.11-open/bin/java
export GROOVY_JAR=${sdkman}/candidates/groovy/4.0.12/lib/groovy-4.0.12.jar
export SCALA_CP=$(find ${sdkman}/candidates/scala/current/lib/ -maxdepth 1 -type f -printf "%p:")
export SCALA_JAR="${sdkman}/candidates/scala/current"
