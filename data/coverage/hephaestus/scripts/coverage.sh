KOTLIN_JAR=/home/ubuntu/.sdkman/candidates/kotlin/1.8.20/lib/kotlin-compiler.jar
JACOCO=/home/ubuntu/coverage/jacoco
JAVA_8=/home/ubuntu/.sdkman/candidates/java/8.0.265-open/bin/java
JAVA_11=/home/ubuntu/.sdkman/candidates/java/11.0.2-open/bin/java
GROOVY_JAR=/home/ubuntu/.sdkman/candidates/groovy/4.0.12/lib/groovy-4.0.12.jar
SCALA_CP="/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-library-2.13.10.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-library_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-asm-9.4.0-scala-1.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/compiler-interface-1.3.5.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-interfaces-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-compiler_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/tasty-core_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-staging_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-tasty-inspector_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-reader-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-jna-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jna-5.3.1.jar::"
SCALA_JAR="/home/ubuntu/.sdkman/candidates/scala/current"
coverage_dir="coverage_programs"
results=results

mkdir -p $results


# Loop through each file in the coverage_programs directory
for name in $(ls $coverage_dir); do
    if [[ -d "$coverage_dir/$name" ]]; then
        # Extract the language from the file name
        lang=$(basename "$name" | cut -d "_" -f 1)
        #if [ "$lang" = "groovy" ] || [ "$lang" = "kotlin" ]; then
        #       echo "Skip $lang"
        #       continue
        #fi

        # Extract the mode from the file name
        mode=$(basename "$name" | cut -d "_" -f 2)

        echo "Language: $lang, Mode: $mode"
        # Find the maximum iter number
        max_iter=$(find "$coverage_dir/$name/"generator -name 'iter_*' -type d | awk -F'_' '{print $NF}' | sort -n | tail -n 1)
        echo $max_iter
        # Execute coverage command for each range of iter numbers
        iter=1
        while (( iter <= max_iter )); do
                start_iter=$iter
                end_iter=$((iter + 44))
                if (( end_iter > max_iter )); then
                  end_iter=$max_iter
                fi

                if [ "$lang" = "scala" ]; then
                        incorrect="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/incorrect.scala"
                        program="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/program.scala"
                elif [ "$lang" = "groovy" ]; then
                        incorrect="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/incorrect.groovy"
                        program="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/Main.groovy"
                else
                        incorrect="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/incorrect.kt"
                        program="$coverage_dir/$name/generator/iter_{${start_iter}..${end_iter}}/program.kt"
                fi
                if [[ -e "$incorrect" ]]; then
                        program=$incorrect
                        echo $program
                fi

                target="$results/${lang}_${mode}_${iter}.exec"
                if [ "$lang" = "scala" ]; then
                        command="$JAVA_11 -Xmx768m -Xms768m -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -classpath $SCALA_CP -Dscala.usejavacp=true -Dscala.home=$SCALA_JAR dotty.tools.MainGenericCompiler $program"
                elif [ "$lang" = "groovy" ]; then
                        command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $GROOVY_JAR org.codehaus.groovy.tools.FileSystemCompiler --compile-static $program"
                else
                        command="$JAVA_11 -javaagent:$JACOCO/lib/jacocoagent.jar=destfile=$target -cp $KOTLIN_JAR org.jetbrains.kotlin.cli.jvm.K2JVMCompiler $program"
                fi
                echo $command
                eval "$command"
                iter=$((end_iter + 1))
        done
    fi
done
