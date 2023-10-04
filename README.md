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
  * [Example](#example)
- [Step by Step Instructions](#step-by-step-instructions)
  * [Bug Database](#bug-database)
  * [RQ1: Bug-Finding Results (Section 4.2)](#rq1-bug-finding-results-section-42)
  * [RQ2: Bug and Test Case Characteristics (Section 4.3)](#rq2-bug-and-test-case-characteristics-section-43)

# Overview

The artifact contains the instructions and scripts to re-run the evaluation
described in our paper. The artifact has the following structure:

TODO

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

`thalia` is built on top of [hephaestus](https://github.com/hephaestus-compiler-project),
which provides a rich CLI with many available options.
Below, we explain
the most important CLI options that are related to `thalia`.

``` thalia@e0456a9b520e:~$ thalia --help
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

TODO

## Run Tests

To run `thalia` tests, execute the following commands:

```
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
  ---api-doc-path example-apis/groovy-stdlib/json-docs \
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

```
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

The `-L` option allows use to log the typing sequences
synthesized by `thalia`.
This log can be found in the `bugs/java-session/logs/api-generator` file.
In our previous example,
the contents of this file look like:

```
Built API with the following statistics:
	Number of nodes:13225
	Number of edges:19736
	Number of methods:9658
	Number of polymorphic methods:425
	Number of fields:1068
	Number of constructors:1159
	Number of types:1095
	Number of type constructors:144
	Avg inheritance chain size:4.20
	Avg API signature size:2.43

Generated program 1
	API: java.lang.module.ModuleDescriptor.Builder.version(Classifier[java.lang.module.ModuleDescriptor.Version])
	Type variable assignments:
	receiver: java.lang.module.ModuleDescriptor.Builder
	parameters java.lang.module.ModuleDescriptor.Version
	return: java.lang.module.ModuleDescriptor.Builder
Correctness: True
Generated program 2
	API: java.lang.module.ModuleDescriptor.Builder.version(Classifier[java.lang.module.ModuleDescriptor.Version])
	Type variable assignments:
	receiver: java.lang.module.ModuleDescriptor.Builder
	parameters java.lang.module.ModuleDescriptor.Version
	return: Object
Correctness: True
...
```

The first lines of the `bugs/java-session/logs/api-generator` file dumps
some statistics regarding the input API and the corresponding
API graph (e.g., number of methods, nmber of constructors, etc.).
Then,
the file shows the typing sequence of every test case.
For example,
the first test program invokes the
[java.lang.module.ModuleDescriptor.Builder.version](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/module/ModuleDescriptor.Builder.html#version(java.lang.module.ModuleDescriptor.Version))
method found in the standard library of Java
using a parameter of type
[java.lang.module.ModuleDescriptor.Version](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/module/ModuleDescriptor.Version.html).
The result of this method call is assigned to a variable of type
[java.lang.module.ModuleDescriptor.Builder](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/module/ModuleDescriptor.Builder.html).


```
hephaestus@e0456a9b520e:~$ exit
```
