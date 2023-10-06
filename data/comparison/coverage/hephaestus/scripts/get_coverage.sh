#!/bin/bash
KOTLIN_JAR=/home/ubuntu/.sdkman/candidates/kotlin/1.8.20/lib/kotlin-compiler.jar
JACOCO=/home/ubuntu/coverage/jacoco
JAVA_8=/home/ubuntu/.sdkman/candidates/java/8.0.265-open/bin/java
JAVA_11=/home/ubuntu/.sdkman/candidates/java/11.0.2-open/bin/java
GROOVY_JAR=/home/ubuntu/.sdkman/candidates/groovy/4.0.12/lib/groovy-4.0.12.jar
SCALA_CP="/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-library-2.13.10.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-library_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala-asm-9.4.0-scala-1.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/compiler-interface-1.3.5.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-interfaces-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-compiler_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/tasty-core_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-staging_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/scala3-tasty-inspector_3-3.3.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-reader-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jline-terminal-jna-3.19.0.jar:/home/ubuntu/.sdkman/candidates/scala/current/lib/jna-5.3.1.jar::"
SCALA_JAR="/home/ubuntu/.sdkman/candidates/scala/current"
coverage_dir="coverage_programs"
results=results
final=final

mkdir -p $final

languages=("kotlin" "groovy" "scala")
for lang in "${languages[@]}"
do
	echo $lang
	$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $results/${lang}_tom_* --destfile $final/${lang}-inject.exec
	$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $results/${lang}_tem_* --destfile $final/${lang}-erase.exec
	$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $results/${lang}_gen_* --destfile $final/${lang}-base.exec
	$JAVA_11 -jar $JACOCO/lib/jacococli.jar merge $final/${lang}-{inject,erase,base}.exec --destfile $final/${lang}-all.exec
done
