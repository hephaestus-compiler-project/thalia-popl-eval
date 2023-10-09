# Artifact for "API-driven Program Synthesis for Testing Static Typing Implementations (POPL'24)"

This artifact is for the POPL'24 paper titled
"API-driven Program Synthesis for Testing Static Typing Implementations".

An archived version of the artifact is also available on Zenodo.
See TODO.

# Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Setup](#setup)
- [Getting Started](#getting-started)
  * [Usage](#usage)
  * [Run Tests](#run-tests)
  * [Example: Testing the Groovy compiler using the API of its standard library](#example-testing-the-groovy-compiler-using-the-api-of-its-standard-library)
  * [Example: Testing the Groovy compiler using the API of a third-party library](#example-testing-the-groovy-compiler-using-the-api-of-a-third-party-library)
- [Step by Step Instructions](#step-by-step-instructions)
  * [Bug Database](#bug-database)
  * [Extracting Library APIs in JSON](#extracting-library-apis-in-json)
  * [RQ1: Bug-Finding Results (Section 4.2)](#rq1-bug-finding-results-section-42)
  * [RQ2: Test Case Characteristics (Section 4.3)](#rq2-test-case-characteristics-section-43)
  * [RQ3: Impact of Library Selection and Synthesis Modes](#rq3-impact-of-library-selection-and-synthesis-modes-section-44)
  * [RQ4: Comparison of Thalia vs. Hephaestus](#rq4-comparison-of-thalia-vs-hephaestus-section-45)

# Overview

The artifact contains the instructions and scripts to re-run the evaluation
described in our paper. The artifact has the following structure:

* `scripts/`: This directory contains the scripts needed to re-run the
experiments and re-produce the figures and tables presented in our paper.
* `data/`: This is the directory that contains the pre=computed results of our
evaluation.
* `data/packages.csv`: A CSV file that contains the 95 Maven libraries whose
APIs have been used in our evaluation.
* `database/bug_schema.sql`: This is the database schema that contains the bugs
discovered by our approach.
* `database/bugdb.sqlite3`: This is the `sqlite3` database file corresponding to
  our bug database.
* `database/bugs.json`: Our bug reports in a JSON format.
* `thalia/`: Contains the source code of our tool
(provided as a git submodule) used for testing the compilers of
Scala, Kotlin, and Groovy using API-driven program synthesis.
The name of our tool is `thalia`.
* `hephaestus/`: Contains the source code of the state-of-the-art
tool named `hephaestus` used for finding compiler typing bugs.
In our evaluation, we compare `thalia` with `hephaestus`.
* `doc2json/`: This is a submodule that contains
the source code of an auxiliary tool
used to convert API documentation pages into JSON documents.
More details can be found at: https://github.com/hephaestus-compiler-project/doc2json
* `installation_scripts/`: Contains helper scripts used to install all
dependencies (e.g., compiler versions from [SDKMAN](https://sdkman.io/)).
* `figures/`: This directory will be used to save the figures of our paper.
* `Dockerfile`: The Dockerfile used to create a Docker image of our artifact.
  This image contains all data and dependencies.

`thalia` is available as open-source software under the
GNU General Public License v3.0, and can also be reached through the following
repository: https://github.com/hephaestus-compiler-project/thalia.

Inside the `thalia` directory, there are the following directories:

* `src/`: The source code of `thalia` written in Python.
* `tests/`: Contains the tests of `thalia`.
* `example-apis/`: Example inputs of `thalia`. Our tool
takes as input an API specification in JSON.
* `deployment/`: Contains configuration and scripts to install and run
`thalia` on a server.

# Requirements

See [REQUIREMENTS.md](./REQUIREMENTS.md)

# Setup

See [INSTALL.md](./INSTALL.md)


# Getting Started

To get started with our `thalia` tool,
we use the Docker image (namely `thalia-eval`) built by
the instructions from the [Setup](#Setup) guide.
The image contains all the
required environments for running our evaluation (i.e., it includes
installations of the corresponding compilers, as well as any other tool
needed for processing the results).

You can enter a new container by using the following command:

```
docker run -ti --rm thalia-eval
```

## Usage


```
thalia@e0456a9b520e:~$ thalia --help
usage: thalia [-h] [-g {base,api}] [--api-doc-path API_DOC_PATH] [-s SECONDS] [-i ITERATIONS] [--api-rules API_RULES] [--library-path LIBRARY_PATH]
              [--max-conditional-depth MAX_CONDITIONAL_DEPTH] [--erase-types] [--inject-type-error] [--disable-expression-cache] [--path-search-strategy {shortest,ksimple}]
              [-t TRANSFORMATIONS] [--batch BATCH] [-b BUGS] [-n NAME] [-T [{TypeErasure} [{TypeErasure} ...]]] [--transformation-schedule TRANSFORMATION_SCHEDULE] [-R REPLAY] [-e] [-k]
              [-S] [-w WORKERS] [-d] [-r] [-F LOG_FILE] [-L] [-N] [--language {kotlin,groovy,java,scala}] [--max-type-params MAX_TYPE_PARAMS] [--max-depth MAX_DEPTH] [-P]
              [--timeout TIMEOUT] [--cast-numbers] [--disable-function-references] [--disable-use-site-variance] [--disable-contravariance-use-site] [--disable-bounded-type-parameters]
              [--disable-parameterized-functions] [--disable-sam] [--local-variable-prob LOCAL_VARIABLE_PROB] [--error-filter-patterns ERROR_FILTER_PATTERNS]

optional arguments:
  -h, --help            show this help message and exit
  -g {base,api}, --generator {base,api}
                        Type of generator
  --api-doc-path API_DOC_PATH
                        Path to API docs
  -s SECONDS, --seconds SECONDS
                        Timeout in seconds
  -i ITERATIONS, --iterations ITERATIONS
                        Iterations to run (default: 3)
  --api-rules API_RULES
                        File that contains the rules specifying the APIs used for program enumeration (used only with API-based program generation)
  --library-path LIBRARY_PATH
                        Path where the compiled library resides. (Used only with API-based program generation)
  --max-conditional-depth MAX_CONDITIONAL_DEPTH
                        Maximum depth of conditionals
  --erase-types         Erases types from the program while preserving its semantics
  --inject-type-error   Injects a type error in the generated program
  --disable-expression-cache
                        Stop caching expressions that yield certain types
  --path-search-strategy {shortest,ksimple}
                        Stategy for enumerating paths between two nodes
  -t TRANSFORMATIONS, --transformations TRANSFORMATIONS
                        Number of transformations in each round
  --batch BATCH         Number of programs to generate before invoking the compiler
  -b BUGS, --bugs BUGS  Set bug directory (default: bugs)
  -n NAME, --name NAME  Set name of this testing instance (default: random string)
  -T [{TypeErasure} [{TypeErasure} ...]], --transformation-types [{TypeErasure} [{TypeErasure} ...]]
                        Select specific transformations to perform
  --transformation-schedule TRANSFORMATION_SCHEDULE
                        A file containing the schedule of transformations
  -R REPLAY, --replay REPLAY
                        Give a program to use instead of a randomly generated (pickled)
  -e, --examine         Open ipdb for a program (can be used only with --replay option)
  -k, --keep-all        Save all programs
  -S, --print-stacktrace
                        When an error occurs print stack trace
  -w WORKERS, --workers WORKERS
                        Number of workers for processing test programs
  -d, --debug
  -r, --rerun           Run only the last transformation. If failed, start from the last and go back until the transformation introduces the error
  -F LOG_FILE, --log-file LOG_FILE
                        Set log file (default: logs)
  -L, --log             Keep logs for each transformation (bugs/session/logs)
  -N, --dry-run         Do not compile the programs
  --language {kotlin,groovy,java,scala}
                        Select specific language
  --max-type-params MAX_TYPE_PARAMS
                        Maximum number of type parameters to generate
  --max-depth MAX_DEPTH
                        Generate programs up to the given depth
  -P, --only-correctness-preserving-transformations
                        Use only correctness-preserving transformations
  --timeout TIMEOUT     Timeout for transformations (in seconds)
  --cast-numbers        Cast numeric constants to their actual type (this option is used to avoid re-occrrence of a specific Groovy bug)
  --disable-function-references
                        Disable function references
  --disable-use-site-variance
                        Disable use-site variance
  --disable-contravariance-use-site
                        Disable contravariance in use-site variance
  --disable-bounded-type-parameters
                        Disable bounded type parameters
  --disable-parameterized-functions
                        Disable parameterized functions
  --disable-sam         Disable SAM coercions
  --local-variable-prob LOCAL_VARIABLE_PROB
                        Probability of assigning an expression to a local variable
  --error-filter-patterns ERROR_FILTER_PATTERNS
                        A file containing regular expressions for filtering compiler error messages
```

## CLI Options

`thalia` is built on top of [hephaestus](https://github.com/hephaestus-compiler-project),
which provides a rich CLI with many available options.
Below, we explain
the most important CLI options that are related to `thalia`.

#### `--generator api`

This flag enables our API-driven program synthesis approach on `thalia`.

#### `--api-doc-path`

The directory that contains the API (in JSON format) given as input.

Example: `--api-doc-path mypath/to/json-docs/`.
The input API specification is found at `mypath/to/json-docs/`.

#### `--api-rules` (optional)

`thalia` employs a simple query language
that enables users to write a set of rules
to filter out specific API components.
This helps `thalia` generate programs
that invoke only the matching API entities.
For example,
consider the following rule.

```json
{
  "column_names": ["class_name", "class_component_name"],
    "func": "all",
    "rules": [
          ["com.google.*Map", "contains"]
            
    ]
    
}
```

Based on this rule,
`thalia` generates programs that stem from
the typing sequences of methods/fields
whose name is "contains",
and are defined in classes that
match the regex pattern "com.google.*Map".
Our query language supports regular expressions,
logical operators (e.g., negation, logical AND),
as well as functions that are
applied to the entire set of rules.
We currently support two such functions:
`any` and `all`.
The former includes all those API components
that match with at least one rule in the rule set,
while the latter considers only the components
that match with all rules found in the rule set.'

The option `--api-rules` specifies a JSON file that
contains such rules. The file follows
the format of the JSON described above.

Example: `--api-rules rules.json`.
Examine `rules.json` to filter out API components
that do not match the rules of `rules.json`.

#### `--erase-types` (optional)

This flag enables type erasure.
The generated programs contain omitted type information.

#### `--inject-type-error` (optional)

This flag yields type sequences that are type incorrect.
Therefore, the programs synthesized by `thalia` are ill-typed.

#### `--library-path` (optional)

A path that specifies the location of third-party libraries.
`thalia` passes the value of this option to the compiler under test
so that the compiler is able to locate external symbols,
when the synthesized programs stem from APIs of third-party libraries.

Example: `--library-path "mypath/external.jar:mypath/external2.jar"`.
There are two external libraries located at
`mypath/external.jar` and `mypath/external2.jar`.

## Run Tests

To run `thalia` tests, execute the following commands:

```bash
# Enter thalia directory
thalia@e0456a9b520e:~$ cd thalia
# Run tests
thalia@e0456a9b520e:~/thalia$ python -m pytest
```

The output of the previous command should be similar to the following:

```
tests/test_api_graph.py::test1 PASSED                                                   [  0%]
tests/test_api_graph.py::test2 PASSED                                                   [  0%]
...
tests/test_use_analysis.py::test_program6 PASSED                                        [ 99%]
tests/test_use_analysis.py::test_program7 PASSED                                        [ 99%]
tests/test_use_analysis.py::test_program8 PASSED                                        [100%]

===================================== 232 passed in 0.46s =====================================
```

## Example: Testing the Groovy compiler using the API of its standard library

**NOTE:** At each run, `thalia` generates random programs.
Therefore, you should expect to get different results at each run:
some randomly generated programs might trigger unfixed compiler bugs.

The input of `thalia` is an API encoded as a set of JSON files
that contain all classes and their enclosing
methods and  fields.
Example APIs can be found at `example-apis/`.
In this example,
we leverage the API of the Groovy's standard library
(see `--api-doc-path example-apis/groovy-stdlib/json-docs`)
to stress-test `groovyc`.
Specifically, we produce 30 test programs in batches of 10.
The results of our testing procedure are found in
the `bugs/groovy-session/` directory
specified by the `--name groovy-session` option.

```
thalia@e0456a9b520e:~/thalia$ thalia --language groovy \
  --transformations 0  \
  --batch 10 -i 30 -P \
  --max-depth 2 \
  --generator api \
  --api-doc-path example-apis/groovy-stdlib/json-docs \
  --api-rules example-apis/groovy-stdlib/api-rules.json \
  --keep-all \
  --name groovy-session
```

The expected outcome is something similar to:

```
stop_cond             iterations (30)
transformations       0
transformation_types  TypeErasure
bugs                  /home/thalia/thalia/bugs
name                  groovy-session
language              groovy
compiler              Groovy compiler version 5.0.0-alpha-1
Copyright 2003-2023 The Apache Software Foundation. https://groovy-lang.org/
===============================================================================================================================================================================================
Test Programs Passed 27 / 30 ✔          Test Programs Failed 3 / 30 ✘
Total faults: 3
```

Among other things,
the `bugs/java-session/` directory contains two files:
`stats.json` and `faults.json`.

`stats.json` contains the following details about the testing session.

```json
{
  "Info": {
    "stop_cond": "iterations",
    "stop_cond_value": 30,
    "transformations": 0,
    "transformation_types": "TypeErasure",
    "bugs": "/home/thalia/thalia/bugs",
    "name": "groovy-session",
    "language": "groovy",
    "generator": "api",
    "library_path": null,
    "erase_types": false,
    "inject_type_error": false,
    "compiler": "Groovy compiler version 5.0.0-alpha-1\nCopyright 2003-2023 The Apache Software Foundation. https://groovy-lang.org/"
  },
  "totals": {
    "passed": 27,
    "failed": 3
  },
  "synthesis_time": 10.775318752,
  "compilation_time": 7.849241018295288
}
```

If there were some bugs detected,
`faults.json` would look like the following JSON file.

```json
{

  "3": {
    "transformations": [],
    "error": "[Static type checking] - Cannot call <K,V> java.util.Map#of(K, V, K, V) with arguments [V, java.lang.CharSequence, V, java.lang.CharSequence]\n @ line 6, column 5.\n       java.util.Map.of(key, value, key, value);\n       ^\n\n1 error",
    "programs": {
      "/tmp/tmphww1zaz7/src/pelting/Main.groovy": true
    },
    "time": 0.2906373689999988
  },
  "11": {
    "transformations": [],
    "error": "SHOULD NOT BE COMPILED: Incorrect api typing sequence",
    "programs": {
      "/tmp/tmpslp4v8sq/src/frowned/Main.groovy": false
    },
    "time": 0.030104211000001158
  },
  "29": {
    "transformations": [],
    "error": "BUG! exception in phase 'instruction selection' in source unit 'test.groovy' unexpected NullPointerException\n        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:953)\n        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:694)\n        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:668)\n        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:649)\n        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)\n        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)\n        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)\n        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)\n        at org.codehaus.groovy.tools.FileSystemCompiler.main(FileSystemCompiler.java:189)\nCaused by: java.lang.NullPointerException\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.checkCompatibleAssignmentTypes(StaticTypeCheckingSupport.java:725)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitMethodPointerExpression$25(StaticTypeCheckingVisitor.java:2504)\n        at java.base/java.util.Optional.ifPresent(Optional.java:183)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodPointerExpression(StaticTypeCheckingVisitor.java:2496)\n        at org.codehaus.groovy.ast.CodeVisitorSupport.visitMethodReferenceExpression(CodeVisitorSupport.java:319)\n        at org.codehaus.groovy.ast.expr.MethodReferenceExpression.visit(MethodReferenceExpression.java:34)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodCallArguments(StaticTypeCheckingVisitor.java:2912)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitStaticMethodCallExpression(StaticTypeCheckingVisitor.java:2820)\n        at org.codehaus.groovy.ast.expr.StaticMethodCallExpression.visit(StaticMethodCallExpression.java:44)\n        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitExpressionStatement(StaticTypeCheckingVisitor.java:2217)\n        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)\n        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)\n        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:72)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitConstructorOrMethod$28(StaticTypeCheckingVisitor.java:2681)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitConstructorOrMethod(StaticTypeCheckingVisitor.java:2681)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.startMethodInference(StaticTypeCheckingVisitor.java:2664)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethod(StaticTypeCheckingVisitor.java:2643)\n        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitConstructorOrMethod(StaticCompilationVisitor.java:189)\n        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethod(StaticCompilationVisitor.java:204)\n        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1144)\n        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1137)\n        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClass(ClassCodeVisitorSupport.java:52)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitClass$3(StaticTypeCheckingVisitor.java:499)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)\n        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitClass(StaticTypeCheckingVisitor.java:499)\n        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitClass(StaticCompilationVisitor.java:151)\n        at org.codehaus.groovy.transform.sc.StaticCompileTransformation.visit(StaticCompileTransformation.java:68)\n        at org.codehaus.groovy.control.customizers.ASTTransformationCustomizer.call(ASTTransformationCustomizer.groovy:303)\n        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:948)\n        ... 8 more",
    "programs": {
      "/tmp/tmphj006wfu/src/yarn/Main.groovy": true
    }
  }
}
```

The first error is an unexpected compile-time error detected using
our generator ([GROOVY-11050](https://issues.apache.org/jira/browse/GROOVY-111050)).
The second is a compiler bug where the compiler accepts
an ill-typed program ([GROOVY-10930](https://issues.apache.org/jira/browse/GROOVY-10930)).
Finally, the third one is an internal error of
`groovyc` ([GROOVY-11026](https://issues.apache.org/jira/browse/GROOVY-11026)).

In the above scenario,
the structure of testing session directory
(i.e., `bugs/groovy-session/`)
would be like the following

```
|-- 7
|   |-- Main.groovy
|   `-- Main.groovy.bin
|-- 11
|   |-- Main.groovy
|   `-- Main.groovy.bin
|-- 29
|   |-- Main.groovy
|   `-- Main.groovy.bin
|-- logs
|   `-- api-generator
|-- generator
|-- faults.json
`-- stats.json
```

Note that the option `--keep-all` allows you to store all the synthesized programs
into disk. They can be found in the `bugs/java-testing/generator/` directory.

###  Logging

The `-L` option allows you to log all the typing sequences
synthesized by `thalia`.
The resulting log file can be found
at `bugs/groovy-session/logs/api-generator`.
In our previous example,
the contents of this file look like:

```
Constructed API graph with the following statistics:
	Number of nodes:14827
	Number of edges:22303
	Number of methods:10982
	Number of polymorphic methods:461
	Number of fields:1108
	Number of constructors:1159
	Number of types:1282
	Number of type constructors:164
	Avg inheritance chain size:4.22
	Avg API signature size:2.46

Generated program 1
	API: java.util.GregorianCalendar.toZonedDateTime()
	Type variable assignments:
	receiver: java.util.GregorianCalendar
	parameters 0
	return: java.time.ZonedDateTime
Correctness: True
Generated program 2
	API: java.util.AbstractCollection.retainAll(java.util.Collection<*>)
	Type variable assignments:
		java.util.AbstractCollection.T1 -> groovy.lang.SpreadListEvaluatingException
	receiver: java.util.HashSet<groovy.lang.SpreadListEvaluatingException>
	parameters java.util.concurrent.CopyOnWriteArrayList<java.nio.channels.NonReadableChannelException>
	return: boolean
...
```

The first lines of the `bugs/groovy-session/logs/api-generator` file dumps
some statistics regarding the input API and the corresponding
API graph (e.g., number of methods, number of constructors, etc.).
Then,
the file shows the typing sequence which every test case comes from.
For example,
the first test program invokes the
[java.util.GregorianCalendar.toZonedDateTime()](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/GregorianCalendar.html#toZonedDateTime())
method found in the standard library of Java.
The result of this method call is assigned to a variable of type
[java.util.ZonedDateTime](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/ZonedDateTime.html).

The second test case is derived from a typing sequence that
calls a method named
[java.util.AbstractCollection.retainAll](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/AbstractCollection.html#retainAll(java.util.Collection)).
The method resides in the parameterized class
[java.util.AbstractCollection](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/AbstractCollection.html)
whose type parameter is instantiated
with type [groovy.lang.SpreadListEvaluatingException](https://docs.groovy-lang.org/latest/html/api/groovy/lang/SpreadListEvaluatingException.html).
The synthesized test case calls the method
using (1) an expression of
type `java.util.HashSet<groovy.lang.SpreadListEvaluatingException>`,
which is a subtype of `java.util.AbstractCollection<groovy.lang.SpreadListEvaluatingException>`,
and (2) a parameter of type
[java.util.concurrent.CopyOnWriteArrayList](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/CopyOnWriteArrayList.html),
which is a subtype of `java.util.Collection`.
The final outcome of this method call is assigned to a variable
of type `boolean`.

## Example: Testing the Groovy compiler using the API of a third-party library

Previously,
we tested `groovyc` using the standard library of Groovy.
Now, we will show how to test `groovyc` using the API
of a third party library,
in particular the [guava]() library.


### Step 1: Fetch API documentation of third-party package

First,
we first extract the API documentation of this library.
To do so,
run:

```bash
thalia@5b1ba457c8bf:~/thalia$ echo "com.google.guava,guava,32.1.2-jre" | fetch-package-data -i - -o outdir
```

This command essentially fetches the `pom.xml` and the javadoc
of the guava library. The script stores these retrieved files
inside the `outdir/` specified by the `-o` option.
We can use the same command to retrieve an arbitrary package stored
in the Maven's central repository.
To do so,
we need to specify the group ID (e.g., `com.google.guava`),
the artifact ID (e.g., `guava`),
and the version (e.g., 32.1.2-jre)
of the package we want to retrieve.


### Step 2: Convert API documentation into JSON format

Next, run the following command to
convert the API documentation written in HTML format
into a set of JSON files,
which are given as input to `thalia`
(estimated running time 30--60 seconds).

```bash
thalia@5b1ba457c8bf:~/thalia$ doc2json-util -d outdir -l com-google-guava-guava -L java
```

The generated JSON files can be found
inside the `outdir/com-google-guava-guava/json-docs/`
directory.

### Step 3: Fetch the JAR files of the third-party package

Since, we are going to generate test cases
that invoke components from a third-party package,
we need to fetch the corresponding JAR files
so that the compiler is able to locate
the API definitions.
We can automatically fetch all the required
JAR files,
using the `mvn` command.
Maven stores the downloaded packages
inside your local Maven repository located
at `~/.m2/repository/`.


```bash
thalia@5b1ba457c8bf:~/thalia$ mvn -f outdir/com-google-guava-guava/pom.xml dependency:tree 
thalia@5b1ba457c8bf:~/thalia$ mvn -f outdir/com-google-guava-guava/dependency.xml dependency:tree
```


### Step 4: Generate test cases that invoke the guava library

Now, we are ready to invoke `thalia` as follows

```bash
thalia@5b1ba457c8bf:~/thalia$ thalia --language groovy \
  --transformations 0  \
  --batch 10 -i 30 -P \
  --max-depth 2 \
  --generator api \
  --api-doc-path outdir/com-google-guava-guava/json-docs \
  --keep-all \
  --name groovy-session-guava \
  --library-path "$(mvn -f outdir/com-google-guava-guava/pom.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):$(mvn -f outdir/com-google-guava-guava/dependency.xml dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)"
```

Please notice two things.
First,
the option `--api-doc-path` points to
the directory where the API specification of guava resides
(see **Step 2**).
Second,
we use the option `--library-path` whose value
is the classpath of the guava library.
This classpath contains the location of all JAR files
required to invoke guava.
Classpath is automatically constructed via
the `mvn dependency:build-classpath` command.
In turn,
`thalia` passes the value of the option `--library-path`
to the compiler.

The results of the testing session can be found
at `bugs/groovy-session-guava/`.


Now, you can exit the Docker container by running:

```
thalia@e0456a9b520e:~$ exit
```


# Step By Step Instructions

**NOTE**: Remember to run all the subsequent `docker run` commands
from the root directory of the artifact (i.e., `thalia-popl-eval/`).

To validate the main results presented in the paper, first create a new Docker
container by running:

```
docker run -ti --rm \
  -v $(pwd)/database:/home/thalia/database \
  -v $(pwd)/data:/home/thalia/data \
  -v $(pwd)/scripts:/home/thalia/eval-scripts \
  -v $(pwd)/figures:/home/thalia/eval-figures \
  thalia-eval
```

Note that we mount four _local volumes_ inside the newly-created container.
The first volume (`database/`) contains the bug database that includes the bugs
discovered by `thlia`, while the second volume (`data/`) provides the data
collected during our evaluation. The third volume (`eval-scripts/`) includes
some scripts to reproduce and validate the results of the paper. Finally, the
fourth volume (`eval-figures/`) will be used to save the figures of our paper.

## Extracting Library APIs in JSON

The file `data/packages.csv` contains the 95 Maven packages whose
APIs were given as input to `thalia` in our evaluation.
As a starting point,
we have to extract the APIs of the packages included
in `data/packages.csv` and use these APIs as inputs to `thalia`.
This process can take several minutes.
You can run this process for a limited number of packages
(e.g., five).
To do so,
fetch their corresponding API documentation pages (written in HTML)
by running:

```bash
thalia@3195fa0e2240:~$ head -5 data/packages.csv | fetch-package-data -i - -o package-data

Processing org.slf4j slf4j-api 2.0.7
Processing com.google.guava guava 32.0.0-jre
Processing org.mockito mockito-core 5.3.1
Processing com.fasterxml.jackson.core jackson-databind 2.15.1
Processing org.apache.commons commons-lang3 3.12.0
```

The command above stores the API documentation pages of every library
(e.g., `org.slf4j:slf4j-api`)
insided the `package-data/` directory.
If you want to download the API documentation pages
of the entire set of Maven libraries,
run:

```
fetch-package-data -i data/packages.csv -o package-data
```

Then,
convert the API documentation pages into JSON files,
using the following command (estimated running time: 3--5 minutes):

```bash
thalia@3195fa0e2240:~$ doc2json-util -d package-data -L java
Parsing docs of package-data/com-fasterxml-jackson-core-jackson-databind
Parsing docs of package-data/com-google-guava-guava
Parsing docs of package-data/org-apache-commons-commons-lang3
Parsing docs of package-data/org-mockito-mockito-core
Parsing docs of package-data/org-slf4j-slf4j-api
```

The `doc2json-util` command is a wrapper script that invokes
our [doc2json](https://github.com/hephaestus-compiler-project/doc2json)
tool, which converts API documentation pages into JSON.
The generated JSON files can be found inside
`package-data/<lib-name>/json-docs/` directory.
For example,
the JSON files corresponding to `com.google.guava:guava` library
are found in `package-data/com-google-guava-guava/json-docs/`.

In what following,
we will use the above five libraries as a reference
for re-running our evaluation.


## Bug Database

We provide an SQLite database (see the file `database/bugdb.sqlite3`) that contains
information about the bugs discovered by `thalia` during the evaluation.
This database is initialized based on the SQL script stored into
`database/bug_schema.sql`. The bug database consists of three tables,
namely `CompilerBug`, `Feature`, and `CompilerBugFeatures`.

Each record of the `CompilerBug` table consists of the following columns.

* `bid`: A serial number corresponding to the ID of the bug.
* `bug_id`: The bug id as displayed in the corresponding issue tracker.
* `language`: The name of the programming language of the test program.
* `compiler`: The name of the compiler where the bug was found.
* `title`: The title of the bug report.
* `issue_tracker_link`: A URL pointing to the bug report opened by us.
* `mode`: The synthesis mode that detected the bug.
There are four possible values: base, erasure, ill-typed,
and erasure/ill-typed.
* `fix_link`: A URL pointing to the fix of the bug.
* `status`: The status of the bug.
* `resolution`: The resolution of the bug (e.g., Fixed, Duplicate).
* `report_date`: The date that we reported the bug.
* `resolution_date`: The date that the developers resolved the bug.
* `symptom`: The symptom of the bug. There are four possible values:
unexpected compile-time error (UCTE), unexpected runtime behavior (URB),
crash, and compilation performance issue (CPI)
Note that the URB typically corresponds to soundness bugs detected
by ill-typed programs.
* `resolved_in`: How long did it take to resolve this bug.
* `test`: The test program that revealed the bug.
* `error_msg`: The error message reported by the compiler, or the stacktrace of
the crash, or the exception caused in the runtime.

The `Feature` table contains the following two fields.

* `fid`: A serial number corresponding to the ID of the feature.
* `feature_name`: The name of the feature
(e.g., Parameterized class).

Finally, `CompilerBugFeatures` is a table implementing the many-to-many
relationship between `CompilerBug` and `Feature`,
this table contains three fields: `bfid`, `fid`, `bid`.

### Example Queries

From inside the container, we can perform some basic queries on this bug
database.

Get the total number of the discovered bugs.

```
thalia@ff9317c919b1:~$ sqlite3 database/bugdb.sqlite3 "SELECT COUNT(*) FROM CompilerBug";
84
```

Find the number of `groovyc` bugs.

```
thalia@ff9317c919b1:~$ sqlite3 database/bugdb.sqlite3 "SELECT COUNT(*) FROM CompilerBug WHERE compiler = 'groovyc'";
62
```

Find the number of `kotlinc` bugs that have UCTE as their symptom.

```
thalia@ff9317c919b1:~$ sqlite3 database/bugdb.sqlite3 "SELECT COUNT(*) FROM CompilerBug WHERE compiler = 'kotlinc' AND symptom = 'Unexpected Compile-Time Error'";
7
```

For each Dotty bug revealed by the type erasure mode (`erasure`),
dump the URLs pointing to our bug reports.

```
thalia@ff9317c919b1:~$ sqlite3 database/bugdb.sqlite3 "SELECT issue_tracker_link FROM CompilerBug WHERE compiler = 'dotty' AND mode = 'erasure'";
https://github.com/lampepfl/dotty/issues/17348
https://github.com/lampepfl/dotty/issues/17311
https://github.com/lampepfl/dotty/issues/17207
```

Get the six most common features used in the test cases of the
reported bugs.

```
thalia@ff9317c919b1:~$ sqlite3 database/bugdb.sqlite3 "SELECT f.feature_name, COUNT(*) as total FROM CompilerBugFeatures as cbf JOIN Feature as f ON f.fid = cbf.fid GROUP BY cbf.fid ORDER BY total DESC LIMIT 6";
Parameterized type|58
Parameterized class|58
Parameterized function|45
Single Abstract Method (SAM)|30
Type argument inference|23
Overloading|22
```

## RQ1: Bug-Finding Results (Section 4.2)

For the first research question,
we examine the `database/bugs.json` file
to reproduce the entire Table 2.

```
thalia@a0cfd75dfbf3:~$ python eval-scripts/process_bugs.py database/bugs.json
                          Table 2a
============================================================
Status              groovyc   kotlinc   dotty     Total
------------------------------------------------------------
Confirmed           38        9         8         55
Fixed               20        1         1         22
Wont fix            2         1         1         4
Duplicate           2         0         1         3
------------------------------------------------------------
Total               62        11        11        84

                          Table 2b
============================================================
Symptoms            groovyc   kotlinc   dotty     Total
------------------------------------------------------------
UCTE                47        7         7         61
URB                 6         0         0         6
Crash               8         3         4         15
CPI                 1         1         0         2

                          Table 2c
============================================================
Synthesis mode      groovyc   kotlinc   dotty     Total
------------------------------------------------------------
Well-typed          32        8         7         47
Well-typed (TE)     21        3         3         27
Ill-typed           9         0         1         10
Ill-typed (TE)      0         0         0         0
```

## RQ2: Test Case Characteristics (Section 4.3)

For the second research question,
we examine `database/bugs.json` file to reproduce
Table 3, which shows the language features that appear
in the minimized test cases of our bug reports.
Furthermore,
we generate Figure 9
and stores it at `figures/venn.pdf` in your host machine.
Run,
the following command:

```
thalia@401c23b79be3:~$ python eval-scripts/features.py database/bugs.json --venn eval-figures/venn.pdf
Overloading 22
Parametric polymorphism 71
Functional programming 35
Type inference 24
                                              Table 3                                              
=============================================================================================
Category            Feature                                              Frequency Supported
---------------------------------------------------------------------------------------------
Declaration         Parameterized class                                  58 / 84   Yes
Declaration         Parameterized function                               45 / 84   Yes
Declaration         Single Abstract Method (SAM)                         30 / 84   Yes
Declaration         Overloading                                          22 / 84   No
Declaration         Inheritance / Implementation of multiple interfaces  8 / 84    No
Declaration         Variable argument                                    5 / 84    Yes
Declaration         Inner class                                          3 / 84    No
Declaration         Static method                                        2 / 84    No
Declaration         Access modifier                                      2 / 84    No
Declaration         Bridge method                                        1 / 84    No
Declaration         Default method                                       1 / 84    No
Declaration         Operator                                             1 / 84    No
Type inference      Type argument inference                              23 / 84   Yes
Type inference      Variable type inference                              2 / 84    Yes
Type                Parameterized type                                   58 / 84   Yes
Type                Wildcard type                                        19 / 84   Yes
Type                Bounded type parameter                               15 / 84   Yes
Type                Array type                                           7 / 84    Yes
Type                Subtyping                                            7 / 84    Yes
Type                Recursive upper bound                                3 / 84    No
Type                Primitive type                                       3 / 84    Yes
Type                Nullable type                                        2 / 84    No
Expression          Function reference                                   21 / 84   Yes
Expression          Lambda                                               10 / 84   Yes
Expression          Conditionals                                         4 / 84    Yes
```

Beyond Table 3 and Figure 9,
the script validates the following sentence that
appears in the first paragraph of Section 4.3.

* _"Roughly 85% (70/82) of the
bug-triggering test cases contain at least one feature related to parametric polymorphic._".

### Size of test cases

This command compute statistics about the size
of the programs synthesized by `thalia`.
The script leverages the CSV files located 
at `data/size`,
which show the size characteristics of
every program synthesized by `thalia` in our evaluation.
The first column of a CSV file shows
the size of each program in kB,
while the second column represents the size
of each program in terms of LoC.
Run:

```
thalia@238ed47eab80:~$ ./eval-scripts/compute-size-statistics.sh data/size/
(groovy) Average size in kB: 1.60
(groovy) Average size in LoC: 13

(kotlin) Average size in kB: 1.40
(kotlin) Average size in LoC: 11

(scala) Average size in kB: 1.59
(scala) Average size in LoC: 11
```

The script produces results that are included
in the _"Size of test case"_ paragraph of Section 4.3.

* _"On average, a Groovy test case measures 1.6kB
   and contains 13 lines of code (LoC),
   while a Scala test case measures 1.6kB and consists of 11 LoC.
   Similarly, Kotlin test cases have an
   average size of 1.4kB and an average of 11 LoC."_

## RQ3: Impact of Library Selection and Synthesis Modes (Section 4.4)

### Number of well-typed and ill-typed programs

First, we reproduce Figure 11, which shows the number of well-typed
and ill-typed test cases synthesized by `thalia`.
To do so,
we use the CSV files found in the `data/libs/file-results/` directory.
Every CSV entry shows how many files are synthesized by `thalia`
per synthesis mode and library.
Run:

```
thalia@6bfd90f897d7:~$ python eval-scripts/files.py  data/libs/files-results/ eval-figures/files-boxplot.pdf
                            mean          std  min      25%     50%       75%      max
mode       language
Ill-typed  Groovy    1936.863158  2538.916769  2.0   251.25   819.0   2396.50  10975.0
           Kotlin    1831.451087  2434.144133  2.0   263.50   806.0   2310.50  11742.0
           Scala     1840.426316  2413.187385  2.0   245.50   815.5   2465.25  12904.0
Well-typed Groovy    5940.542105  4604.434885  3.0  1584.00  6186.5   8428.00  20544.0
           Kotlin    5949.940217  5009.431708  4.0  1266.00  5100.0   9413.50  21734.0
           Scala     7821.115789  5986.895969  4.0  2017.00  7989.5  12022.75  30115.0
```

The script prints some statitics about the distribution.
For example,
by examining these statistics we can infer
that each library produced 1937 ill-typed Groovy programs, on average.
Beyond these statistics,
the script generates Figure 11 and stores in `figures/files-boxplot.pdf`
in your host machine.


### Code coverage analysis

Now we measure the impact of every library
and synthesis mode on line code coverage:
we reproduce Figure 10 and Table 4.
To do so,
we examine the
`data/libs/results/` directory,
which contains the code coverage results 
(using the JaCoCo code coverage library)
when compiling the test cases synthesized
by `thalia`.
The results are grouped by language, library,
and synthesis mode.

First,
we examine the results for `groovyc`.
The following command also generates the Figure 10a
stored in the `figures/groovy-line-libs.pdf`
on your host machine.
Run the following command
(estimated running time 1--3 minutes): 

```
thalia@1c75a71c1190:~$ python eval-scripts/analysis.py \
  --coverage-data data/libs/results/ \
  --whitelist data/coverage/whitelists/groovy.txt \
  --language groovy \
  --output-dir eval-figures/

Processing coverage data per library...
                           Table 4 (groovy data)
===========================================================================
Mode      Min            Max            Median         Mean           Std
---------------------------------------------------------------------------
Erase     +0(0.0%)       +4306(11.87%)  +165.5(0.46%)  +264(0.73%)    1.63%
Inject    +0(0.0%)       +2952(8.14%)   +44.5(0.12%)   +118(0.33%)    1.08%
Both      +0(0.0%)       +3087(8.51%)   +162.5(0.45%)  +194(0.54%)    0.89%
```

Next,
we do the same for Dotty.
The following command also generates the Figure 10b
stored in the `figures/scala-line-libs.pdf`
on your host machine. 
Run the following command
(estimated running time 1--3 minutes): 

```
thalia@1c75a71c1190:~$ python eval-scripts/analysis.py \
  --coverage-data data/libs/results/ \
  --whitelist data/coverage/whitelists/scala.txt \
  --language scala \
  --output-dir eval-figures/

Processing coverage data per library...
                            Table 4 (scala data)
===========================================================================
Mode      Min            Max            Median         Mean           Std
---------------------------------------------------------------------------
Erase     +0(0.0%)       +5548(7.05%)   +934.0(1.19%)  +1086(1.38%)   1.09%
Inject    +7(0.01%)      +3595(4.57%)   +474.5(0.6%)   +615(0.78%)    0.73%
Both      +117(0.15%)    +4192(5.32%)   +851.5(1.08%)  +975(1.24%)    0.77%
```

Finally,
we reproduce Figure 10c
(found in `figures/kotlin-line-libs.pdf`),
and the data of Table 4 associated with `kotlinc`.
Run the following command
(estimated running time 1--3 minutes): 

```
thalia@1c75a71c1190:~$ python eval-scripts/analysis.py \
  --coverage-data data/libs/results/ \
  --whitelist data/coverage/whitelists/kotlin.txt \
  --language kotlin \
  --output-dir eval-figures/

Processing coverage data per library...
                           Table 4 (kotlin data)
===========================================================================
Mode      Min            Max            Median         Mean           Std
---------------------------------------------------------------------------
Erase     +3(0.01%)      +2144(3.65%)   +523.0(0.89%)  +567(0.97%)    0.51%
Inject    +1(0.0%)       +3030(5.15%)   +175.0(0.3%)   +290(0.49%)    0.72%
Both      +45(0.08%)     +2175(3.7%)    +346.5(0.59%)  +419(0.71%)    0.6%
```

### Synthesis time

To reproduce Figure 12,
we leverage the CSV files located in `data/time`.
Each CSV file shows the average synthesis time
per library.
Run the following command:

```
thalia@f2f3027c794d:~$ python eval-scripts/time-plot.py data/time/ eval-figures/
(groovy) Average synthesis time: 256ms
(scala) Average synthesis time: 161ms
(kotlin) Average synthesis time: 178ms
```

Figure 12a, Figure 12b and Figure 12c
are generated at `figures/groovy-time.pdf`,
`figures/scala-time.pdf`,
and `figures/kotlin-time.pdf` on your host machine respectively.
Beyond these figures,
the script above also produces the average synthesis time metrics
mentioned in the **Synthesis time** paragraph of Section 4.3.

* _"The average synthesis time is 256, 161, and 178 milliseconds for Groovy, Scala, and Kotlin programs respectively. "_

## RQ4: Comparison of Thalia vs. Hephaestus (Section 4.5)

In this research question,
we compare `thalia` and `hephaestus`
in terms of several aspects.

### Code coverage analysis

Run the following commands
to reproduce Figure 13.
The script examines the code coverage
data (`data/comparison/coverage`)
that stem from the compilation of all
programs produced by `thalia` and `hephaestus`
respectively.

```bash
# groovy
thalia@65536014baca:~$ python eval-scripts/analysis.py \
  --coverage-data data/comparison/coverage/ \
  --hephaestus --language groovy \
  --whitelist data/coverage/whitelists/groovy.txt \
  --output-dir eval-figures/

# scala
thalia@65536014baca:~$ python eval-scripts/analysis.py \
  --coverage-data data/comparison/coverage/ \
  --hephaestus --language scala \
  --whitelist data/coverage/whitelists/scala.txt \
  --output-dir eval-figures/

# kotlin
thalia@65536014baca:~$ python eval-scripts/analysis.py \
  --coverage-data data/comparison/coverage/ \
  --hephaestus --language groovy \
  --whitelist data/coverage/whitelists/groovy.txt \
  --output-dir eval-figures/
```

The output of the above commands are three figures
that reside in the following paths on your host machine:
`figures/groovy-cov-comparison.pdf`,
`figures/scala-cov-comparison.pdf`,
and `figures/kotlin-cov-comparison.pdf`.
These correspond to Figure 13a, Figure 13b,
and Figure 13c respectively.


### Compilation and Synthesis time

The following command reproduces Table 5.
It compares the average time of compiling ("comp") and
generating ("gen") `thalia` and `hephaestus` programs.

```
thalia@da41d2c974e0:~$ python eval-scripts/time-comparison.py data/comparison/time/
                                         Table 5
==========================================================================================
Compiler       Thalia (comp)       Hephaestus (comp)   Thalia (gen)        Hephaestus (gen)
------------------------------------------------------------------------------------------
groovy         3.1                 6.6                 0.3                 0.7
scala          5.4                 7.9                 0.2                 1.0
kotlin         6.5                 26.5                0.2                 1.3

```

### Code size

Run the following two commands
to get the size statistics regarding
the programs produced by `thalia` and `hephaestus`.


```
thalia@af84df5871af:~$ ./eval-scripts/compute-size-statistics.sh data/comparison/code-size/thalia/
(groovy) Average size in kB: 1.96
(groovy) Average size in LoC: 15

(kotlin) Average size in kB: 1.64
(kotlin) Average size in LoC: 12

(scala) Average size in kB: 1.65
(scala) Average size in LoC: 11

thalia@af84df5871af:~$ ./eval-scripts/compute-size-statistics.sh data/comparison/code-size/hephaestus/
(groovy) Average size in kB: 8.00
(groovy) Average size in LoC: 306

(kotlin) Average size in kB: 7.66
(kotlin) Average size in LoC: 263

(scala) Average size in kB: 7.95
(scala) Average size in LoC: 258
```

The above results reproduce the following statements found
in the **Code size** paragraph of Section 4.5:

* _"..the average size of thalia’s programs written in
Groovy, Scala, and Kotlin is 15, 12, and 11 LoC, respectively."_
* _"Hephaestus generated programs that are one order of magnitude larger,
    with an average size of 304, 262, and 257 LoC for Groovy, Scala,
    and Kotlin respectively."_
