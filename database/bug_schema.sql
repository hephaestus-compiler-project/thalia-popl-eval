
DROP TABLE IF EXISTS "Feature";
CREATE TABLE Feature (
    fid             INTEGER PRIMARY KEY,
    feature_name    TEXT NOT NULL
);

DROP TABLE IF EXISTS "CompilerBug";
CREATE TABLE CompilerBug (
    bid                 INTEGER PRIMARY KEY,
    bug_id              TEXT NOT NULL,
    language            TEXT NOT NULL,
    compiler            TEXT NOT NULL,
    title               TEXT NOT NULL,
    issue_tracker_link  TEXT NOT NULL,
    mode                TEXT NOT NULL,
    fix_link            TEXT,
    status              TEXT,
    resolution          TEXT,
    report_date         TEXT,
    resolution_date     TEXT,
    symptom             TEXT,
    resolved_in         TEXT,
    test                TEXT,
    error_msg           TEXT
);

DROP TABLE IF EXISTS "CompilerBugFeatures";
CREATE TABLE CompilerBugFeatures (
    bfid                INTEGER PRIMARY KEY,
    fid                 INTEGER NOT NULL,
    bid                 INTEGER NOT NULL,
    FOREIGN KEY (fid) REFERENCES Feature (fid),
    FOREIGN KEY (bid) REFERENCES CompilerBug (bid)
);


INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    0,
    "Inner class"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    1,
    "Variable argument"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    6,
    "Parameterized function"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    3,
    "Parameterized class"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    4,
    "Default method"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    5,
    "Primitive type"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    2,
    "Array type"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    7,
    "Overloading"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    8,
    "Variable type inference"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    9,
    "Function reference"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    10,
    "Nullable type"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    11,
    "Lambda"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    12,
    "Inheritance / Implementation of multiple interfaces"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    13,
    "Subtyping"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    14,
    "Parameterized type"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    15,
    "Wildcard type"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    16,
    "Recursive upper bound"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    17,
    "Conditionals"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    18,
    "Bounded type parameter"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    19,
    "Access modifier"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    20,
    "Static method"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    21,
    "Type argument inference"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    22,
    "Single Abstract Method (SAM)"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    23,
    "Bridge method"
);

INSERT INTO "Feature" (
    "fid", "feature_name"
) VALUES (
    24,
    "Operator"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    0,
    "GROOVY-11129",
    "Groovy",
    "groovyc",
    "STC chooses to call a non-polymorphic method although explicit type arguments are given",
    "https://issues.apache.org/jira/browse/GROOVY-11129",
    "base",
    "None",
    "Closed",
    "Duplicate",
    "2023-07-19 13:54:33+00:00",
    "2023-07-20 14:47:25+00:00",
    "Unexpected Compile-Time Error",
    "1 day, 0:52:52",
    "import java.util.concurrent.*;
class Main {
  static final void test() {
    ExecutorService z = null;
    Future<CharSequence> future = z.<CharSequence>submit(() -> ""fd"");
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 7: [Static type checking] - Incompatible generic argument types. Cannot assign java.util.concurrent.Future<? extends java.lang.Object> to: java.util.concurrent.Future<java.lang.CharSequence>
 @ line 7, column 35.
       Future<CharSequence> future = z.<CharSequence>submit(() -> ""fd"");
                                     ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    1,
    "GROOVY-11121",
    "Groovy",
    "groovyc",
    "unexpected error when having overloaded methods, one of which receiving an Iterable",
    "https://issues.apache.org/jira/browse/GROOVY-11121",
    "base",
    "None",
    "Open",
    "",
    "2023-07-09 12:59:49+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
class Foo<T> {
  static <T> Foo<T> of(Iterable<T> values) { return null; }
  static <T> Foo<T> of(T values) { return null; }
}
class Main {
  static final void test() {
    Foo.<IntUnaryOperator>of((int s) -> s + 1);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 10: [Static type checking] - Wrong number of parameters for method target: iterator()
 @ line 10, column 38.
       var x = Foo.<IntUnaryOperator>of((int s) -> s + 1);
                                        ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    2,
    "GROOVY-11120",
    "Groovy",
    "groovyc",
    "Unexpected error when using static method of class with lower case",
    "https://issues.apache.org/jira/browse/GROOVY-11120",
    "base",
    "None",
    "Closed",
    "Won't Fix",
    "2023-07-09 12:12:55+00:00",
    "2023-07-10 07:32:04+00:00",
    "Unexpected Compile-Time Error",
    "19:19:09",
    "package bar;
public class foo {
  public static void create(String x) {}
}
// client code
class Main {
  static final void test() {
    bar.foo.create(""fda"");
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 3: Apparent variable 'bar' was found in a static scope but doesn't refer to a local variable, static field or class. Possible causes:
You attempted to reference a variable in the binding or an instance variable from a static context.
You misspelled a classname or statically imported field. Please check the spelling.
You attempted to use a method 'bar' but left out brackets in a place not allowed by the grammar.
 @ line 3, column 5.
       bar.foo.create(""fda"");
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    3,
    "GROOVY-11115",
    "Groovy",
    "groovyc",
    "Miss to check the compatibility of wildcard types",
    "https://issues.apache.org/jira/browse/GROOVY-11115",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-06-28 07:57:48+00:00",
    "None",
    "Unexpected Runtime Behavior",
    "None",
    "import java.util.*
class Main {
  static final void test() {
    List<? extends Number> list = new LinkedList<Number>();
    List<Number> x = list; // types are not compatible.
    List<Number> y = (List<? extends Object>) null // types are not compatible;
    list.add(1); // method call is not permitted.
  }
}",
    ""
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    4,
    "GROOVY-11114",
    "Groovy",
    "groovyc",
    "Fail to find method reference in case of chain of polymorphic method calls",
    "https://issues.apache.org/jira/browse/GROOVY-11114",
    "base",
    "None",
    "Open",
    "",
    "2023-06-27 12:44:35+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*;
import java.util.concurrent.*;
class Foo<K, V> {
  V apply(K p) { return null; }
}
class Main {
  static final void test(Foo<Map.Entry<Number, Boolean>, String> p) {
    ConcurrentHashMap.KeySetView<Number, Boolean> x = null;
    ConcurrentHashMap<Number, Boolean> y = x.getMap();
    y.<String>reduceEntries(19, p::apply, null); // works
    x.getMap().<String>reduceEntries(19, p::apply, null); // fails
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 15: Failed to find method 'apply(java.util.Map$Entry<java.lang.Object, java.lang.Object>)' for the type: Foo<java.util.Map$Entry<java.lang.Number, java.lang.Boolean>, java.lang.String> @ line 15, column 42.
   p().<String>reduceEntries(19, p::apply,
                                 ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    5,
    "GROOVY-11110",
    "Groovy",
    "groovyc",
    "STC mixes names of bounded type parameters",
    "https://issues.apache.org/jira/browse/GROOVY-11110",
    "base",
    "None",
    "Open",
    "",
    "2023-06-22 12:51:52+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.stream.*;
class Main {
  static final <T extends Number>void test() {
    java.util.function.BiConsumer<T, T> func = null;
    Stream<String> stream = null;
    T res = stream.<T>collect(() -> (T) null, (T finisher, String hijacking) -> { }, func);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 8: [Static type checking] - Cannot assign value of type java.lang.String to variable of type T
 @ line 8, column 13.
       T res = stream.<T>collect(() -> (T) null, (T finisher, String hijacking) -> { }, func);
               ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    6,
    "GROOVY-11109",
    "Groovy",
    "groovyc",
    "Unable to initialize generic class with an array",
    "https://issues.apache.org/jira/browse/GROOVY-11109",
    "base",
    "None",
    "Open",
    "",
    "2023-06-22 12:35:12+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Foo<T> {
  Foo(T[] x) {}
}
class Main {
  static final void test() {
    Byte[][] arg = null;
    Foo<Byte[]> res = new Foo<Byte[]>(arg)
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 8: [Static type checking] - Cannot call Foo#<init>(java.lang.Byte[][]) with arguments [java.lang.Byte[][]]
 @ line 8, column 23.
       Foo<Byte[]> res = new Foo<Byte[]>(arg)
                         ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    7,
    "GROOVY-11106",
    "Groovy",
    "groovyc",
    "Failed to detect an ambiguous method call?",
    "https://issues.apache.org/jira/browse/GROOVY-11106",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-06-20 13:17:08+00:00",
    "None",
    "Unexpected Runtime Behavior",
    "None",
    "import java.io.*;
import java.util.*;
class Main {
  void test() {
    ObjectOutputStream y = null;
    m(y); 
  }
  Number m(OutputStream x) { return 1; }
  Number m(DataOutput x) { return 2; }
}",
    ""
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    8,
    "GROOVY-11094",
    "Groovy",
    "groovyc",
    "SAM types not working well along with overloading",
    "https://issues.apache.org/jira/browse/GROOVY-11094",
    "base",
    "None",
    "Open",
    "",
    "2023-06-13 14:40:51+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*;
import java.util.function.*;
class Bar {
  LinkedList<String> collect(Supplier<String> function) { }
        List<String> collect(String x, int y, int z) { }
}
class Main {
  static final void test() {
    Bar x = null;
    LinkedList<String> d = x.collect(() -> ""fda"");
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 14: [Static type checking] - Cannot assign value of type java.util.List<java.lang.String> to variable of type java.util.LinkedList<java.lang.String>
 @ line 14, column 28.
       LinkedList<String> d = x.collect(() -> ""fda"");
                              ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    9,
    "GROOVY-11087",
    "Groovy",
    "groovyc",
    "Local variable inference leads to incorrect type when having a complex parameterized type",
    "https://issues.apache.org/jira/browse/GROOVY-11087",
    "erasure",
    "None",
    "Open",
    "",
    "2023-06-08 13:52:05+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final void test() {
    Class<Class<Number>> d = null;
    var x = d.cast("""");
    m(x);
  }
  static void m(Class<?> x) {}
}",
    "Main.groovy: 5: [Static type checking] - Cannot find matching method Main#m(java.lang.Number). Please check if the declared type is correct and if the method exists.
 @ line 5, column 5.
       m(x);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    10,
    "GROOVY-11086",
    "Groovy",
    "groovyc",
    "Wrong method is chosen when having overloaded methods with bounded type parameters",
    "https://issues.apache.org/jira/browse/GROOVY-11086",
    "base",
    "None",
    "Open",
    "",
    "2023-06-08 11:20:16+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*;
class Foo<T> {}
class Bar<T> {}
class Main {
  static final void test() {
    LinkedList<Number> x = null;
    Foo<Iterable<Number>> y = Main.<Number, Iterable<Number>>m(x);
  }
  static <X, T extends Iterable<X>> Foo<T> m(Iterable<X> x) {return null;}
  static <X, T extends List<X>> Bar<T> m(List<X> x) { return null; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 9: [Static type checking] - Cannot assign value of type Bar<T extends java.util.List<X>> to variable of type Foo<java.lang.Iterable<java.lang.Number>>
 @ line 9, column 31.
       Foo<Iterable<Number>> y = Main.<Number, Iterable<Number>>m(x);
                                 ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    11,
    "GROOVY-11082",
    "Groovy",
    "groovyc",
    "Incompatible generic argument when mixing diamond operator and ""super"" wildcard",
    "https://issues.apache.org/jira/browse/GROOVY-11082",
    "erasure",
    "None",
    "Open",
    "",
    "2023-06-06 13:30:06+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
class Foo<T> {
  Foo(Supplier<? super T> x) {}
}
class Main {
  static final void test() {
    Supplier<CharSequence> func = null;
    Foo<StringBuffer> x = new Foo<>(func);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 10: [Static type checking] - Incompatible generic argument types. Cannot assign Foo<java.lang.CharSequence> to: Foo<java.lang.StringBuffer>
 @ line 10, column 27.
       Foo<StringBuffer> x = new Foo<>(func);
                             ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    12,
    "GROOVY-11081",
    "Groovy",
    "groovyc",
    "Exponential behaviour in error reporting",
    "https://issues.apache.org/jira/browse/GROOVY-11081",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-06-06 12:38:53+00:00",
    "None",
    "Compilation Performance Issue",
    "None",
    "class Main {
  static final void test() {
    org.apache.commons.collections4.iterators.ZippingIterator<
      org.apache.commons.collections4.iterators.ZippingIterator<String>
    > x = null;
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 4: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>
 @ line 4, column 7.
         org.apache.commons.collections4.iterators.ZippingIterator<String>
         ^
test1.groovy: 5: unable to resolve class org.apache.commons.collections4.iterators.ZippingIterator<org.apache.commons.collections4.iterators.ZippingIterator<java.lang.String>>
 @ line 5, column 7.
       > x = null;
         ^
12 errors"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    13,
    "GROOVY-11077",
    "Groovy",
    "groovyc",
    "STC overconstraints lambda's parameter types when expecting a SAM that involves wildcards",
    "https://issues.apache.org/jira/browse/GROOVY-11077",
    "base",
    "None",
    "Open",
    "",
    "2023-06-02 14:42:41+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Test {
  void test() {
    m((Integer x, Integer y) -> 1);
  }
  void m(java.util.Comparator<? extends Object> x) {}
}",
    "test.groovy: 3: [Static type checking] - Expected type java.lang.Object for lambda parameter: x
 @ line 3, column 8.
       m((Integer x, Integer y) -> 1);
          ^
test.groovy: 3: [Static type checking] - Expected type java.lang.Object for lambda parameter: y
 @ line 3, column 19.
       m((Integer x, Integer y) -> 1);
                     ^
2 errors"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    14,
    "GROOVY-11074",
    "Groovy",
    "groovyc",
    "Imprecise type for parameterized method when involving subtyping",
    "https://issues.apache.org/jira/browse/GROOVY-11074",
    "erasure",
    "None",
    "Open",
    "",
    "2023-05-26 12:43:44+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final void test() {
    Number x = 1;
    List<Number> y = m(x, 1);
  }
  static <T> List<T> m(T x, T y) { return null; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 4: [Static type checking] - Incompatible generic argument types. Cannot assign java.util.List<? extends java.lang.Number> to: java.util.List<java.lang.Number>
 @ line 4, column 22.
       List<Number> y = m(x, 1);
                        ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    15,
    "GROOVY-11073",
    "Groovy",
    "groovyc",
    "Cannot infer type of parameterized method when dealing with arrays",
    "https://issues.apache.org/jira/browse/GROOVY-11073",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2023-05-26 09:56:51+00:00",
    "2023-05-31 16:12:56+00:00",
    "Unexpected Compile-Time Error",
    "5 days, 6:16:05",
    "class Main {
  static final void test() {
    double[] x = Tuple.tuple(org.codehaus.groovy.runtime.ArrayGroovyMethods.max((double[][]) null, { -> 1 })).getV1();
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 3: [Static type checking] - Cannot assign value of type (java.io.Serializable or java.lang.Cloneable) to variable of type double[]
 @ line 3, column 18.
       double[] x = Tuple.tuple(org.codehaus.groovy.runtime.ArrayGroovyMethods.max((double[][]) null, { -> 1 })).getV1();
                    ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    16,
    "GROOVY-11066",
    "Groovy",
    "groovyc",
    "Unable to call parameterized function that contains type variables with recursive bounds",
    "https://issues.apache.org/jira/browse/GROOVY-11066",
    "base",
    "None",
    "Open",
    "",
    "2023-05-18 15:59:06+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final void test() {
    String arg1 = null;
    Number arg2 = null;
    com.google.common.collect.ImmutableSortedMap.<String, Number>of(arg1, arg2);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 8: [Static type checking] - Cannot call <K extends java.lang.Comparable<? super K>,V> com.google.common.collect.ImmutableSortedMap#of(K, V) with arguments [java.lang.String, java.lang.Number]
 @ line 8, column 5.
       com.google.common.collect.ImmutableSortedMap.<String, Number>of(arg1, arg2);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    17,
    "GROOVY-11065",
    "Groovy",
    "groovyc",
    "STC takes the instantiation of a wrong type variable",
    "https://issues.apache.org/jira/browse/GROOVY-11065",
    "erasure",
    "None",
    "Open",
    "",
    "2023-05-18 08:24:54+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*
import java.util.function.*;
class LockVisitor<X> {
  <T> T applyWriteLocked(Function<X, T> func) {return null;}
}
class Main {
  static final <X>void test() {
    Function<PropertyPermission, Collection<? extends X>> func = null;
    LockVisitor<PropertyPermission> rec = null;
    var x = rec.applyWriteLocked(func);
    X arg = null;
    TreeSet<X> y = new java.util.TreeSet<>(x)
    y.floor(arg)
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 17: [Static type checking] - Cannot call java.util.TreeSet#floor(java.util.PropertyPermission) with arguments [X]
 @ line 17, column 5.
       y.floor(arg)
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    18,
    "GROOVY-11053",
    "Groovy",
    "groovyc",
    "Method ambiguity error when having methods with primitive arrays and varargs",
    "https://issues.apache.org/jira/browse/GROOVY-11053",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-05-11 13:43:07+00:00",
    "2023-05-29 15:40:06+00:00",
    "Unexpected Compile-Time Error",
    "18 days, 1:56:59",
    "class Main {
  static final void test() {
    final byte[] vetting = new byte[1];
    final byte[] grafting = org.apache.commons.lang3.ArrayUtils.removeAll(vetting); // works 
    final byte[] grafting = org.apache.commons.lang3.ArrayUtils.removeAll(vetting, 0); // fails 
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
groovy38.groovy: 4: [Static type checking] - Reference to method is ambiguous. Cannot choose between [byte[] org.apache.commons.lang3.ArrayUtils#removeAll(byte[], int[]), long[] org.apache.commons.lang3.ArrayUtils#removeAll(long[], int[]), float[] org.apache.commons.lang3.ArrayUtils#removeAll(float[], int[]), double[] org.apache.commons.lang3.ArrayUtils#removeAll(double[], int[]), int[] org.apache.commons.lang3.ArrayUtils#removeAll(int[], int[]), short[] org.apache.commons.lang3.ArrayUtils#removeAll(short[], int[])]
 @ line 4, column 29.
       final byte[] grafting = org.apache.commons.lang3.ArrayUtils.removeAll(vetting, 0);
                               ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    19,
    "GROOVY-11050",
    "Groovy",
    "groovyc",
    "Unable to construct Map with repeating key/value entries",
    "https://issues.apache.org/jira/browse/GROOVY-11050",
    "erasure",
    "None",
    "In Progress",
    "",
    "2023-05-10 14:26:24+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final <V> void test() {
    V key = null;
    CharSequence value = null;
    java.util.Map.of(key, value); // succeeds
    java.util.Map.of(key, value, key, value); // fails
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 6: [Static type checking] - Cannot call <K,V> java.util.Map#of(K, V, K, V) with arguments [V, java.lang.CharSequence, V, java.lang.CharSequence]
 @ line 6, column 5.
       java.util.Map.of(key, value, key, value);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    20,
    "GROOVY-11047",
    "Groovy",
    "groovyc",
    "Fail to catch incompatible return type of lambdas",
    "https://issues.apache.org/jira/browse/GROOVY-11047",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-05-05 15:30:00+00:00",
    "None",
    "Unexpected Runtime Behavior",
    "None",
    "class Main {
  static final void test() {
        java.util.stream.StreamSupport.<Process>stream(()-> 1, 1, false); // Error, the return type of lamba is not compatible with the expected type.
  }
}",
    ""
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    21,
    "GROOVY-11046",
    "Groovy",
    "groovyc",
    "Better diagnostic message instead of stacktrace?",
    "https://issues.apache.org/jira/browse/GROOVY-11046",
    "base",
    "None",
    "Open",
    "",
    "2023-05-05 13:51:21+00:00",
    "None",
    "crash",
    "None",
    "class Test {
    void test() {
        org.apache.logging.log4j.core.async.AsyncLogger d = null;
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
General error during conversion: java.lang.NoClassDefFoundError: com.lmax.disruptor.EventTranslatorVararg
java.lang.RuntimeException: java.lang.NoClassDefFoundError: com.lmax.disruptor.EventTranslatorVararg
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:982)
        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:694)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:668)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:649)
        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)
        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)
        at org.codehaus.groovy.tools.FileSystemCompiler.main(FileSystemCompiler.java:189)
Caused by: java.lang.NoClassDefFoundError: com.lmax.disruptor.EventTranslatorVararg
        at org.codehaus.groovy.ast.decompiled.AsmReferenceResolver.resolveClass(AsmReferenceResolver.java:46)
        at org.codehaus.groovy.ast.decompiled.TypeSignatureParser.visitEnd(TypeSignatureParser.java:113)
        at groovyjarjarasm.asm.signature.SignatureReader.parseType(SignatureReader.java:206)
        at groovyjarjarasm.asm.signature.SignatureReader.accept(SignatureReader.java:124)
        at org.codehaus.groovy.ast.decompiled.ClassSignatureParser.parseClassSignature(ClassSignatureParser.java:111)
        at org.codehaus.groovy.ast.decompiled.ClassSignatureParser.configureClass(ClassSignatureParser.java:35)
        at org.codehaus.groovy.ast.decompiled.DecompiledClassNode.lazyInitSupers(DecompiledClassNode.java:189)
        at org.codehaus.groovy.ast.decompiled.DecompiledClassNode.getGenericsTypes(DecompiledClassNode.java:148)
        at org.codehaus.groovy.control.GenericsVisitor.checkGenericsUsage(GenericsVisitor.java:157)
        at org.codehaus.groovy.control.GenericsVisitor.checkGenericsUsage(GenericsVisitor.java:151)
        at org.codehaus.groovy.control.GenericsVisitor.visitDeclarationExpression(GenericsVisitor.java:113)
        at org.codehaus.groovy.ast.expr.DeclarationExpression.visit(DeclarationExpression.java:92)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)
        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)
        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:72)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)
        at org.codehaus.groovy.control.GenericsVisitor.visitConstructorOrMethod(GenericsVisitor.java:93)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)
        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1142)
        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1135)
        at org.codehaus.groovy.control.GenericsVisitor.visitClass(GenericsVisitor.java:74)
        at org.codehaus.groovy.control.CompilationUnit.lambda$addPhaseOperations$7(CompilationUnit.java:238)
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:948)
        ... 8 more
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    22,
    "GROOVY-11042",
    "Groovy",
    "groovyc",
    "Wrong method is chosen from the Groovy runtime",
    "https://issues.apache.org/jira/browse/GROOVY-11042",
    "base",
    "None",
    "Open",
    "",
    "2023-05-02 15:06:41+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final void test() {
    String[] p1 = new String[]{""v2""};
    String[] p2 = new String[]{""v1""};
    java.util.TreeMap<String[], Number> x = null;
    x.subMap(p1, p2);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Cannot call <K,V> org.codehaus.groovy.runtime.DefaultGroovyMethods#subMap(java.util.Map<K, V>, K[]) with arguments [java.util.TreeMap<java.lang.String[], java.lang.Number>, java.lang.String[], java.lang.String[]]
 @ line 6, column 5.
       x.subMap(p1, p2);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    23,
    "GROOVY-11036",
    "Groovy",
    "groovyc",
    "StackOverflowError in cyclic interface inheritance",
    "https://issues.apache.org/jira/browse/GROOVY-11036",
    "ill-typed",
    "None",
    "Closed",
    "Fixed",
    "2023-04-28 08:57:18+00:00",
    "2023-05-01 17:16:18+00:00",
    "crash",
    "3 days, 8:19:00",
    "interface Bar {}
interface Foo extends Foo, Bar {}",
    ">>> a serious error occurred: null
>>> stacktrace:
java.lang.StackOverflowError
  at org.codehaus.groovy.ast.ClassNode.getText(ClassNode.java:1606)
  at org.codehaus.groovy.ast.ClassNode.hashCode(ClassNode.java:734)
  at org.codehaus.groovy.ast.ClassNode.hashCode(ClassNode.java:734)
  at java.base/java.util.HashMap.hash(HashMap.java:339)
  at java.base/java.util.HashMap.put(HashMap.java:607)
  at java.base/java.util.HashSet.add(HashSet.java:220)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:466)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)
  at org.codehaus.groovy.ast.ClassNode.getAllInterfaces(ClassNode.java:470)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    24,
    "GROOVY-11035",
    "Groovy",
    "groovyc",
    "Inferred type is Object when having a complex inheritance chain of interfaces",
    "https://issues.apache.org/jira/browse/GROOVY-11035",
    "base",
    "None",
    "Resolved",
    "Duplicate",
    "2023-04-28 08:53:37+00:00",
    "2023-04-30 14:32:51+00:00",
    "Unexpected Compile-Time Error",
    "2 days, 5:39:14",
    "@Grab('org.apache.commons:commons-collections4:4.4')
import org.apache.commons.collections4.iterators.*;
class Main {
  @groovy.transform.TypeChecked test() {
    EmptyListIterator<Number> tmp = null
    Number x = tmp.next()
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Cannot assign value of type java.lang.Object to variable of type java.lang.Number
 @ line 6, column 16.
       Number x = tmp.next();
                  ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    25,
    "GROOVY-11026",
    "Groovy",
    "groovyc",
    "NPE when checking compatibility of method reference",
    "https://issues.apache.org/jira/browse/GROOVY-11026",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2023-04-26 15:40:14+00:00",
    "2023-04-29 14:52:03+00:00",
    "crash",
    "2 days, 23:11:49",
    "import java.util.function.*;
import java.util.List;
class Main {
  static final void test() {
        List<String> x = null;
        m(x::set);
  }
  static final <T, R> void m(BiFunction<T, R, R> y) {}
}",
    "BUG! exception in phase 'instruction selection' in source unit 'test.groovy' unexpected NullPointerException
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:953)
        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:694)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:668)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:649)
        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)
        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)
        at org.codehaus.groovy.tools.FileSystemCompiler.main(FileSystemCompiler.java:189)
Caused by: java.lang.NullPointerException
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.checkCompatibleAssignmentTypes(StaticTypeCheckingSupport.java:725)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitMethodPointerExpression$25(StaticTypeCheckingVisitor.java:2504)
        at java.base/java.util.Optional.ifPresent(Optional.java:183)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodPointerExpression(StaticTypeCheckingVisitor.java:2496)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitMethodReferenceExpression(CodeVisitorSupport.java:319)
        at org.codehaus.groovy.ast.expr.MethodReferenceExpression.visit(MethodReferenceExpression.java:34)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodCallArguments(StaticTypeCheckingVisitor.java:2912)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitStaticMethodCallExpression(StaticTypeCheckingVisitor.java:2820)
        at org.codehaus.groovy.ast.expr.StaticMethodCallExpression.visit(StaticMethodCallExpression.java:44)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitExpressionStatement(StaticTypeCheckingVisitor.java:2217)
        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)
        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:72)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitConstructorOrMethod$28(StaticTypeCheckingVisitor.java:2681)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitConstructorOrMethod(StaticTypeCheckingVisitor.java:2681)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.startMethodInference(StaticTypeCheckingVisitor.java:2664)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethod(StaticTypeCheckingVisitor.java:2643)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitConstructorOrMethod(StaticCompilationVisitor.java:189)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethod(StaticCompilationVisitor.java:204)
        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1144)
        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1137)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClass(ClassCodeVisitorSupport.java:52)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitClass$3(StaticTypeCheckingVisitor.java:499)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitClass(StaticTypeCheckingVisitor.java:499)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitClass(StaticCompilationVisitor.java:151)
        at org.codehaus.groovy.transform.sc.StaticCompileTransformation.visit(StaticCompileTransformation.java:68)
        at org.codehaus.groovy.control.customizers.ASTTransformationCustomizer.call(ASTTransformationCustomizer.groovy:303)
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:948)
        ... 8 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    26,
    "GROOVY-11025",
    "Groovy",
    "groovyc",
    "Conficts between type parameter names result in unexpected type error",
    "https://issues.apache.org/jira/browse/GROOVY-11025",
    "base",
    "None",
    "Open",
    "",
    "2023-04-26 13:02:44+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.Map;
import java.util.List;
class Main {
  static <K, V> void m(Map<K, V> map, K key, V value) {}
  static final <K>void test() {
    Map<List<K>, K> map = null;
    List<K> key = null;
    K value = null;
    Main.m(map, key, value);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 11: [Static type checking] - Cannot find matching method Main#m(java.util.Map<java.util.List<K>, K>, java.util.List<K>, K). Please check if the declared type is correct and if the method exists.
 @ line 11, column 5.
       Main.m(map, key, value);
       ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    27,
    "GROOVY-11022",
    "Groovy",
    "groovyc",
    "StackOverflowError when having parameterized function with recursive bounds",
    "https://issues.apache.org/jira/browse/GROOVY-11022",
    "base",
    "None",
    "Open",
    "",
    "2023-04-24 08:24:52+00:00",
    "None",
    "crash",
    "None",
    "class Test<K, V> {
    public static <K extends Comparable<? super K>, V> Test<K, V> m(K k1, V v1) {
        return new Test<K, V>()
    }
}
class Main {
    @groovy.transform.TypeChecked test() {
        Test.<Object, Integer>m(null, 1)
    }
}",
    "   >>> a serious error occurred: null
   >>> stacktrace:
   java.lang.StackOverflowError
       at org.codehaus.groovy.ast.ClassNode.getText(ClassNode.java:1606)
       at org.codehaus.groovy.ast.ClassNode.equals(ClassNode.java:729)
       at org.codehaus.groovy.ast.ClassHelper.isObjectType(ClassHelper.java:525)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.hasNonTrivialBounds(StaticTypeCheckingSupport.java:1880)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1833)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1843)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1890)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1834)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1843)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1890)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1834)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1843)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1890)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1834)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1843)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1890)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1834)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1821)
       at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsContext(StaticTypeCheckingSupport.java:1905)
..."
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    28,
    "GROOVY-11021",
    "Groovy",
    "groovyc",
    "Resolving wrong overloaded method when having variable arguments",
    "https://issues.apache.org/jira/browse/GROOVY-11021",
    "base",
    "None",
    "Open",
    "",
    "2023-04-22 16:49:27+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.Comparator;
class Foo<T> {}
class Bar<T> {
  static <T> Bar<T> concat(Bar<? extends T>... x)  { return null; }
  static <T> Bar<T> concat(Bar<? extends Bar<? extends T>> x)  { return null; }
  void toSortedSet(Comparator<? super T> x) {}
}
class Main {
  static final void test() {
    Bar<Foo<Number>> x = null;
    Comparator<Foo<Number>> y = null;
    Bar.concat(x).toSortedSet(y);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
groovy35.groovy: 15: [Static type checking] - Cannot call <T> Bar#concat(Bar<? extends Bar<? extends T>>) with arguments [Bar<Foo<java.lang.Number>>]
 @ line 15, column 15.
       Bar.concat(x).toSortedSet(y);
                 ^
groovy35.groovy: 15: [Static type checking] - Cannot find matching method java.lang.Object#toSortedSet(java.util.Comparator<Foo<java.lang.Number>>). Please check if the declared type is correct and if the method exists.
 @ line 15, column 5.
       Bar.concat(x).toSortedSet(y);
       ^
2 errors"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    29,
    "GROOVY-11020",
    "Groovy",
    "groovyc",
    "NullPointerException in instruction selection when calling parameterized function whose type parameter has an upper bound corresponding to a SAM type",
    "https://issues.apache.org/jira/browse/GROOVY-11020",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2023-04-19 09:15:16+00:00",
    "2023-04-19 17:11:39+00:00",
    "crash",
    "7:56:23",
    "import java.util.*;
import java.util.function.*;
class Main {
  static final void test(ArrayDeque<String> y) {
    m(y::addFirst);
  }
  static <C extends Consumer<String>> void m(C cl) {}
}",
    ">>> a serious error occurred: BUG! exception in phase 'instruction selection' in source unit 'Main.groovy' unexpected NullPointerException
>>> stacktrace:
BUG! exception in phase 'instruction selection' in source unit 'Main.groovy' unexpected NullPointerException
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:953)
        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:694)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:668)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:649)
        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)
        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)
        at org.codehaus.groovy.tools.FileSystemCompiler.main(FileSystemCompiler.java:189)
Caused by: java.lang.NullPointerException
        at org.codehaus.groovy.ast.tools.GenericsUtils.parameterizeSAM(GenericsUtils.java:974)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.inferClosureParameterTypes(StaticTypeCheckingVisitor.java:3110)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodCallArguments(StaticTypeCheckingVisitor.java:2904)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitStaticMethodCallExpression(StaticTypeCheckingVisitor.java:2819)
        at org.codehaus.groovy.ast.expr.StaticMethodCallExpression.visit(StaticMethodCallExpression.java:44)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitExpressionStatement(StaticTypeCheckingVisitor.java:2217)
        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)
        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:72)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitConstructorOrMethod$28(StaticTypeCheckingVisitor.java:2680)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitConstructorOrMethod(StaticTypeCheckingVisitor.java:2680)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.startMethodInference(StaticTypeCheckingVisitor.java:2663)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethod(StaticTypeCheckingVisitor.java:2642)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitConstructorOrMethod(StaticCompilationVisitor.java:189)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethod(StaticCompilationVisitor.java:204)
        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1144)
        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1137)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClass(ClassCodeVisitorSupport.java:52)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitClass$3(StaticTypeCheckingVisitor.java:499)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:463)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitClass(StaticTypeCheckingVisitor.java:499)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitClass(StaticCompilationVisitor.java:151)
        at org.codehaus.groovy.transform.sc.StaticCompileTransformation.visit(StaticCompileTransformation.java:68)
        at org.codehaus.groovy.control.customizers.ASTTransformationCustomizer.call(ASTTransformationCustomizer.groovy:303)
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:948)
        ... 8 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    30,
    "GROOVY-11013",
    "Groovy",
    "groovyc",
    "Fail to substitute type when having SAM type with generics",
    "https://issues.apache.org/jira/browse/GROOVY-11013",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-04-14 14:09:05+00:00",
    "2023-05-26 21:09:56+00:00",
    "Unexpected Compile-Time Error",
    "42 days, 7:00:51",
    "import java.util.*;
@FunctionalInterface
interface Foo<T> {
  int m(List<T> x);
}
class Main {
  static final void test() {
    Foo<String> p = (List<String> x) -> 1;
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 11: [Static type checking] - Expected type java.util.List<T> for lambda parameter: x
 @ line 11, column 22.
       Foo<String> p = (List<String> x) -> 1;
                        ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    31,
    "GROOVY-11012",
    "Groovy",
    "groovyc",
    "Wrong type is inferred when calling method defined in the parent class",
    "https://issues.apache.org/jira/browse/GROOVY-11012",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-04-13 16:19:25+00:00",
    "2023-04-30 15:58:06+00:00",
    "Unexpected Compile-Time Error",
    "16 days, 23:38:41",
    "interface Bar<V> {
  default V get(Object x, Object y) { return null; }
}
class Foo<V> implements Bar<V> {
  static <V> Foo<V> create() { return null; }
}
class Main {
  static final void test() {
    Number x = Foo.<Number>create().get(null, null);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 11: [Static type checking] - Cannot assign value of type java.lang.Object to variable of type java.lang.Number
 @ line 11, column 16.
       Number x = Foo.<Number>create().get(null, null);
                  ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    32,
    "GROOVY-11010",
    "Groovy",
    "groovyc",
    "Ambiguous method reference when expecting a SAM type",
    "https://issues.apache.org/jira/browse/GROOVY-11010",
    "erasure",
    "None",
    "Open",
    "",
    "2023-04-13 15:27:03+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
class Main {
  static final void test() {
    from(Main::m);
  }
  static <K, V> void from(Function<K, V> f) {}
  static <V> void from(Supplier<V> f) {}
  static int m(String x) { return 1; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Reference to method is ambiguous. Cannot choose between [void Main#from(java.util.function.Supplier<V>), void Main#from(java.util.function.Function<K, V>)]
 @ line 6, column 5.
       from(Main::m);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    33,
    "GROOVY-11009",
    "Groovy",
    "groovyc",
    "STC resolves wrong method reference",
    "https://issues.apache.org/jira/browse/GROOVY-11009",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-04-11 13:35:00+00:00",
    "2023-04-18 20:51:56+00:00",
    "Unexpected Compile-Time Error",
    "7 days, 7:16:56",
    "import java.util.function.*;
class Main {
  static final void test() {
    final Function<Double, Double> x = Main::clone;
  }
  public static <T> T clone(T x) { return x; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 5: [Static type checking] - Invalid return type: java.lang.Object is not convertible to java.lang.Double
 @ line 5, column 40.
       final Function<Double, Double> x = Main::clone;
                                          ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    34,
    "GROOVY-11004",
    "Groovy",
    "groovyc",
    "Incompatible generic argument types when mixing diamond operator in parameterized function",
    "https://issues.apache.org/jira/browse/GROOVY-11004",
    "erasure",
    "None",
    "Open",
    "",
    "2023-04-07 13:44:49+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*;
class Main {
  static final void test() {
    Map<Number, String> x = null;
    Map<Number, String> y = Collections.unmodifiableNavigableMap(new TreeMap<>(x));
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Incompatible generic argument types. Cannot assign java.util.NavigableMap<java.lang.Object, java.lang.Object> to: java.util.Map<java.lang.Number, java.lang.String>
 @ line 6, column 29.
       Map<Number, String> y = Collections.unmodifiableNavigableMap(new TreeMap<>(x));
                               ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    35,
    "GROOVY-11003",
    "Groovy",
    "groovyc",
    "Cannot find method with variable arguments when using fully qualified class names",
    "https://issues.apache.org/jira/browse/GROOVY-11003",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2023-04-07 13:07:32+00:00",
    "2023-04-11 15:29:21+00:00",
    "Unexpected Compile-Time Error",
    "4 days, 2:21:49",
    "class Main {
  static final void test(java.util.List<Integer> p) {
    m(1, p);
  }
  static <T> void m(Integer x, java.util.List<T>... items) { }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 3: [Static type checking] - Cannot find matching method Main#m(int, java.util.List<java.lang.Integer>). Please check if the declared type is correct and if the method exists.
 @ line 3, column 5.
       m(1, p);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    36,
    "GROOVY-11002",
    "Groovy",
    "groovyc",
    "Unexpected type mismatch when having overloaded methods with variable arguments",
    "https://issues.apache.org/jira/browse/GROOVY-11002",
    "base",
    "None",
    "Open",
    "",
    "2023-04-07 13:04:11+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.Supplier;
class Main {
  static final void test() {
    Main.<String>m(() -> ""df"", ""fdaf"");
  }
  static <T> void m(Supplier<T> x, T... y) {}
  static <T extends Comparable<? extends T>> void m(T...y) {}
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 5: [Static type checking] - Cannot return value of type java.lang.String for lambda expecting int
 @ line 5, column 26.
       Main.<String>m(() -> ""df"", ""fdaf"");
                            ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    37,
    "GROOVY-10999",
    "Groovy",
    "groovyc",
    "Unexpected type mismatch when having bounded type parameters",
    "https://issues.apache.org/jira/browse/GROOVY-10999",
    "base",
    "None",
    "Open",
    "",
    "2023-04-04 07:52:07+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Main {
  static final <U extends Number, H extends U> void test() {
    def x = java.util.Collections.<H, H>emptyNavigableMap().ceilingKey((H) null);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 3: [Static type checking] - Cannot call java.util.NavigableMap#ceilingKey(H) with arguments [H]
 @ line 3, column 13.
       def x = java.util.Collections.<H, H>emptyNavigableMap().ceilingKey((H) null);
               ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    38,
    "GROOVY-10998",
    "Groovy",
    "groovyc",
    "Not reporting cyclic dependency in function's type parameters",
    "https://issues.apache.org/jira/browse/GROOVY-10998",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-03-31 09:15:20+00:00",
    "None",
    "crash",
    "None",
    "class Test {
  static <T extends T> void test() {}
}",
    ""
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    39,
    "GROOVY-10997",
    "Groovy",
    "groovyc",
    "Unexpected type mismatch when using super on a bounded type parameter",
    "https://issues.apache.org/jira/browse/GROOVY-10997",
    "erasure",
    "None",
    "Open",
    "",
    "2023-03-31 09:12:18+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.stream.*;
import java.util.function.*;
class Main {
  static final <Y, I extends Y> void test() {
    Stream<I> x = null;
    Consumer<Y> y = null;
    x.forEach(y);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
groovy30.groovy: 9: [Static type checking] - Cannot call java.util.stream.Stream#forEach(java.util.function.Consumer<? super I>) with arguments [java.util.function.Consumer<Y>]
 @ line 9, column 5.
       x.forEach(y);
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    40,
    "GROOVY-10994",
    "Groovy",
    "groovyc",
    "Fail to resolve method reference with generics",
    "https://issues.apache.org/jira/browse/GROOVY-10994",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-03-28 11:45:12+00:00",
    "2023-04-11 21:19:52+00:00",
    "Unexpected Compile-Time Error",
    "14 days, 9:34:40",
    "import java.util.List;
import java.util.function.Predicate;
class Main {
  static final <T> void test() {
    List<T> x = null;
    Predicate<? super T> y = x::add;
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 9: Failed to find method 'add(T)' for the type: java.util.List<T> @ line 9, column 30.
       Predicate<? super T> y = x::add;
                                ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    41,
    "GROOVY-10992",
    "Groovy",
    "groovyc",
    "Unexpected type mismatch when calling a parameterized function with a bounded type parameter",
    "https://issues.apache.org/jira/browse/GROOVY-10992",
    "erasure",
    "None",
    "Open",
    "",
    "2023-03-28 09:07:17+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.Supplier;
import java.util.function.BinaryOperator;
import java.util.stream.Stream;
class Main {
  static final <X extends Number> void test() {
    Supplier<Stream<X>> x = null;
    X y = null;
    BinaryOperator<X> z = null;
    X result = x.get().reduce(y, z);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 11: [Static type checking] - Cannot call java.util.stream.Stream#reduce(X, java.util.function.BinaryOperator<X extends java.lang.Number>) with arguments [X, java.util.function.BinaryOperator<X>]
 @ line 11, column 16.
       X result = x.get().reduce(y, z);
                  ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    42,
    "GROOVY-10984",
    "Groovy",
    "groovyc",
    "Unexpected parser error when having fully qualified classes and constructor references",
    "https://issues.apache.org/jira/browse/GROOVY-10984",
    "base",
    "None",
    "Open",
    "",
    "2023-03-27 08:47:25+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.Supplier;
import java.util.PriorityQueue;
class Main {
  static final void test() {
    java.util.function.Supplier<java.util.PriorityQueue<Number>> x = java.util.PriorityQueue<Number>::new; // parsing error
    Supplier<PriorityQueue<Number>> y = PriorityQueue<Number>::new; // no error
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: Unexpected input: '>::' @ line 6, column 101.
   ava.util.PriorityQueue<Number>::new;
                                 ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    43,
    "GROOVY-10979",
    "Groovy",
    "groovyc",
    "Cannot provide method reference to a type parameter instantiated with a SAM type",
    "https://issues.apache.org/jira/browse/GROOVY-10979",
    "base",
    "None",
    "Open",
    "",
    "2023-03-21 10:12:19+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
import java.util.stream.*;
public class Test {
    public static void test() {
      Stream<Number> x = null;
      BiFunction<Function<String, Integer>, Number, Function<String, Integer>> y = null;
      BinaryOperator<Function<String, Integer>> z = null;
      x.<Function<String, Integer>>reduce(Test::m, y, z);  // fails
      x.reduce(Test::m, y, z);   // fails
      x.reduce((d) -> 1, y, z);   // works
    }
    public static Integer m(String x) { return 1; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 12: The argument is a method reference, but the parameter type is not a functional interface
 @ line 12, column 43.
   ction<String, Integer>>reduce(Test::m, y
                                 ^
test.groovy: 13: The argument is a method reference, but the parameter type is not a functional interface
 @ line 13, column 16.
         x.reduce(Test::m, y, z);   // fails
                  ^
2 errors"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    44,
    "GROOVY-10977",
    "Groovy",
    "groovyc",
    "STC does not catch the type error when a generic is instantiated with bounded type parameter",
    "https://issues.apache.org/jira/browse/GROOVY-10977",
    "ill-typed",
    "None",
    "Open",
    "",
    "2023-03-17 11:48:34+00:00",
    "None",
    "Unexpected Runtime Behavior",
    "None",
    "import java.util.*;
public class Test {
    public static <T extends Number> void test() {
      List<T> d = null;
      d.add(false);
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 8: [Static type checking] - Cannot find matching method java.util.List#add(boolean). Please check if the declared type is correct and if the method exists.
 @ line 8, column 7.
         d.add(false);
         ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    45,
    "GROOVY-10975",
    "Groovy",
    "groovyc",
    "STC rejects program when passing method reference in parameterized function",
    "https://issues.apache.org/jira/browse/GROOVY-10975",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2023-03-14 20:41:20+00:00",
    "2023-08-25 19:45:40+00:00",
    "Unexpected Compile-Time Error",
    "163 days, 23:04:20",
    "import java.util.*;
class Main {
  static final void test() {
    Collection<Integer> x = null;
    WeakHashMap<Integer, Integer> y = null;
    new Hashtable<java.lang.IllegalStateException, Boolean>(Collections.min(x, y::put));
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 8: [Static type checking] - Cannot find matching constructor java.util.Hashtable(java.lang.Object)
 @ line 8, column 5.
       new Hashtable<java.lang.IllegalStateException, Boolean>(Collections.min(x, y::put));
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    46,
    "GROOVY-10974",
    "Groovy",
    "groovyc",
    "Fail to perform SAM conversion using method references",
    "https://issues.apache.org/jira/browse/GROOVY-10974",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-03-14 12:52:22+00:00",
    "2023-08-31 19:20:40+00:00",
    "Unexpected Compile-Time Error",
    "170 days, 6:28:18",
    "import java.util.*;
import java.util.stream.*;
import java.util.function.*;
class Main {
  static final void test(DoubleStream x, ObjDoubleConsumer<Boolean> y,
                         BiConsumer<Boolean, Boolean> z) {
        Spliterator.OfDouble d = null;
        StreamSupport.doubleStream(d, x.collect(
            () -> true, y::accept, z::accept));
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 10: [Static type checking] - Cannot find matching method java.util.stream.StreamSupport#doubleStream(java.util.Spliterator$OfDouble, U). Please check if the declared type is correct and if the method exists.
 @ line 10, column 9.
           StreamSupport.doubleStream(d, x.collect(
           ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    47,
    "GROOVY-10972",
    "Groovy",
    "groovyc",
    "Issue in resolving overloaded method reference",
    "https://issues.apache.org/jira/browse/GROOVY-10972",
    "ill-typed",
    "None",
    "Closed",
    "Fixed",
    "2023-03-09 15:51:03+00:00",
    "2023-04-19 15:30:15+00:00",
    "Unexpected Runtime Behavior",
    "40 days, 23:39:12",
    "import java.util.function.Function;
import java.util.LinkedList;
class Foo {}
class Test {
    public static void main(String[] args) {
        LinkedList<Foo> x = new LinkedList();
        x.add(new Foo());
        Function<Integer, Foo> z = x::remove;
        Foo k = z.apply(0); // ClassCastException boolean cannot be cast to Foo.
    }
}",
    "Exception in thread ""main"" org.codehaus.groovy.runtime.typehandling.GroovyCastException: Cannot cast object 'false' with class 'java.lang.Boolean' to class 'Foo'
        at org.codehaus.groovy.runtime.typehandling.DefaultTypeTransformation.continueCastOnSAM(DefaultTypeTransformation.java:425)
        at org.codehaus.groovy.runtime.typehandling.DefaultTypeTransformation.continueCastOnNumber(DefaultTypeTransformation.java:336)
        at org.codehaus.groovy.runtime.typehandling.DefaultTypeTransformation.castToType(DefaultTypeTransformation.java:256)
        at org.codehaus.groovy.vmplugin.v8.IndyInterface.fromCache(IndyInterface.java:321)
        at Test.main(test.groovy:14)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    48,
    "GROOVY-10971",
    "Groovy",
    "groovyc",
    "STC is looking for the wrong constructor reference",
    "https://issues.apache.org/jira/browse/GROOVY-10971",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-03-09 14:28:01+00:00",
    "2023-04-12 20:25:16+00:00",
    "Unexpected Compile-Time Error",
    "34 days, 5:57:15",
    "class Foo {
  Foo(String d) {}
}
class Main {
  static final void test() {
        def x = java.util.stream.Collectors.groupingBy(Main::m) // works;
        def y = java.util.stream.Collectors.groupingBy(Foo::new) // fails;
  }
  static Foo m(String x) { return null; }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 8: [Static type checking] - Cannot find matching constructor Foo(java.lang.Object)
 @ line 8, column 56.
   .stream.Collectors.groupingBy(Foo::new)
                                 ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    49,
    "GROOVY-10961",
    "Groovy",
    "groovyc",
    "STC rejects program when having SAM types and conditionals",
    "https://issues.apache.org/jira/browse/GROOVY-10961",
    "base",
    "None",
    "Open",
    "",
    "2023-03-06 12:06:31+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
import java.util.Deque;
class Main {
  static final void test(Deque<Integer> p1, Supplier<Integer> p2) {
    Supplier<Integer> x = (true) ? p1::peek : p2;
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 8: [Static type checking] - Cannot assign value of type java.lang.Object to variable of type java.util.function.Supplier<java.lang.Integer>
 @ line 8, column 27.
       Supplier<Integer> x = (true) ? p1::peek : p2;
                             ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    50,
    "GROOVY-10959",
    "Groovy",
    "groovyc",
    "Type checking fails when casting method references",
    "https://issues.apache.org/jira/browse/GROOVY-10959",
    "erasure",
    "None",
    "Open",
    "",
    "2023-03-03 15:57:14+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.function.*;
import java.util.stream.*;
class Main {
  static final void test() {
    Foo<Object, String> x = null;
    Foo<String, String> y = null;
    BinaryOperator<String> z = null;
    final Object powdery = java.util.stream.Collectors.toConcurrentMap(
        x::m as Function<Object, String>,
        y::m as Function<String, String>,
        z
    );
  }
}
interface Foo<T1, T2> {
  T2 m(T1 x);
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 11: [Static type checking] - Cannot call <T,K,U> java.util.stream.Collectors#toConcurrentMap(java.util.function.Function<? super T, ? extends K>, java.util.function.Function<? super T, ? extends U>, java.util.function.BinaryOperator<U>) with arguments [java.util.function.Function<java.lang.Object, java.lang.String>, java.util.function.Function<java.lang.String, java.lang.String>, java.util.function.BinaryOperator<java.lang.String>]
 @ line 11, column 28.
       final Object powdery = java.util.stream.Collectors.toConcurrentMap(
                              ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    51,
    "GROOVY-10956",
    "Groovy",
    "groovyc",
    "Initialization of non-static inner class fails",
    "https://issues.apache.org/jira/browse/GROOVY-10956",
    "base",
    "None",
    "Open",
    "",
    "2023-03-01 12:33:54+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Foo {
    public class Bar {
        Bar() {}
    }
}
public class Test {
    void test() {
        Foo.Bar x = new Foo().new Bar(); // works
        Foo y = new Foo();
        Foo.Bar z = y.new Bar(); // doesn't work
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 14: unable to resolve class Bar
 @ line 14, column 21.
           Foo.Bar z = y.new Bar(); // works
                       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    52,
    "GROOVY-10930",
    "Groovy",
    "groovyc",
    "STC accepts program although constructor reference is invalid",
    "https://issues.apache.org/jira/browse/GROOVY-10930",
    "ill-typed",
    "None",
    "Closed",
    "Fixed",
    "2023-02-10 10:46:07+00:00",
    "2023-02-15 16:59:23+00:00",
    "Unexpected Runtime Behavior",
    "5 days, 6:13:16",
    "import java.util.function.*;
class Bar {}
public class Test {
    public static void main(String[] args) {
      m(Bar::new);
    }
    static <X> void m(Function<String, X> d) {
      d.apply(""dfa"")
    }
}",
    "Exception in thread ""main"" groovy.lang.GroovyRuntimeException: Could not find matching constructor for: Bar(String)
        at groovy.lang.MetaClassImpl.invokeConstructor(MetaClassImpl.java:1908)
        at groovy.lang.MetaClassImpl.invokeConstructor(MetaClassImpl.java:1677)
        at org.codehaus.groovy.vmplugin.v8.IndyInterface.fromCache(IndyInterface.java:321)
        at Test.ctorRef$main$0(test.groovy)
        at Test.m(test.groovy:13)
        at Test.main(test.groovy:9)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    53,
    "GROOVY-10914",
    "Groovy",
    "groovyc",
    "Method ambiguity error even if the given argument has an explicit type",
    "https://issues.apache.org/jira/browse/GROOVY-10914",
    "base",
    "None",
    "Closed",
    "Information Provided",
    "2023-01-24 14:24:08+00:00",
    "2023-02-04 14:09:49+00:00",
    "Unexpected Compile-Time Error",
    "10 days, 23:45:41",
    "import java.util.function.*;
class Main {
  static final void test() {
    String str = ""foo""
    LongConsumer y = str.chars().asLongStream().summaryStatistics();
    str.chars().asLongStream().summaryStatistics().andThen(y); // Does not work
    str.chars().asLongStream().summaryStatistics().andThen((LongConsumer) y); // it works
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
Main.groovy: 8: [Static type checking] - Reference to method is ambiguous. Cannot choose between [java.util.function.IntConsumer java.util.function.IntConsumer#andThen(java.util.function.IntConsumer), java.util.function.LongConsumer java.util.function.LongConsumer#andThen(java.util.function.LongConsumer)]
 @ line 8, column 5.
       str.chars().asLongStream().summaryStatistics().andThen(y); // Does not work
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    54,
    "GROOVY-10913",
    "Groovy",
    "groovyc",
    "Type inference yields a wrong type even if the type of the associated variable is given",
    "https://issues.apache.org/jira/browse/GROOVY-10913",
    "erasure",
    "None",
    "Open",
    "",
    "2023-01-22 11:12:23+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "import java.util.*;
import java.util.stream.*;
class Test {
    void test() {
      Stream<Number> x = Arrays.stream(new Integer[]{1}).flatMap((y) ->
        Arrays.stream(new Long[]{(long) 1}));
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Incompatible generic argument types. Cannot assign java.util.stream.Stream<java.lang.Long> to: java.util.stream.Stream<java.lang.Number>
 @ line 6, column 26.
         Stream<Number> x = Arrays.stream(new Integer[]{1}).flatMap((y) -> Arrays.stream(new Long[]{(long) 1}));
                            ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    55,
    "GROOVY-10912",
    "Groovy",
    "groovyc",
    "Inconsistency in the treatment of primitives values when passed as call arguments",
    "https://issues.apache.org/jira/browse/GROOVY-10912",
    "base",
    "None",
    "Open",
    "",
    "2023-01-21 16:52:03+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Test {
    void test() {
      char c = 'c' // works
      double e = 10.0; // works
      Character v = Character.valueOf('c'); // 'c' is treated as String
      Double d = Double.valueOf(10.0);  // 10.0 is treated as BigDecimal
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 4: [Static type checking] - Cannot find matching method java.lang.Character#valueOf(java.lang.String). Please check if the declared type is correct and if the method exists.
 @ line 4, column 21.
         Character v = Character.valueOf('c');
                       ^
test.groovy: 5: [Static type checking] - Cannot find matching method java.lang.Double#valueOf(java.math.BigDecimal). Please check if the declared type is correct and if the method exists.
 @ line 5, column 18.
         Double d = Double.valueOf(10.0);
                    ^
2 errors"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    56,
    "GROOVY-10870",
    "Groovy",
    "groovyc",
    "Fail to infer type argument of parameterized function",
    "https://issues.apache.org/jira/browse/GROOVY-10870",
    "erasure",
    "None",
    "Open",
    "",
    "2022-12-14 14:11:09+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "class Foo<X> {}
class Test {
  static void test() {
    m(false, new Foo<>());
  }
  static <T> void m(T x1, Foo<T> x2) {}
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 6: [Static type checking] - Cannot call <T> Test#m(T, Foo<T>) with arguments [boolean, Foo<T>]
 @ line 6, column 5.
       m(false, new Foo<>());
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    57,
    "GROOVY-10869",
    "Groovy",
    "groovyc",
    "NullPointerException in instruction selection phase when having parameterized method",
    "https://issues.apache.org/jira/browse/GROOVY-10869",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2022-12-14 13:25:06+00:00",
    "2022-12-17 20:03:13+00:00",
    "crash",
    "3 days, 6:38:07",
    "class Foo<T> {
  Foo(T x) {}
  <T extends Short> T m(T x) {
    x
  }
}
class Test {
  static final void test() {
    Foo<Integer> tmp = new Foo<Integer>(-76);
    boolean cond = 5.0 > tmp.m(new Foo<Integer>(95).m(null));
  }
}",
    ">>> a serious error occurred: BUG! exception in phase 'instruction selection' in source unit 'test.groovy' unexpected NullPointerException
>>> stacktrace:
BUG! exception in phase 'instruction selection' in source unit 'test.groovy' unexpected NullPointerException
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:942)
        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:692)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:666)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:647)
        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)
        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)
        at org.codehaus.groovy.tools.FileSystemCompiler.main(FileSystemCompiler.java:189)
Caused by: java.lang.NullPointerException
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.getPrimitiveDistance(StaticTypeCheckingSupport.java:919)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.getDistance(StaticTypeCheckingSupport.java:935)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.allParametersAndArgumentsMatch(StaticTypeCheckingSupport.java:377)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.measureParametersAndArgumentsDistance(StaticTypeCheckingSupport.java:1118)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.chooseBestMethods(StaticTypeCheckingSupport.java:1072)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.chooseBestMethod(StaticTypeCheckingSupport.java:1049)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.findMethod(StaticTypeCheckingVisitor.java:4859)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.findMethodOrFail(StaticTypeCheckingVisitor.java:4596)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.findMethodOrFail(StaticCompilationVisitor.java:369)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.getResultType(StaticTypeCheckingVisitor.java:4440)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitBinaryExpression(StaticTypeCheckingVisitor.java:843)
        at org.codehaus.groovy.ast.expr.BinaryExpression.visit(BinaryExpression.java:57)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitBinaryExpression(StaticTypeCheckingVisitor.java:828)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitDeclarationExpression(CodeVisitorSupport.java:356)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitDeclarationExpression(ClassCodeVisitorSupport.java:161)
        at org.codehaus.groovy.ast.expr.DeclarationExpression.visit(DeclarationExpression.java:92)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitExpressionStatement(StaticTypeCheckingVisitor.java:2193)
        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)
        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:70)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitConstructorOrMethod$27(StaticTypeCheckingVisitor.java:2622)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:457)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitConstructorOrMethod(StaticTypeCheckingVisitor.java:2622)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.startMethodInference(StaticTypeCheckingVisitor.java:2605)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethod(StaticTypeCheckingVisitor.java:2584)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitConstructorOrMethod(StaticCompilationVisitor.java:189)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethod(StaticCompilationVisitor.java:204)
        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1143)
        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1136)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClass(ClassCodeVisitorSupport.java:52)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitClass$3(StaticTypeCheckingVisitor.java:493)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:457)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitClass(StaticTypeCheckingVisitor.java:493)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitClass(StaticCompilationVisitor.java:151)
        at org.codehaus.groovy.transform.sc.StaticCompileTransformation.visit(StaticCompileTransformation.java:68)
        at org.codehaus.groovy.control.customizers.ASTTransformationCustomizer.call(ASTTransformationCustomizer.groovy:303)
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:937)
        ... 8 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    58,
    "GROOVY-10847",
    "Groovy",
    "groovyc",
    "Crash with arity generics parameter mismatch during the instruction selection phase",
    "https://issues.apache.org/jira/browse/GROOVY-10847",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2022-11-18 09:17:50+00:00",
    "2022-11-19 14:48:07+00:00",
    "crash",
    "1 day, 5:30:17",
    "class A<D, I> {}
class B {
  <T extends A<Character, Boolean>, X extends T>void m(T p1, X p2) {}
}
public class Test {
  void test() {
    A<Character, Boolean> x = null;
    (new B()).m(x, new A<>());
  }
}",
    ">>> a serious error occurred: BUG! exception in phase 'instruction selection' in source unit 'test.groovy' Expected earlier checking to detect generics parameter arity mismatch
Expected: A<D,I>
Supplied: A<T extends A<java.lang.Character, java.lang.Boolean>>
>>> stacktrace:
BUG! exception in phase 'instruction selection' in source unit 'test.groovy' Expected earlier checking to detect generics parameter arity mismatch
Expected: A<D,I>
Supplied: A<T extends A<java.lang.Character, java.lang.Boolean>>
        at org.codehaus.groovy.ast.tools.GenericsUtils.extractPlaceholders(GenericsUtils.java:185)
        at org.codehaus.groovy.ast.tools.GenericsUtils.extractPlaceholders(GenericsUtils.java:149)
        at org.codehaus.groovy.ast.GenericsType.compareGenericsWithBound(GenericsType.java:337)
        at org.codehaus.groovy.ast.GenericsType.checkGenerics(GenericsType.java:261)
        at org.codehaus.groovy.ast.GenericsType.isCompatibleWith(GenericsType.java:240)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.applyGenericsConnections(StaticTypeCheckingSupport.java:1615)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.inferenceCheck(StaticTypeCheckingSupport.java:1529)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.typeCheckMethodsWithGenerics(StaticTypeCheckingSupport.java:1469)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingSupport.typeCheckMethodsWithGenerics(StaticTypeCheckingSupport.java:1417)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.typeCheckMethodsWithGenericsOrFail(StaticTypeCheckingVisitor.java:5858)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethodCallExpression(StaticTypeCheckingVisitor.java:3608)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethodCallExpression(StaticCompilationVisitor.java:219)
        at org.codehaus.groovy.ast.expr.MethodCallExpression.visit(MethodCallExpression.java:77)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitExpressionStatement(CodeVisitorSupport.java:117)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitExpressionStatement(ClassCodeVisitorSupport.java:212)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitExpressionStatement(StaticTypeCheckingVisitor.java:2219)
        at org.codehaus.groovy.ast.stmt.ExpressionStatement.visit(ExpressionStatement.java:41)
        at org.codehaus.groovy.ast.CodeVisitorSupport.visitBlockStatement(CodeVisitorSupport.java:86)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitBlockStatement(ClassCodeVisitorSupport.java:175)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitBlockStatement(StaticTypeCheckingVisitor.java:4045)
        at org.codehaus.groovy.ast.stmt.BlockStatement.visit(BlockStatement.java:70)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClassCodeContainer(ClassCodeVisitorSupport.java:139)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitConstructorOrMethod(ClassCodeVisitorSupport.java:118)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitConstructorOrMethod$28(StaticTypeCheckingVisitor.java:2644)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:456)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitConstructorOrMethod(StaticTypeCheckingVisitor.java:2644)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitMethod(ClassCodeVisitorSupport.java:110)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.startMethodInference(StaticTypeCheckingVisitor.java:2627)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitMethod(StaticTypeCheckingVisitor.java:2606)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitConstructorOrMethod(StaticCompilationVisitor.java:189)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitMethod(StaticCompilationVisitor.java:204)
        at org.codehaus.groovy.ast.ClassNode.visitMethods(ClassNode.java:1143)
        at org.codehaus.groovy.ast.ClassNode.visitContents(ClassNode.java:1136)
        at org.codehaus.groovy.ast.ClassCodeVisitorSupport.visitClass(ClassCodeVisitorSupport.java:52)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.lambda$visitClass$3(StaticTypeCheckingVisitor.java:492)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.doWithTypeCheckingExtensions(StaticTypeCheckingVisitor.java:456)
        at org.codehaus.groovy.transform.stc.StaticTypeCheckingVisitor.visitClass(StaticTypeCheckingVisitor.java:492)
        at org.codehaus.groovy.transform.sc.StaticCompilationVisitor.visitClass(StaticCompilationVisitor.java:151)
        at org.codehaus.groovy.transform.sc.StaticCompileTransformation.visit(StaticCompileTransformation.java:68)
        at org.codehaus.groovy.control.customizers.ASTTransformationCustomizer.call(ASTTransformationCustomizer.groovy:303)
        at org.codehaus.groovy.control.CompilationUnit$IPrimaryClassNodeOperation.doPhaseOperation(CompilationUnit.java:937)
        at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:692)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:666)
        at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:647)
        at org.codehaus.groovy.tools.FileSystemCompiler.compile(FileSystemCompiler.java:311)
        at org.codehaus.groovy.tools.FileSystemCompiler.doCompilation(FileSystemCompiler.java:240)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompile(FileSystemCompiler.java:165)
        at org.codehaus.groovy.tools.FileSystemCompiler.commandLineCompileWithErrorHandling(FileSystemCompiler.java:205)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    59,
    "GROOVY-10846",
    "Groovy",
    "groovyc",
    "Unable to resolve field from a bounded type parameter",
    "https://issues.apache.org/jira/browse/GROOVY-10846",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2022-11-18 08:54:00+00:00",
    "2022-11-18 19:57:28+00:00",
    "Unexpected Compile-Time Error",
    "11:03:28",
    "import java.util.function.Supplier;
class A {
  public String x;
}
public class B<T extends A, X extends Supplier<T>> {
  void test(T p) {
    p.x = ""str"";
  } 
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 12: [Static type checking] - No such property: x for class: T
 @ line 12, column 5.
       p.x = ""str"";
       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    60,
    "KT-60597",
    "Kotlin",
    "kotlinc",
    "K1: IllegalArgumentException: fromIndex(0) > toIndex(-1) when wrapping receiver with backticks",
    "https://youtrack.jetbrains.com/issue/KT-60597",
    "base",
    "None",
    "Open",
    "",
    "2023-07-21 08:07:41.272000",
    "None",
    "crash",
    "None",
    "fun test(): Unit 
{
  `java.lang.Short.TYPE`.getConstructor(TODO())
}",
    "java.lang.IllegalArgumentException: fromIndex(0) > toIndex(-1)
  at java.base/java.util.AbstractList.subListRangeCheck(AbstractList.java:509)
  at java.base/java.util.ArrayList.subList(ArrayList.java:1138)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.quickResolveToPackage(QualifiedExpressionResolver.kt:708)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveToPackageOrClassPrefix(QualifiedExpressionResolver.kt:527)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveQualifierInExpressionAndUnroll(QualifiedExpressionResolver.kt:646)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.elementChain(CallExpressionResolver.kt:295)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.getQualifiedExpressionTypeInfo(CallExpressionResolver.kt:440)
  at org.jetbrains.kotlin.types.expressions.BasicExpressionTypingVisitor.visitQualifiedExpression(BasicExpressionTypingVisitor.java:725)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:391)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:60)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:543)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtVisitor.visitQualifiedExpression(KtVisitor.java:290)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:119)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:88)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:256)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
  at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:247)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:87)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.base/java.lang.reflect.Method.invoke(Method.java:566)
  at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
  at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
----
expression.kt
File name: program.kt Physical: true Injected: false
fun test(): Unit 
{
  <caret>`java.lang.Short.TYPE`.getConstructor(TODO())
}
org.jetbrains.kotlin.utils.KotlinExceptionWithAttachments: Exception while analyzing expression in (3,3) in program.kt
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.logOrThrowException(ExpressionTypingVisitorDispatcher.java:253)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:225)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:543)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtVisitor.visitQualifiedExpression(KtVisitor.java:290)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:119)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:88)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:256)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
  at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:247)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:87)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.base/java.lang.reflect.Method.invoke(Method.java:566)
  at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
  at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.IllegalArgumentException: fromIndex(0) > toIndex(-1)
  at java.base/java.util.AbstractList.subListRangeCheck(AbstractList.java:509)
  at java.base/java.util.ArrayList.subList(ArrayList.java:1138)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.quickResolveToPackage(QualifiedExpressionResolver.kt:708)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveToPackageOrClassPrefix(QualifiedExpressionResolver.kt:527)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveQualifierInExpressionAndUnroll(QualifiedExpressionResolver.kt:646)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.elementChain(CallExpressionResolver.kt:295)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.getQualifiedExpressionTypeInfo(CallExpressionResolver.kt:440)
  at org.jetbrains.kotlin.types.expressions.BasicExpressionTypingVisitor.visitQualifiedExpression(BasicExpressionTypingVisitor.java:725)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:391)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:60)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  ... 58 more
exception: org.jetbrains.kotlin.util.KotlinFrontEndException: Exception while analyzing expression in (3,3) in program.kt
Attachments:
causeThrowable
java.lang.IllegalArgumentException: fromIndex(0) > toIndex(-1)
  at java.base/java.util.AbstractList.subListRangeCheck(AbstractList.java:509)
  at java.base/java.util.ArrayList.subList(ArrayList.java:1138)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.quickResolveToPackage(QualifiedExpressionResolver.kt:708)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveToPackageOrClassPrefix(QualifiedExpressionResolver.kt:527)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveQualifierInExpressionAndUnroll(QualifiedExpressionResolver.kt:646)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.elementChain(CallExpressionResolver.kt:295)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.getQualifiedExpressionTypeInfo(CallExpressionResolver.kt:440)
  at org.jetbrains.kotlin.types.expressions.BasicExpressionTypingVisitor.visitQualifiedExpression(BasicExpressionTypingVisitor.java:725)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:391)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:60)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:543)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtVisitor.visitQualifiedExpression(KtVisitor.java:290)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:119)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:88)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:256)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
  at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:247)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:87)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.base/java.lang.reflect.Method.invoke(Method.java:566)
  at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
  at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
----
expression.kt
File name: program.kt Physical: true Injected: false
fun test(): Unit 
{
  <caret>`java.lang.Short.TYPE`.getConstructor(TODO())
}
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.logOrThrowException(ExpressionTypingVisitorDispatcher.java:261)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:225)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:543)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtVisitor.visitQualifiedExpression(KtVisitor.java:290)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
  at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
  at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
  at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:119)
  at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:88)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:256)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
  at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:247)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:87)
  at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
  at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
  at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
  at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
  at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.base/java.lang.reflect.Method.invoke(Method.java:566)
  at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
  at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.IllegalArgumentException: fromIndex(0) > toIndex(-1)
  at java.base/java.util.AbstractList.subListRangeCheck(AbstractList.java:509)
  at java.base/java.util.ArrayList.subList(ArrayList.java:1138)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.quickResolveToPackage(QualifiedExpressionResolver.kt:708)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveToPackageOrClassPrefix(QualifiedExpressionResolver.kt:527)
  at org.jetbrains.kotlin.resolve.QualifiedExpressionResolver.resolveQualifierInExpressionAndUnroll(QualifiedExpressionResolver.kt:646)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.elementChain(CallExpressionResolver.kt:295)
  at org.jetbrains.kotlin.resolve.calls.CallExpressionResolver.getQualifiedExpressionTypeInfo(CallExpressionResolver.kt:440)
  at org.jetbrains.kotlin.types.expressions.BasicExpressionTypingVisitor.visitQualifiedExpression(BasicExpressionTypingVisitor.java:725)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:391)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitQualifiedExpression(ExpressionTypingVisitorDispatcher.java:60)
  at org.jetbrains.kotlin.psi.KtVisitor.visitDotQualifiedExpression(KtVisitor.java:306)
  at org.jetbrains.kotlin.psi.KtDotQualifiedExpression.accept(KtDotQualifiedExpression.kt:32)
  at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
  ... 58 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    61,
    "18091",
    "Scala",
    "dotty",
    "AssertionError when loading class file",
    "https://github.com/lampepfl/dotty/issues/18091",
    "base",
    "None",
    "Open",
    "",
    "2023-06-28 16:41:24+00:00",
    "None",
    "crash",
    "None",
    "import io.restassured.internal.support.ParameterUpdater;
object Test {
  def test() = {
    val x: ParameterUpdater = null;
  }
}",
    "exception caught when loading class ParameterUpdater: java.lang.AssertionError: io.restassured.internal.support.ParameterUpdater$Serializer$1
java.lang.AssertionError: io.restassured.internal.support.ParameterUpdater$Serializer$1 while typechecking test.scala
exception occurred while typechecking test.scala
exception occurred while compiling test.scala
java.lang.AssertionError: io.restassured.internal.support.ParameterUpdater$Serializer$1 while compiling test.scala
Exception in thread ""main"" java.lang.AssertionError: io.restassured.internal.support.ParameterUpdater$Serializer$1
        at dotty.tools.dotc.core.classfile.ClassfileParser.$anonfun$12(ClassfileParser.scala:866)
        at scala.Option.getOrElse(Option.scala:201)
        at dotty.tools.dotc.core.classfile.ClassfileParser.enterOwnInnerClasses$$anonfun$1(ClassfileParser.scala:867)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.IterableOnceOps.foreach(IterableOnce.scala:575)
        at scala.collection.IterableOnceOps.foreach$(IterableOnce.scala:573)
        at dotty.tools.dotc.util.GenericHashMap$EntryIterator.foreach(GenericHashMap.scala:167)
        at dotty.tools.dotc.core.classfile.ClassfileParser.enterOwnInnerClasses(ClassfileParser.scala:868)
        at dotty.tools.dotc.core.classfile.ClassfileParser.parseClass(ClassfileParser.scala:195)
        at dotty.tools.dotc.core.classfile.ClassfileParser.$anonfun$1(ClassfileParser.scala:87)
        at dotty.tools.dotc.core.classfile.ClassfileParser.run(ClassfileParser.scala:82)
        at dotty.tools.dotc.core.ClassfileLoader.load(SymbolLoaders.scala:412)
        at dotty.tools.dotc.core.ClassfileLoader.doComplete(SymbolLoaders.scala:407)
        at dotty.tools.dotc.core.SymbolLoader.complete(SymbolLoaders.scala:341)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeFrom(SymDenotations.scala:174)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeOnce(SymDenotations.scala:382)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.isAbsent(SymDenotations.scala:612)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.isAccessibleFrom(SymDenotations.scala:922)
        at dotty.tools.dotc.core.Denotations$SingleDenotation.accessibleFrom(Denotations.scala:643)
        at dotty.tools.dotc.typer.Typer.selection$1(Typer.scala:248)
        at dotty.tools.dotc.typer.Typer.recur$1(Typer.scala:290)
        at dotty.tools.dotc.typer.Typer.namedImportRef$1(Typer.scala:297)
        at dotty.tools.dotc.typer.Typer.loop$1(Typer.scala:450)
        at dotty.tools.dotc.typer.Typer.findRefRecur$1(Typer.scala:472)
        at dotty.tools.dotc.typer.Typer.findRef(Typer.scala:475)
        at dotty.tools.dotc.typer.Typer.typedIdent(Typer.scala:534)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2896)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2990)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.typedType(Typer.scala:3177)
        at dotty.tools.dotc.typer.Namer.typedAheadType$$anonfun$1(Namer.scala:1616)
        at dotty.tools.dotc.typer.Namer.typedAhead(Namer.scala:1609)
        at dotty.tools.dotc.typer.Namer.typedAheadType(Namer.scala:1616)
        at dotty.tools.dotc.typer.Namer.valOrDefDefSig(Namer.scala:1704)
        at dotty.tools.dotc.typer.Namer$Completer.typeSig(Namer.scala:783)
        at dotty.tools.dotc.typer.Namer$Completer.completeInCreationContext(Namer.scala:922)
        at dotty.tools.dotc.typer.Namer$Completer.complete(Namer.scala:810)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeFrom(SymDenotations.scala:174)
        at dotty.tools.dotc.core.Denotations$Denotation.completeInfo$1(Denotations.scala:187)
        at dotty.tools.dotc.core.Denotations$Denotation.info(Denotations.scala:189)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.ensureCompleted(SymDenotations.scala:390)
        at dotty.tools.dotc.typer.Typer.retrieveSym(Typer.scala:2869)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2894)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2990)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3084)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3130)
        at dotty.tools.dotc.typer.Typer.typedBlockStats(Typer.scala:1096)
        at dotty.tools.dotc.typer.Typer.typedBlock(Typer.scala:1100)
        at dotty.tools.dotc.typer.Typer.typedUnnamed$1(Typer.scala:2936)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2991)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.typedExpr(Typer.scala:3174)
        at dotty.tools.dotc.typer.Namer.typedAheadExpr$$anonfun$1(Namer.scala:1619)
        at dotty.tools.dotc.typer.Namer.typedAhead(Namer.scala:1609)
        at dotty.tools.dotc.typer.Namer.typedAheadExpr(Namer.scala:1619)
        at dotty.tools.dotc.typer.Namer.typedAheadRhs$1$$anonfun$1(Namer.scala:1872)
        at dotty.tools.dotc.inlines.PrepareInlineable$.dropInlineIfError(PrepareInlineable.scala:249)
        at dotty.tools.dotc.typer.Namer.typedAheadRhs$1(Namer.scala:1872)
        at dotty.tools.dotc.typer.Namer.rhsType$1(Namer.scala:1880)
        at dotty.tools.dotc.typer.Namer.cookedRhsType$1(Namer.scala:1898)
        at dotty.tools.dotc.typer.Namer.lhsType$1(Namer.scala:1899)
        at dotty.tools.dotc.typer.Namer.inferredResultType(Namer.scala:1910)
        at dotty.tools.dotc.typer.Namer.inferredType$1(Namer.scala:1657)
        at dotty.tools.dotc.typer.Namer.valOrDefDefSig(Namer.scala:1664)
        at dotty.tools.dotc.typer.Namer.defDefSig(Namer.scala:1755)
        at dotty.tools.dotc.typer.Namer$Completer.typeSig(Namer.scala:787)
        at dotty.tools.dotc.typer.Namer$Completer.completeInCreationContext(Namer.scala:922)
        at dotty.tools.dotc.typer.Namer$Completer.complete(Namer.scala:810)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeFrom(SymDenotations.scala:174)
        at dotty.tools.dotc.core.Denotations$Denotation.completeInfo$1(Denotations.scala:187)
        at dotty.tools.dotc.core.Denotations$Denotation.info(Denotations.scala:189)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.ensureCompleted(SymDenotations.scala:390)
        at dotty.tools.dotc.typer.Typer.retrieveSym(Typer.scala:2869)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2894)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2990)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3084)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3130)
        at dotty.tools.dotc.typer.Typer.typedClassDef(Typer.scala:2562)
        at dotty.tools.dotc.typer.Typer.typedTypeOrClassDef$1(Typer.scala:2916)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2920)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2990)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3084)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3130)
        at dotty.tools.dotc.typer.Typer.typedPackageDef(Typer.scala:2692)
        at dotty.tools.dotc.typer.Typer.typedUnnamed$1(Typer.scala:2961)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2991)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3058)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3062)
        at dotty.tools.dotc.typer.Typer.typedExpr(Typer.scala:3174)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck$$anonfun$1(TyperPhase.scala:44)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck$$anonfun$adapted$1(TyperPhase.scala:54)
        at scala.Function0.apply$mcV$sp(Function0.scala:42)
        at dotty.tools.dotc.core.Phases$Phase.monitor(Phases.scala:437)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck(TyperPhase.scala:54)
        at dotty.tools.dotc.typer.TyperPhase.runOn$$anonfun$3(TyperPhase.scala:88)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.typer.TyperPhase.runOn(TyperPhase.scala:88)
        at dotty.tools.dotc.Run.runPhases$1$$anonfun$1(Run.scala:247)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.ArrayOps$.foreach$extension(ArrayOps.scala:1321)
        at dotty.tools.dotc.Run.runPhases$1(Run.scala:263)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$1(Run.scala:271)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$adapted$1(Run.scala:280)
        at dotty.tools.dotc.util.Stats$.maybeMonitored(Stats.scala:67)
        at dotty.tools.dotc.Run.compileUnits(Run.scala:280)
        at dotty.tools.dotc.Run.compileSources(Run.scala:195)
        at dotty.tools.dotc.Run.compile(Run.scala:179)
        at dotty.tools.dotc.Driver.doCompile(Driver.scala:35)
        at dotty.tools.dotc.Driver.process(Driver.scala:195)
        at dotty.tools.dotc.Driver.process(Driver.scala:163)
        at dotty.tools.dotc.Driver.process(Driver.scala:175)
        at dotty.tools.dotc.Driver.main(Driver.scala:205)
        at dotty.tools.MainGenericCompiler$.run$1(MainGenericCompiler.scala:162)
        at dotty.tools.MainGenericCompiler$.main(MainGenericCompiler.scala:186)
        at dotty.tools.MainGenericCompiler.main(MainGenericCompiler.scala)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    62,
    "17540",
    "Scala",
    "dotty",
    "Unexpected type mismatch when referencing an overloaded method",
    "https://github.com/lampepfl/dotty/issues/17540",
    "base",
    "None",
    "Closed",
    "Duplicate",
    "2023-05-19 14:13:15+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
object Test {
  def test(): Unit = {
    val x: Function1[? >: Int, Int] = Test.m
  }
  def m(x: Int) = 1
  def m(x: Int, y: Char) = false
}",
    "-- [E134] Type Error: program.scala:3:43 ------------------------------------------------------
3 |    val x: Function1[? >: Int, Int] = Test.m
  |                                      ^^^^^^
  |                None of the overloaded alternatives of method m in object Test with types
  |                 (x: Int, y: Char): Boolean
  |                 (x: Int): Int
  |                match expected type ? >: Int => Int
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    63,
    "17531",
    "Scala",
    "dotty",
    "AssertionError: failed to resolve inner class",
    "https://github.com/lampepfl/dotty/issues/17531",
    "ill-typed",
    "None",
    "Closed",
    "Not an Issue",
    "2023-05-17 15:42:06+00:00",
    "None",
    "crash",
    "None",
    "Scala
import org.apache.logging.log4j.core.message._
def test(): Unit = {
  val x: ExtendedThreadInfoFactory = ???
}",
    "        at scala.runtime.Scala3RunTime$.assertFailed(Scala3RunTime.scala:8)
        at dotty.tools.dotc.core.classfile.ClassfileParser$innerClasses$.classSymbol(ClassfileParser.scala:1125)
        at dotty.tools.dotc.core.classfile.ClassfileParser.classNameToSymbol(ClassfileParser.scala:116)
        at dotty.tools.dotc.core.classfile.ClassfileParser.getClassSymbol(ClassfileParser.scala:1178)
        at dotty.tools.dotc.core.classfile.ClassfileParser$ConstantPool.getClassSymbol(ClassfileParser.scala:1245)
        at dotty.tools.dotc.core.classfile.ClassfileParser$ConstantPool.getSuperClass(ClassfileParser.scala:1294)
        at dotty.tools.dotc.core.classfile.ClassfileParser.$anonfun$2(ClassfileParser.scala:182)
        at dotty.tools.dotc.core.classfile.ClassfileParser.$anonfun$adapted$1(ClassfileParser.scala:182)
        at scala.collection.immutable.List.map(List.scala:246)
        at dotty.tools.dotc.core.classfile.ClassfileParser.parseParents$1(ClassfileParser.scala:182)
        at dotty.tools.dotc.core.classfile.ClassfileParser.parseClass(ClassfileParser.scala:196)
        at dotty.tools.dotc.core.classfile.ClassfileParser.$anonfun$1(ClassfileParser.scala:87)
        at dotty.tools.dotc.core.classfile.ClassfileParser.run(ClassfileParser.scala:82)
        at dotty.tools.dotc.core.ClassfileLoader.load(SymbolLoaders.scala:411)
        at dotty.tools.dotc.core.ClassfileLoader.doComplete(SymbolLoaders.scala:406)
        at dotty.tools.dotc.core.SymbolLoader.complete(SymbolLoaders.scala:340)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeFrom(SymDenotations.scala:173)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeOnce(SymDenotations.scala:372)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.isAbsent(SymDenotations.scala:581)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.isAccessibleFrom(SymDenotations.scala:896)
        at dotty.tools.dotc.core.Denotations$SingleDenotation.accessibleFrom(Denotations.scala:643)
        at dotty.tools.dotc.typer.Typer.selection$1(Typer.scala:254)
        at dotty.tools.dotc.typer.Typer.wildImportRef$1(Typer.scala:309)
        at dotty.tools.dotc.typer.Typer.loop$1(Typer.scala:447)
        at dotty.tools.dotc.typer.Typer.findRefRecur$1(Typer.scala:465)
        at dotty.tools.dotc.typer.Typer.findRef(Typer.scala:468)
        at dotty.tools.dotc.typer.Typer.typedIdent(Typer.scala:525)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2863)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2957)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.typedType(Typer.scala:3148)
        at dotty.tools.dotc.typer.Namer.typedAheadType$$anonfun$1(Namer.scala:1616)
        at dotty.tools.dotc.typer.Namer.typedAhead(Namer.scala:1609)
        at dotty.tools.dotc.typer.Namer.typedAheadType(Namer.scala:1616)
        at dotty.tools.dotc.typer.Namer.valOrDefDefSig(Namer.scala:1703)
        at dotty.tools.dotc.typer.Namer$Completer.typeSig(Namer.scala:783)
        at dotty.tools.dotc.typer.Namer$Completer.completeInCreationContext(Namer.scala:922)
        at dotty.tools.dotc.typer.Namer$Completer.complete(Namer.scala:810)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.completeFrom(SymDenotations.scala:173)
        at dotty.tools.dotc.core.Denotations$Denotation.completeInfo$1(Denotations.scala:187)
        at dotty.tools.dotc.core.Denotations$Denotation.info(Denotations.scala:189)
        at dotty.tools.dotc.core.SymDenotations$SymDenotation.ensureCompleted(SymDenotations.scala:380)
        at dotty.tools.dotc.typer.Typer.retrieveSym(Typer.scala:2836)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2861)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2957)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3051)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3101)
        at dotty.tools.dotc.typer.Typer.typedBlockStats(Typer.scala:1063)
        at dotty.tools.dotc.typer.Typer.typedBlock(Typer.scala:1067)
        at dotty.tools.dotc.typer.Typer.typedUnnamed$1(Typer.scala:2903)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2958)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.typedExpr(Typer.scala:3145)
        at dotty.tools.dotc.typer.Typer.$anonfun$51(Typer.scala:2356)
        at dotty.tools.dotc.inlines.PrepareInlineable$.dropInlineIfError(PrepareInlineable.scala:249)
        at dotty.tools.dotc.typer.Typer.typedDefDef(Typer.scala:2356)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2871)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2957)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3051)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3101)
        at dotty.tools.dotc.typer.Typer.typedClassDef(Typer.scala:2532)
        at dotty.tools.dotc.typer.Typer.typedTypeOrClassDef$1(Typer.scala:2883)
        at dotty.tools.dotc.typer.Typer.typedNamed$1(Typer.scala:2887)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2957)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.traverse$1(Typer.scala:3051)
        at dotty.tools.dotc.typer.Typer.typedStats(Typer.scala:3101)
        at dotty.tools.dotc.typer.Typer.typedPackageDef(Typer.scala:2659)
        at dotty.tools.dotc.typer.Typer.typedUnnamed$1(Typer.scala:2928)
        at dotty.tools.dotc.typer.Typer.typedUnadapted(Typer.scala:2958)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3025)
        at dotty.tools.dotc.typer.Typer.typed(Typer.scala:3029)
        at dotty.tools.dotc.typer.Typer.typedExpr(Typer.scala:3145)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck$$anonfun$1(TyperPhase.scala:44)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck$$anonfun$adapted$1(TyperPhase.scala:54)
        at scala.Function0.apply$mcV$sp(Function0.scala:42)
        at dotty.tools.dotc.core.Phases$Phase.monitor(Phases.scala:429)
        at dotty.tools.dotc.typer.TyperPhase.typeCheck(TyperPhase.scala:54)
        at dotty.tools.dotc.typer.TyperPhase.runOn$$anonfun$3(TyperPhase.scala:88)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.typer.TyperPhase.runOn(TyperPhase.scala:88)
        at dotty.tools.dotc.Run.runPhases$1$$anonfun$1(Run.scala:238)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.ArrayOps$.foreach$extension(ArrayOps.scala:1321)
        at dotty.tools.dotc.Run.runPhases$1(Run.scala:249)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$1(Run.scala:257)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$adapted$1(Run.scala:266)
        at dotty.tools.dotc.util.Stats$.maybeMonitored(Stats.scala:68)
        at dotty.tools.dotc.Run.compileUnits(Run.scala:266)
        at dotty.tools.dotc.Run.compileSources(Run.scala:190)
        at dotty.tools.dotc.Run.compile(Run.scala:174)
        at dotty.tools.dotc.Driver.doCompile(Driver.scala:35)
        at dotty.tools.dotc.Driver.process(Driver.scala:195)
        at dotty.tools.dotc.Driver.process(Driver.scala:163)
        at dotty.tools.dotc.Driver.process(Driver.scala:175)
        at dotty.tools.dotc.Driver.main(Driver.scala:205)
        at dotty.tools.MainGenericCompiler$.run$1(MainGenericCompiler.scala:162)
        at dotty.tools.MainGenericCompiler$.main(MainGenericCompiler.scala:186)
        at dotty.tools.MainGenericCompiler.main(MainGenericCompiler.scala)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    64,
    "17391",
    "Scala",
    "dotty",
    "MatchError when calling a public method inherited from a default class",
    "https://github.com/lampepfl/dotty/issues/17391",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2023-05-02 08:51:07+00:00",
    "None",
    "crash",
    "None",
    "java
package mypkg;
class Base<E> {
    public void retainAll(String x) {}
}
public class Bar<E> extends Base<E> {}",
    "Scala
def test(): Unit =
{
  val x: Foo[mypkg.Bar[String]] = ???
  val y: mypkg.Bar[String] = ???
  y.retainAll(""fd"") // works
  x.f.retainAll(""fd""); // crashes
}
class Foo[T](val f: T)"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    65,
    "17412",
    "Scala",
    "dotty",
    "Unexpected overload ambiguity when using type parameter with upper bound",
    "https://github.com/lampepfl/dotty/issues/17412",
    "base",
    "None",
    "Open",
    "",
    "2023-05-04 11:04:17+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
object Foo {
  def test(): Unit = {
    val x: Map[String, String] = ???
    Foo.m[Map[String, String]](x)
  }
  // if we comment the following line, then it compiles
  def m[T](x: Array[T]) = true
  def m[T <: String](x: T) = true
  def m[T <: Map[?, ?]](x: T) = true
}",
    "-- [E051] Reference Error: test.scala:4:8 -------------------------------------
4 |    Foo.m[Map[String, String]](x)
  |    ^^^^^
  |Ambiguous overload. The overloaded alternatives of method m in object Foo with types
  | [T <: Map[?, ?]](x: T): Boolean
  | [T <: String](x: T): Boolean
  |both match type arguments [Map[String, String]] and arguments ((x : Map[String, String]))
  |
  | longer explanation available when compiling with `-explain`
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    66,
    "KT-59759",
    "Kotlin",
    "kotlinc",
    "Compilation performance regression when handling nested polymorphic types",
    "https://youtrack.jetbrains.com/issue/KT-59759",
    "base",
    "None",
    "Open",
    "",
    "2023-06-29 07:59:10.677000",
    "None",
    "Compilation Performance Issue",
    "None",
    "kt
import org.apache.commons.collections4.*;
import org.apache.commons.collections4.keyvalue.*;
import org.apache.commons.collections4.map.*;
import org.apache.commons.collections4.iterators.*;
import org.apache.commons.collections4.functors.*;
import org.apache.commons.collections4.set.*;
import org.apache.commons.collections4.collection.*;
import org.apache.commons.collections4.trie.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;
typealias A = EmptyIterator<String>
typealias B = AbstractCollectionDecorator<UnmodifiableBoundedCollection<A>>
typealias C = LazySortedMap<String, Stack<MultiSet<NullIsTruePredicate<ToDoubleFunction<B>>>>>
typealias D = EmptyIterator<SkippingIterator<ZippingIterator<IteratorEnumeration<C>>>>
typealias F = List<ExceptionPredicate<Iterator<Stream<D>>>>
fun test(): Unit 
{
  val res = (TODO() as AbstractKeyValue<Spliterators.AbstractSpliterator<FixedSizeMap<Spliterators.AbstractLongSpliterator, HashedMap<ZippingIterator<AbstractMap.SimpleEntry<String, Comparable<ToDoubleBiFunction<String, MapBackedSet<Iterator<CompositeCollection<Trie<Function0<List<F>>, String>>>, String>>>>>, String>>>, String>)
}",
    ""
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    67,
    "KT-59574",
    "Kotlin",
    "kotlinc",
    """AssertionError: Resolution error of this type shouldn't occur for resolve if as a call"" caused by reflective access of function",
    "https://youtrack.jetbrains.com/issue/KT-59574",
    "base",
    "None",
    "Open",
    "",
    "2023-06-22 06:41:01.892000",
    "None",
    "crash",
    "None",
    "kt
import com.google.common.collect.ImmutableSortedMap
 //     implementation(""com.google.guava:guava:32.0.1-jre"")
@Suppress(""UNREACHABLE_CODE"")
fun test(): Unit 
{
  val y: java.util.Comparator<Double> = TODO()
  val res: (Double, Double) -> Int = if (true)
      com.google.common.collect.ImmutableSortedMap.of(10.0, y).get(10.0)::compare // Type mismatch. Required: Comparator<Double> Found: Comparator<Double>?
    else TODO())
}",
    "ERROR: Resolution error of this type shouldn't occur for resolve if as a call
java.lang.Throwable: Resolution error of this type shouldn't occur for resolve if as a call
        at com.intellij.openapi.diagnostic.Logger.error(Logger.java:165)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:593)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:585)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.unsafeCall(ControlStructureTypingUtils.java:697)
        at org.jetbrains.kotlin.resolve.calls.DiagnosticReporterByTrackingStrategy.onCallReceiver(DiagnosticReporterByTrackingStrategy.kt:191)
        at org.jetbrains.kotlin.resolve.calls.model.UnsafeCallError.report(KotlinCallDiagnostics.kt:218)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportCallDiagnostic(KotlinToResolvedCallTransformer.kt:541)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportDiagnostics(KotlinToResolvedCallTransformer.kt:487)
        at org.jetbrains.kotlin.resolve.calls.tower.ResolvedAtomCompleter.completeResolvedCall(ResolvedAtomCompleter.kt:202)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.transformAndReport(KotlinToResolvedCallTransformer.kt:141)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.convertToOverloadResolutionResults(PSICallResolver.kt:257)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.runResolutionAndInferenceForGivenCandidates(PSICallResolver.kt:173)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.doResolveCallOrGetCachedResults(CallResolver.java:608)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.lambda$resolveCallWithKnownCandidate$4(CallResolver.java:585)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.resolveCallWithKnownCandidate(CallResolver.java:575)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:167)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:124)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingVisitor.visitIfExpression(ControlStructureTypingVisitor.java:116)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitIfExpression(ExpressionTypingVisitorDispatcher.java:297)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitIfExpression(ExpressionTypingVisitorDispatcher.java:60)
        at org.jetbrains.kotlin.psi.KtIfExpression.accept(KtIfExpression.java:33)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
        at org.jetbrains.kotlin.resolve.LocalVariableResolver.process(LocalVariableResolver.kt:112)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:122)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtProperty.accept(KtProperty.java:58)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:130)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:99)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:257)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
        at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:248)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:88)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
ERROR: Exception while analyzing expression in (4,38) in /home/user/program.kt
Attachments:
causeThrowable
java.lang.AssertionError: Resolution error of this type shouldn't occur for resolve if as a call
        at com.intellij.openapi.diagnostic.DefaultLogger.error(DefaultLogger.java:57)
        at com.intellij.openapi.diagnostic.Logger.error(Logger.java:165)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:593)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:585)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.unsafeCall(ControlStructureTypingUtils.java:697)
        at org.jetbrains.kotlin.resolve.calls.DiagnosticReporterByTrackingStrategy.onCallReceiver(DiagnosticReporterByTrackingStrategy.kt:191)
        at org.jetbrains.kotlin.resolve.calls.model.UnsafeCallError.report(KotlinCallDiagnostics.kt:218)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportCallDiagnostic(KotlinToResolvedCallTransformer.kt:541)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportDiagnostics(KotlinToResolvedCallTransformer.kt:487)
        at org.jetbrains.kotlin.resolve.calls.tower.ResolvedAtomCompleter.completeResolvedCall(ResolvedAtomCompleter.kt:202)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.transformAndReport(KotlinToResolvedCallTransformer.kt:141)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.convertToOverloadResolutionResults(PSICallResolver.kt:257)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.runResolutionAndInferenceForGivenCandidates(PSICallResolver.kt:173)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.doResolveCallOrGetCachedResults(CallResolver.java:608)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.lambda$resolveCallWithKnownCandidate$4(CallResolver.java:585)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.resolveCallWithKnownCandidate(CallResolver.java:575)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:167)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:124)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingVisitor.visitIfExpression(ControlStructureTypingVisitor.java:116)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitIfExpression(ExpressionTypingVisitorDispatcher.java:297)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitIfExpression(ExpressionTypingVisitorDispatcher.java:60)
        at org.jetbrains.kotlin.psi.KtIfExpression.accept(KtIfExpression.java:33)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
        at org.jetbrains.kotlin.resolve.LocalVariableResolver.process(LocalVariableResolver.kt:112)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:122)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtProperty.accept(KtProperty.java:58)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:130)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:99)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:257)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
        at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:248)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:88)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.Throwable: Resolution error of this type shouldn't occur for resolve if as a call
        ... 80 more
----
expression.kt
File name: program.kt Physical: true Injected: false
fun test(): Unit
{
  val y: java.util.Comparator<Double> = TODO()
  val res: (Double, Double) -> Int = <caret>if (true)
      com.google.common.collect.ImmutableSortedMap.of(10.0, y).get(10.0)::compare
    else TODO())
}
org.jetbrains.kotlin.utils.KotlinExceptionWithAttachments: Exception while analyzing expression in (4,38) in /home/user/program.kt
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.logOrThrowException(ExpressionTypingVisitorDispatcher.java:253)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:225)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
        at org.jetbrains.kotlin.resolve.LocalVariableResolver.process(LocalVariableResolver.kt:112)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:122)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtProperty.accept(KtProperty.java:58)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:130)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:99)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:257)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
        at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:248)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:88)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.AssertionError: Resolution error of this type shouldn't occur for resolve if as a call
        at com.intellij.openapi.diagnostic.DefaultLogger.error(DefaultLogger.java:57)
        at com.intellij.openapi.diagnostic.Logger.error(Logger.java:165)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:593)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:585)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.unsafeCall(ControlStructureTypingUtils.java:697)
        at org.jetbrains.kotlin.resolve.calls.DiagnosticReporterByTrackingStrategy.onCallReceiver(DiagnosticReporterByTrackingStrategy.kt:191)
        at org.jetbrains.kotlin.resolve.calls.model.UnsafeCallError.report(KotlinCallDiagnostics.kt:218)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportCallDiagnostic(KotlinToResolvedCallTransformer.kt:541)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportDiagnostics(KotlinToResolvedCallTransformer.kt:487)
        at org.jetbrains.kotlin.resolve.calls.tower.ResolvedAtomCompleter.completeResolvedCall(ResolvedAtomCompleter.kt:202)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.transformAndReport(KotlinToResolvedCallTransformer.kt:141)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.convertToOverloadResolutionResults(PSICallResolver.kt:257)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.runResolutionAndInferenceForGivenCandidates(PSICallResolver.kt:173)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.doResolveCallOrGetCachedResults(CallResolver.java:608)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.lambda$resolveCallWithKnownCandidate$4(CallResolver.java:585)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.resolveCallWithKnownCandidate(CallResolver.java:575)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:167)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:124)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingVisitor.visitIfExpression(ControlStructureTypingVisitor.java:116)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitIfExpression(ExpressionTypingVisitorDispatcher.java:297)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitIfExpression(ExpressionTypingVisitorDispatcher.java:60)
        at org.jetbrains.kotlin.psi.KtIfExpression.accept(KtIfExpression.java:33)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        ... 57 more
Caused by: java.lang.Throwable: Resolution error of this type shouldn't occur for resolve if as a call
        ... 80 more
exception: org.jetbrains.kotlin.util.KotlinFrontEndException: Exception while analyzing expression in (4,38) in /home/user/program.kt
Attachments:
causeThrowable
java.lang.AssertionError: Resolution error of this type shouldn't occur for resolve if as a call
        at com.intellij.openapi.diagnostic.DefaultLogger.error(DefaultLogger.java:57)
        at com.intellij.openapi.diagnostic.Logger.error(Logger.java:165)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:593)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:585)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.unsafeCall(ControlStructureTypingUtils.java:697)
        at org.jetbrains.kotlin.resolve.calls.DiagnosticReporterByTrackingStrategy.onCallReceiver(DiagnosticReporterByTrackingStrategy.kt:191)
        at org.jetbrains.kotlin.resolve.calls.model.UnsafeCallError.report(KotlinCallDiagnostics.kt:218)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportCallDiagnostic(KotlinToResolvedCallTransformer.kt:541)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportDiagnostics(KotlinToResolvedCallTransformer.kt:487)
        at org.jetbrains.kotlin.resolve.calls.tower.ResolvedAtomCompleter.completeResolvedCall(ResolvedAtomCompleter.kt:202)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.transformAndReport(KotlinToResolvedCallTransformer.kt:141)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.convertToOverloadResolutionResults(PSICallResolver.kt:257)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.runResolutionAndInferenceForGivenCandidates(PSICallResolver.kt:173)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.doResolveCallOrGetCachedResults(CallResolver.java:608)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.lambda$resolveCallWithKnownCandidate$4(CallResolver.java:585)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.resolveCallWithKnownCandidate(CallResolver.java:575)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:167)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:124)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingVisitor.visitIfExpression(ControlStructureTypingVisitor.java:116)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitIfExpression(ExpressionTypingVisitorDispatcher.java:297)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitIfExpression(ExpressionTypingVisitorDispatcher.java:60)
        at org.jetbrains.kotlin.psi.KtIfExpression.accept(KtIfExpression.java:33)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
        at org.jetbrains.kotlin.resolve.LocalVariableResolver.process(LocalVariableResolver.kt:112)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:122)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtProperty.accept(KtProperty.java:58)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:130)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:99)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:257)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
        at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:248)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:88)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.Throwable: Resolution error of this type shouldn't occur for resolve if as a call
        ... 80 more
----
expression.kt
File name: program.kt Physical: true Injected: false
fun test(): Unit
{
  val y: java.util.Comparator<Double> = TODO()
  val res: (Double, Double) -> Int = <caret>if (true)
      com.google.common.collect.ImmutableSortedMap.of(10.0, y).get(10.0)::compare
    else TODO())
}
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.logOrThrowException(ExpressionTypingVisitorDispatcher.java:261)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:225)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:135)
        at org.jetbrains.kotlin.resolve.LocalVariableResolver.process(LocalVariableResolver.kt:112)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:122)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitProperty(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtProperty.accept(KtProperty.java:58)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getTypeOfLastExpressionInBlock(ExpressionTypingServices.java:451)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedTypeWithWritableScope(ExpressionTypingServices.java:328)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:207)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.getBlockReturnedType(ExpressionTypingServices.java:184)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:586)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorForStatements.visitBlockExpression(ExpressionTypingVisitorForStatements.java:73)
        at org.jetbrains.kotlin.psi.KtBlockExpression.accept(KtBlockExpression.java:79)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:165)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.getTypeInfo(ExpressionTypingVisitorDispatcher.java:148)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:179)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingServices.checkFunctionReturnType(ExpressionTypingServices.java:166)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:1049)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBody(BodyResolver.java:992)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveFunctionBodies(BodyResolver.java:977)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBehaviorDeclarationBodies(BodyResolver.java:129)
        at org.jetbrains.kotlin.resolve.BodyResolver.resolveBodies(BodyResolver.java:256)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations(LazyTopDownAnalyzer.kt:227)
        at org.jetbrains.kotlin.resolve.LazyTopDownAnalyzer.analyzeDeclarations$default(LazyTopDownAnalyzer.kt:58)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:130)
        at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:99)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:257)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:42)
        at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:115)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:248)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:88)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:168)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:100)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:46)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:180)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:178)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:251)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.AssertionError: Resolution error of this type shouldn't occur for resolve if as a call
        at com.intellij.openapi.diagnostic.DefaultLogger.error(DefaultLogger.java:57)
        at com.intellij.openapi.diagnostic.Logger.error(Logger.java:165)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:593)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.logError(ControlStructureTypingUtils.java:585)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils$ThrowingOnErrorTracingStrategy.unsafeCall(ControlStructureTypingUtils.java:697)
        at org.jetbrains.kotlin.resolve.calls.DiagnosticReporterByTrackingStrategy.onCallReceiver(DiagnosticReporterByTrackingStrategy.kt:191)
        at org.jetbrains.kotlin.resolve.calls.model.UnsafeCallError.report(KotlinCallDiagnostics.kt:218)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportCallDiagnostic(KotlinToResolvedCallTransformer.kt:541)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.reportDiagnostics(KotlinToResolvedCallTransformer.kt:487)
        at org.jetbrains.kotlin.resolve.calls.tower.ResolvedAtomCompleter.completeResolvedCall(ResolvedAtomCompleter.kt:202)
        at org.jetbrains.kotlin.resolve.calls.tower.KotlinToResolvedCallTransformer.transformAndReport(KotlinToResolvedCallTransformer.kt:141)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.convertToOverloadResolutionResults(PSICallResolver.kt:257)
        at org.jetbrains.kotlin.resolve.calls.tower.PSICallResolver.runResolutionAndInferenceForGivenCandidates(PSICallResolver.kt:173)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.doResolveCallOrGetCachedResults(CallResolver.java:608)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.lambda$resolveCallWithKnownCandidate$4(CallResolver.java:585)
        at org.jetbrains.kotlin.util.PerformanceCounter.time(PerformanceCounter.kt:90)
        at org.jetbrains.kotlin.resolve.calls.CallResolver.resolveCallWithKnownCandidate(CallResolver.java:575)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:167)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingUtils.resolveSpecialConstructionAsCall(ControlStructureTypingUtils.java:124)
        at org.jetbrains.kotlin.types.expressions.ControlStructureTypingVisitor.visitIfExpression(ControlStructureTypingVisitor.java:116)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.visitIfExpression(ExpressionTypingVisitorDispatcher.java:297)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher$ForBlock.visitIfExpression(ExpressionTypingVisitorDispatcher.java:60)
        at org.jetbrains.kotlin.psi.KtIfExpression.accept(KtIfExpression.java:33)
        at org.jetbrains.kotlin.types.expressions.ExpressionTypingVisitorDispatcher.lambda$getTypeInfo$0(ExpressionTypingVisitorDispatcher.java:176)
        ... 57 more
Caused by: java.lang.Throwable: Resolution error of this type shouldn't occur for resolve if as a call
        ... 80 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    68,
    "KT-58776",
    "Kotlin",
    "kotlinc",
    "Unexpected callable reference ambiguity when having a private overloading method",
    "https://youtrack.jetbrains.com/issue/KT-58776",
    "erasure",
    "None",
    "",
    "As Designed",
    "2023-05-18 14:51:09.809000",
    "2023-05-22 16:01:47.251000",
    "Unexpected Compile-Time Error",
    "4 days, 1:10:37.442000",
    "kt
//     implementation(""com.google.guava:guava:31.1-jre"")
fun test(): Unit
{
  val x: List<String> = TODO()
  val map: com.google.common.collect.HashBiMap<String, String> = TODO()
  val res = x.reduceRight(map::put)
}",
    "program.kt:5:32: error: callable reference resolution ambiguity:
public open fun put(key: String, value: String): String? defined in com.google.common.collect.HashBiMap
private open fun put(p0: String!, p1: String!, p2: Boolean): String? defined in com.google.common.collect.HashBiMap
  val res = x.reduceRight(map::put)
                               ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    69,
    "GROOVY-10754",
    "Groovy",
    "groovyc",
    "Incompatible generic argument types when using wildcards",
    "https://issues.apache.org/jira/browse/GROOVY-10754",
    "erasure",
    "None",
    "Resolved",
    "Fixed",
    "2022-09-08 07:38:37+00:00",
    "2023-04-28 14:38:50+00:00",
    "Unexpected Compile-Time Error",
    "232 days, 7:00:13",
    "class A<T> {}
class B extends A<Boolean> {}
class C<T extends A<Boolean>, U extends T> {
  C(T x, U v) {}
}
class Test {
  void test(B x, B y) {
    C<? extends B, ? extends B> z = new C<>(x, y);
  }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 12: [Static type checking] - Incompatible generic argument types. Cannot assign C<A<java.lang.Boolean>, B> to: C<? extends B, ? extends B>
 @ line 12, column 37.
       C<? extends B, ? extends B> z = new C<>(x, y);
                                       ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    70,
    "GROOVY-10720",
    "Groovy",
    "groovyc",
    "Resolving wrong overloaded method?",
    "https://issues.apache.org/jira/browse/GROOVY-10720",
    "erasure",
    "None",
    "Closed",
    "Fixed",
    "2022-08-08 07:44:18+00:00",
    "2022-08-08 16:08:58+00:00",
    "Unexpected Compile-Time Error",
    "8:24:40",
    "import java.util.Arrays;
class Test {
    void test() {
      Double[] x = null;
      var y = Arrays.stream(x).map(d -> ""fda"").findFirst();
    }
}",
    "org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
test.groovy: 7: [Static type checking] - Cannot return value of type java.lang.String for lambda expecting double
 @ line 7, column 41.
   y = Arrays.stream(x).map(d -> ""fda"").fin
                                 ^
1 error"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    71,
    "KT-57940",
    "Kotlin",
    "kotlinc",
    "Nullability checks are not ignored when ""-Xnullability-annotations=@javax.annotation:ignore"" is provided",
    "https://youtrack.jetbrains.com/issue/KT-57940",
    "base",
    "None",
    "Open",
    "",
    "2023-04-12 08:29:40.318000",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "kt
// implementation (""com.google.guava:guava:31.1-android"")
fun test(): Unit 
{
    val x: com.google.common.collect.ForwardingConcurrentMap<Char, Int> = TODO()
    val y: Int = x.replace('d', 1)
}",
    "program.kt:4:18: error: type mismatch: inferred type is Int? but Int was expected
    val y: Int = x.replace('d', 1)
                 ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    72,
    "KT-57596",
    "Kotlin",
    "kotlinc",
    "Type mismatch when resolving wrong overloaded function",
    "https://youtrack.jetbrains.com/issue/KT-57596",
    "erasure",
    "None",
    "Open",
    "",
    "2023-03-27 12:25:20.328000",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "kt
fun test() {
    val tmp: Iterable<HashSet<Number>> = TODO()
    val p: HashSet<Number> = TODO()
    val x: List<HashSet<Number>> = tmp - p
}",
    "program.kt:4:36: error: type mismatch: inferred type is Number but kotlin.collections.HashSet<Number> /* = java.util.HashSet<Number> */ was expected
    val x: List<HashSet<Number>> = tmp - p
                                   ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    73,
    "KT-57512",
    "Kotlin",
    "kotlinc",
    """NoSuchElementException"" with Array extension function with cast",
    "https://youtrack.jetbrains.com/issue/KT-57512",
    "base",
    "None",
    "Open",
    "",
    "2023-03-22 15:28:26.478000",
    "None",
    "crash",
    "None",
    "kt
import java.util.function.*;
fun test(p: LongToDoubleFunction): Unit 
{
    arrayOf(p).reduceRightIndexed(fun (x, y, z): LongToDoubleFunction {
        val local: Function1<kotlin.UInt, LongToDoubleFunction> = (
            TODO() as Grouping<UInt, LongToDoubleFunction>)::keyOf
        return p
  })
}",
    "The root cause java.lang.RuntimeException was thrown at: org.jetbrains.kotlin.backend.jvm.codegen.FunctionCodegen.generate(FunctionCodegen.kt:49)
        at org.jetbrains.kotlin.backend.common.CodegenUtil.reportBackendException(CodegenUtil.kt:241)
        at org.jetbrains.kotlin.backend.common.CodegenUtil.reportBackendException$default(CodegenUtil.kt:236)
        at org.jetbrains.kotlin.backend.common.phaser.PerformByIrFilePhase.invokeSequential(performByIrFile.kt:68)
        at org.jetbrains.kotlin.backend.common.phaser.PerformByIrFilePhase.invoke(performByIrFile.kt:55)
        at org.jetbrains.kotlin.backend.common.phaser.PerformByIrFilePhase.invoke(performByIrFile.kt:41)
        at org.jetbrains.kotlin.backend.common.phaser.NamedCompilerPhase.invoke(CompilerPhase.kt:96)
        at org.jetbrains.kotlin.backend.common.phaser.CompositePhase.invoke(PhaseBuilders.kt:29)
        at org.jetbrains.kotlin.backend.common.phaser.NamedCompilerPhase.invoke(CompilerPhase.kt:96)
        at org.jetbrains.kotlin.backend.common.phaser.CompilerPhaseKt.invokeToplevel(CompilerPhase.kt:43)
        at org.jetbrains.kotlin.backend.jvm.JvmIrCodegenFactory.invokeCodegen(JvmIrCodegenFactory.kt:312)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.runCodegen(KotlinToJVMBytecodeCompiler.kt:348)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli(KotlinToJVMBytecodeCompiler.kt:123)
        at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileModules$cli$default(KotlinToJVMBytecodeCompiler.kt:47)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:167)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:53)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:101)
        at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.kt:47)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:101)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:79)
        at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:43)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:179)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit$default(CLITool.kt:177)
        at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:166)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:250)
        at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:87)
        at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:44)
Caused by: java.lang.RuntimeException: Exception while generating code for:
FUN name:test visibility:public modality:FINAL <> (p:java.util.function.LongToDoubleFunction) returnType:kotlin.Unit
  VALUE_PARAMETER name:p index:0 type:java.util.function.LongToDoubleFunction
  BLOCK_BODY
    COMPOSITE type=kotlin.Unit origin=null
      CALL 'public final fun reduceRightIndexed <S, T> (operation: kotlin.Function3<@[ParameterName(name = 'index')] kotlin.Int, T of kotlin.collections.ArraysKt.reduceRightIndexed, @[ParameterName(name = 'acc')] S of kotlin.collections.ArraysKt.reduceRightIndexed, S of kotlin.collections.ArraysKt.reduceRightIndexed>): S of kotlin.collections.ArraysKt.reduceRightIndexed [inline] declared in kotlin.collections.ArraysKt' type=java.util.function.LongToDoubleFunction origin=null
        <S>: java.util.function.LongToDoubleFunction
        <T>: java.util.function.LongToDoubleFunction
        $receiver: BLOCK type=kotlin.Array<out java.util.function.LongToDoubleFunction> origin=null
          VAR IR_TEMPORARY_VARIABLE name:tmp0 type:kotlin.Array<out java.util.function.LongToDoubleFunction> [val]
            CALL 'public final fun arrayOfNulls <T> (size: kotlin.Int): kotlin.Array<T of kotlin.arrayOfNulls?> declared in kotlin' type=kotlin.Array<out java.util.function.LongToDoubleFunction> origin=null
              <T>: java.util.function.LongToDoubleFunction
              size: CONST Int type=kotlin.Int value=1
          CALL 'public final fun set (index: kotlin.Int, value: T of kotlin.Array): kotlin.Unit [operator] declared in kotlin.Array' type=kotlin.Unit origin=null
            $this: GET_VAR 'val tmp0: kotlin.Array<out java.util.function.LongToDoubleFunction> [val] declared in <root>.ProgramKt.test' type=kotlin.Array<out java.util.function.LongToDoubleFunction> origin=null
            index: CONST Int type=kotlin.Int value=0
            value: GET_VAR 'p: java.util.function.LongToDoubleFunction declared in <root>.ProgramKt.test' type=java.util.function.LongToDoubleFunction origin=null
          GET_VAR 'val tmp0: kotlin.Array<out java.util.function.LongToDoubleFunction> [val] declared in <root>.ProgramKt.test' type=kotlin.Array<out java.util.function.LongToDoubleFunction> origin=null
        operation: BLOCK type=kotlin.Function3<@[ParameterName(name = 'index')] kotlin.Int, java.util.function.LongToDoubleFunction, @[ParameterName(name = 'acc')] java.util.function.LongToDoubleFunction, java.util.function.LongToDoubleFunction> origin=ANONYMOUS_FUNCTION
          COMPOSITE type=kotlin.Unit origin=null
          FUNCTION_REFERENCE 'private final fun test$lambda$0 ($p: java.util.function.LongToDoubleFunction, x: kotlin.Int, y: java.util.function.LongToDoubleFunction, z: java.util.function.LongToDoubleFunction): java.util.function.LongToDoubleFunction declared in <root>.ProgramKt' type=kotlin.Function3<@[ParameterName(name = 'index')] kotlin.Int, java.util.function.LongToDoubleFunction, @[ParameterName(name = 'acc')] java.util.function.LongToDoubleFunction, java.util.function.LongToDoubleFunction> origin=INLINE_LAMBDA reflectionTarget=null
            $p: GET_VAR 'p: java.util.function.LongToDoubleFunction declared in <root>.ProgramKt.test' type=java.util.function.LongToDoubleFunction origin=null
      COMPOSITE type=kotlin.Unit origin=null
        at org.jetbrains.kotlin.backend.jvm.codegen.FunctionCodegen.generate(FunctionCodegen.kt:49)
        at org.jetbrains.kotlin.backend.jvm.codegen.FunctionCodegen.generate$default(FunctionCodegen.kt:41)
        at org.jetbrains.kotlin.backend.jvm.codegen.ClassCodegen.generateMethodNode(ClassCodegen.kt:411)
        at org.jetbrains.kotlin.backend.jvm.codegen.ClassCodegen.generateMethod(ClassCodegen.kt:428)
        at org.jetbrains.kotlin.backend.jvm.codegen.ClassCodegen.generate(ClassCodegen.kt:171)
        at org.jetbrains.kotlin.backend.jvm.FileCodegen.lower(JvmPhases.kt:44)
        at org.jetbrains.kotlin.backend.common.phaser.FileLoweringPhaseAdapter.invoke(PhaseBuilders.kt:120)
        at org.jetbrains.kotlin.backend.common.phaser.FileLoweringPhaseAdapter.invoke(PhaseBuilders.kt:116)
        at org.jetbrains.kotlin.backend.common.phaser.NamedCompilerPhase.invoke(CompilerPhase.kt:96)
        at org.jetbrains.kotlin.backend.common.phaser.PerformByIrFilePhase.invokeSequential(performByIrFile.kt:65)
        ... 28 more
Caused by: org.jetbrains.kotlin.codegen.CompilationException: Back-end (JVM) Internal error: Couldn't inline method call: CALL 'public final fun reduceRightIndexed <S, T> (operation: kotlin.Function3<@[ParameterName(name = 'index')] kotlin.Int, T of kotlin.collections.ArraysKt.reduceRightIndexed, @[ParameterName(name = 'acc')] S of kotlin.collections.ArraysKt.reduceRightIndexed, S of kotlin.collections.ArraysKt.reduceRightIndexed>): S of kotlin.collections.ArraysKt.reduceRightIndexed [inline] declared in kotlin.collections.ArraysKt' type=java.util.function.LongToDoubleFunction origin=null
Method: reduceRightIndexed ([Ljava/lang/Object;Lkotlin/jvm/functions/Function3;)Ljava/lang/Object;:
    // annotable parameter count: 2 (invisible)
    @Lorg/jetbrains/annotations/NotNull;() // invisible, parameter 0
    @Lorg/jetbrains/annotations/NotNull;() // invisible, parameter 1
   L0
    ALOAD 0
    LDC ""<this>""
    INVOKESTATIC kotlin/jvm/internal/Intrinsics.checkNotNullParameter (Ljava/lang/Object;Ljava/lang/String;)V
    ALOAD 1
    LDC ""operation""
    INVOKESTATIC kotlin/jvm/internal/Intrinsics.checkNotNullParameter (Ljava/lang/Object;Ljava/lang/String;)V
    ICONST_0
    ISTORE 2
   L1
    LINENUMBER 20272 L1
    ALOAD 0
    INVOKESTATIC kotlin/collections/ArraysKt.getLastIndex ([Ljava/lang/Object;)I
    ISTORE 3
   L2
    LINENUMBER 20273 L2
    ILOAD 3
    IFGE L3
    NEW java/lang/UnsupportedOperationException
    DUP
    LDC ""Empty array can't be reduced.""
    INVOKESPECIAL java/lang/UnsupportedOperationException.<init> (Ljava/lang/String;)V
    ATHROW
   L3
    LINENUMBER 20274 L3
    ALOAD 0
    ILOAD 3
    IINC 3 -1
    AALOAD
    ASTORE 4
   L4
    LINENUMBER 20275 L4
    ILOAD 3
    IFLT L5
   L6
    LINENUMBER 20276 L6
    ALOAD 1
    ILOAD 3
    INVOKESTATIC java/lang/Integer.valueOf (I)Ljava/lang/Integer;
    ALOAD 0
    ILOAD 3
    AALOAD
    ALOAD 4
    INVOKEINTERFACE kotlin/jvm/functions/Function3.invoke (Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; (itf)
    ASTORE 4
    IINC 3 -1
   L7
    LINENUMBER 20277 L7
    GOTO L4
   L5
    LINENUMBER 20279 L5
    ALOAD 4
    ARETURN
   L8
    LOCALVARIABLE $i$f$reduceRightIndexed I L1 L8 2
    LOCALVARIABLE index I L2 L8 3
    LOCALVARIABLE accumulator Ljava/lang/Object; L4 L8 4
    LOCALVARIABLE $this$reduceRightIndexed [Ljava/lang/Object; L0 L8 0
    LOCALVARIABLE operation Lkotlin/jvm/functions/Function3; L0 L8 1
    MAXSTACK = 4
    MAXLOCALS = 5
File is unknown
The root cause java.util.NoSuchElementException was thrown at: java.base/java.util.ArrayList$Itr.next(ArrayList.java:1000)
        at org.jetbrains.kotlin.codegen.inline.InlineCodegen.performInline(InlineCodegen.kt:63)
        at org.jetbrains.kotlin.backend.jvm.codegen.IrInlineCodegen.genInlineCall(IrInlineCodegen.kt:163)
        at org.jetbrains.kotlin.backend.jvm.codegen.IrInlineCallGenerator.genCall(IrInlineCallGenerator.kt:31)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitCall(ExpressionCodegen.kt:522)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitCall(ExpressionCodegen.kt:135)
        at org.jetbrains.kotlin.ir.expressions.IrCall.accept(IrCall.kt:25)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitStatementContainer(ExpressionCodegen.kt:457)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitContainerExpression(ExpressionCodegen.kt:470)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitContainerExpression(ExpressionCodegen.kt:135)
        at org.jetbrains.kotlin.ir.visitors.IrElementVisitor$DefaultImpls.visitComposite(IrElementVisitor.kt:196)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitComposite(ExpressionCodegen.kt:135)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitComposite(ExpressionCodegen.kt:135)
        at org.jetbrains.kotlin.ir.expressions.IrComposite.accept(IrComposite.kt:22)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitStatementContainer(ExpressionCodegen.kt:457)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitBlockBody(ExpressionCodegen.kt:461)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.visitBlockBody(ExpressionCodegen.kt:135)
        at org.jetbrains.kotlin.ir.expressions.IrBlockBody.accept(IrBlockBody.kt:24)
        at org.jetbrains.kotlin.backend.jvm.codegen.ExpressionCodegen.generate(ExpressionCodegen.kt:241)
        at org.jetbrains.kotlin.backend.jvm.codegen.FunctionCodegen.doGenerate(FunctionCodegen.kt:120)
        at org.jetbrains.kotlin.backend.jvm.codegen.FunctionCodegen.generate(FunctionCodegen.kt:45)
        ... 37 more
Caused by: java.util.NoSuchElementException
        at java.base/java.util.ArrayList$Itr.next(ArrayList.java:1000)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.handleAnonymousObjectRegeneration(MethodInliner.kt:171)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.anew(MethodInliner.kt:219)
        at org.jetbrains.org.objectweb.asm.commons.InstructionAdapter.visitTypeInsn(InstructionAdapter.java:473)
        at org.jetbrains.org.objectweb.asm.tree.TypeInsnNode.accept(TypeInsnNode.java:77)
        at org.jetbrains.org.objectweb.asm.tree.InsnList.accept(InsnList.java:144)
        at org.jetbrains.org.objectweb.asm.tree.MethodNode.accept(MethodNode.java:751)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:386)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:99)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.access$doInline(MethodInliner.kt:42)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.visitMethodInsn(MethodInliner.kt:308)
        at org.jetbrains.org.objectweb.asm.tree.MethodInsnNode.accept(MethodInsnNode.java:115)
        at org.jetbrains.org.objectweb.asm.tree.InsnList.accept(InsnList.java:144)
        at org.jetbrains.org.objectweb.asm.tree.MethodNode.accept(MethodNode.java:751)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:386)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:99)
        at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:73)
        at org.jetbrains.kotlin.codegen.inline.InlineCodegen.inlineCall(InlineCodegen.kt:118)
        at org.jetbrains.kotlin.codegen.inline.InlineCodegen.performInline(InlineCodegen.kt:50)
        ... 56 more"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    74,
    "KT-57518",
    "Kotlin",
    "kotlinc",
    "False positive CALLABLE_REFERENCE_RESOLUTION_AMBIGUITY for method reference",
    "https://youtrack.jetbrains.com/issue/KT-57518",
    "base",
    "None",
    "Open",
    "",
    "2023-03-22 20:00:56.377000",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "kt
fun test() {
    val y: MutableList<IntIterator> = TODO()
    val d: Function1<Iterator<Int>, Boolean> = TODO()
    m<IntIterator>(if (true) d else y::add) // fails
    val z: Function1<IntIterator, Boolean> = if (true) d else y::add // works
}
fun <T> m(x: (T) -> Boolean) {}",
    "test.kt:5:40: error: callable reference resolution ambiguity:
public abstract fun add(index: Int, element: IntIterator): Unit defined in kotlin.collections.MutableList
public abstract fun add(element: IntIterator): Boolean defined in kotlin.collections.MutableList
    m<IntIterator>(if (true) d else y::add) // fails
                                       ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    75,
    "KT-57226",
    "Kotlin",
    "kotlinc",
    "Condition adds covariance to inferred type argument and leads to type mismatch error",
    "https://youtrack.jetbrains.com/issue/KT-57226",
    "erasure",
    "None",
    "Open",
    "",
    "2023-03-09 14:53:51.412000",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "kt
import java.util.function.*;
import java.util.stream.*;
fun test(x: ToIntFunction<String>, y: ToIntFunction<Any>): Unit 
{
    val z: Collector<String, *, Double?> = Collectors.averagingInt(
        if (false) x else y)
}",
    "test.kt:6:55: error: type mismatch: inferred type is String! but CapturedType(out Any)! was expected
    val z: Collector<String, *, Double?> = Collectors.averagingInt(
                                                      ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    76,
    "KT-54990",
    "Kotlin",
    "kotlinc",
    "NI: Type mismatch when encountering bounded type parameter and projections",
    "https://youtrack.jetbrains.com/issue/KT-54990",
    "base",
    "None",
    "Closed",
    "Fixed",
    "2022-11-16 10:56:43.903000",
    "2023-02-10 10:39:16.104000",
    "Unexpected Compile-Time Error",
    "85 days, 23:42:32.201000",
    "kt
class A<T1, T2: B<T1, Double>>
class B<T1, T2>
class C<L>(val x: A<out L, out B<L, Double>>)
fun test() {
    val x: A<out Any, out B<Any, Double>> = A()
    C<Any>(x)
}",
    "test.kt:9:12: error: type mismatch: inferred type is Any but CapturedType(out Any) was expected
    C<Any>(x)
           ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    77,
    "KT-52307",
    "Kotlin",
    "kotlinc",
    "TYPE_MISMATCH when using a SAM type with star projection",
    "https://youtrack.jetbrains.com/issue/KT-52307",
    "base",
    "None",
    "Open",
    "",
    "2022-05-06 13:32:03.068000",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "kt
import java.util.function.Function;
class A(val x: Function<*, String>)
fun main() {
    A({ x: String -> x })
}",
    "test.kt:6:7: error: type mismatch: inferred type is (String) -> String but (Any!) -> String was expected
    A({ x: String -> x })
      ^
test.kt:6:9: error: expected parameter of type Any!
    A({ x: String -> x })
        ^"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    78,
    "17360",
    "Scala",
    "dotty",
    "Fail to assign int constant to Short in the presence of overloaded methods",
    "https://github.com/lampepfl/dotty/issues/17360",
    "base",
    "None",
    "Open",
    "",
    "2023-04-27 10:54:45+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
object Foo {
  def test(): Unit = {
    Foo.m[Short](10)
  }
  def m[T](x: T) = true
  def m[T](x: T*) = true
}",
    "-- [E134] Type Error: program.scala:3:8 --------------------------------------------------------
3 |    Foo.m[Short](10)
  |    ^^^^^
  |    None of the overloaded alternatives of method m in object Foo with types
  |     [T](x: T*): Boolean
  |     [T](x: T): Boolean
  |    match type arguments [Short] and arguments ((10 : Int))
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    79,
    "17348",
    "Scala",
    "dotty",
    "Conversion of function type to SAM results in unexpected type mismatch",
    "https://github.com/lampepfl/dotty/issues/17348",
    "erasure",
    "None",
    "Open",
    "",
    "2023-04-25 19:31:48+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
def m[U](p: java.util.function.IntFunction[? <: U]): Unit = {}
def test(): Unit = {
  val y = ""d""
  m((p) => y.asInstanceOf[Any])
}",
    "-- [E007] Type Mismatch Error: program.scala:5:4 ----------------------------------------------
5 |  m((p) => y.asInstanceOf[Any])
  |    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  |    Found:    Int => Any
  |    Required: java.util.function.IntFunction[?]
  |
  | longer explanation available when compiling with `-explain`
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    80,
    "17311",
    "Scala",
    "dotty",
    "The inferred type is not precise when omitting type argument in the receiver expression",
    "https://github.com/lampepfl/dotty/issues/17311",
    "erasure",
    "None",
    "Open",
    "",
    "2023-04-19 12:12:47+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
import java.util.Comparator
class Foo[E](x: java.util.Comparator[? >: E]) {
  def first(): E = ???
}
class Bar {
  def m(): String = """"
}
def test(): Unit =
{
  val x: java.util.Comparator[Bar] = ???
  val y = new Foo(x)
  val z = y.first()
  z.m() // succeeds
  val k = new Foo(x).first()
  k.m() // fails
}",
    "-- [E007] Type Mismatch Error: program.scala:20:2 ----------------------------------------------
20 |  k.m() // fails
   |  ^
   |Found:    (k : Nothing)
   |Required: ?{ m: ? }
   |Note that implicit conversions were not tried because the result of an implicit conversion
   |must be more specific than ?{ m: [applied to () returning Unit] }
   |
   | longer explanation available when compiling with `-explain`
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    81,
    "17310",
    "Scala",
    "dotty",
    "Unexpected overload ambiguity when referencing an overloaded method",
    "https://github.com/lampepfl/dotty/issues/17310",
    "base",
    "None",
    "Open",
    "",
    "2023-04-19 11:22:25+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
class Foo[T] {
  def m(x: T): Boolean = true
  def m(x: T, y: Int): Boolean = false
}
def test(): Unit = {
  val x: Foo[Float] = new Foo[Float]()
  val y: Function1[? >: Float, Boolean] = x.m _
}",
    "-- [E099] Syntax Error: program.scala:9:46 -----------------------------------------------------
9 |  val y: Function1[? >: Float, Boolean] = x.m _
  |                                          ^^^^^
  |Only function types can be followed by _ but the current expression has type
  |  <error Ambiguous overload. The overloaded alternatives of method m in class Foo with types
  | (x: Float, y: Int): Boolean
  | (x: Float): Boolean
  |both match expected type <?>>
  |
  | longer explanation available when compiling with `-explain`
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    82,
    "17207",
    "Scala",
    "dotty",
    "Unexpected error when boxing LongStream and using reduce",
    "https://github.com/lampepfl/dotty/issues/17207",
    "erasure",
    "None",
    "Open",
    "",
    "2023-04-04 15:55:53+00:00",
    "None",
    "Unexpected Compile-Time Error",
    "None",
    "Scala
import java.util.stream._;
import java.util.function._;
def test(): Unit = {
  val x: BinaryOperator[Long] = ???
  val y: LongFunction[Long] = ???
  val rec: LongStream = ???
  rec.mapToObj(y).reduce(43, x) // fails
  val z = rec.mapToObj(y) 
  z.reduce(43, x) // succeeds
}",
    "-- [E050] Type Error: program.scala:9:18 ---------------------------------------------------------------
9 |  rec.mapToObj(y).reduce(43, x)
  |  ^^^^^^^^^^^^^^^^^^^^^^
  |  method reduce in trait Stream does not take parameters
  |
  | longer explanation available when compiling with `-explain`
1 error found"
);

INSERT INTO "CompilerBug" (
    "bid", "bug_id", "language", "compiler", "title",
    "issue_tracker_link", "mode", "fix_link", "status",
    "resolution", "report_date", "resolution_date", "symptom",
    "resolved_in", "test", "error_msg"
) VALUES (
    83,
    "15786",
    "Scala",
    "dotty",
    "error when pickling tree: assertion failed: method $anonfun",
    "https://github.com/lampepfl/dotty/issues/15786",
    "base",
    "None",
    "Open",
    "",
    "2022-07-29 14:21:18+00:00",
    "None",
    "crash",
    "None",
    "Scala
class A(val f: () => Int) {
  def mA(p: Int = 0): Int = p
}
trait B {
  def mB(p1: Int): Unit
}
class C[T](val f1: B, val f2: T)
val f = new A(() => {
  val x: B = null
  C[Int](x, 0).f1.mB(1);
  1
}).mA()",
    "exception occurred while compiling Main.scala
java.lang.AssertionError: assertion failed: method $anonfun while compiling Main.scala
Exception in thread ""main"" java.lang.AssertionError: assertion failed: method $anonfun
        at scala.runtime.Scala3RunTime$.assertFailed(Scala3RunTime.scala:8)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef(TreePickler.scala:324)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:559)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$9$$anonfun$1(TreePickler.scala:468)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$9(TreePickler.scala:468)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$adapted$8(TreePickler.scala:468)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:468)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$3$$anonfun$1(TreePickler.scala:427)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$3(TreePickler.scala:427)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$adapted$3(TreePickler.scala:428)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:428)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:409)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$3$$anonfun$1(TreePickler.scala:427)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$3(TreePickler.scala:427)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$adapted$3(TreePickler.scala:428)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:428)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTreeUnlessEmpty(TreePickler.scala:318)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef$$anonfun$1(TreePickler.scala:334)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef$$anonfun$adapted$1(TreePickler.scala:336)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef(TreePickler.scala:336)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:544)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleStats$$anonfun$2(TreePickler.scala:359)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleStats(TreePickler.scala:359)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$26(TreePickler.scala:585)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$adapted$24(TreePickler.scala:586)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:586)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef$$anonfun$1(TreePickler.scala:331)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef$$anonfun$adapted$1(TreePickler.scala:336)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleDef(TreePickler.scala:336)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:561)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleStats$$anonfun$2(TreePickler.scala:359)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleStats(TreePickler.scala:359)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$29(TreePickler.scala:601)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree$$anonfun$adapted$27(TreePickler.scala:601)
        at scala.Function0.apply$mcV$sp(Function0.scala:39)
        at dotty.tools.dotc.core.tasty.TreePickler.withLength(TreePickler.scala:55)
        at dotty.tools.dotc.core.tasty.TreePickler.pickleTree(TreePickler.scala:601)
        at dotty.tools.dotc.core.tasty.TreePickler.pickle$$anonfun$1(TreePickler.scala:772)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.core.tasty.TreePickler.pickle(TreePickler.scala:772)
        at dotty.tools.dotc.transform.Pickler.run$$anonfun$1$$anonfun$1(Pickler.scala:72)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.transform.Pickler.run$$anonfun$1(Pickler.scala:109)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.immutable.List.foreach(List.scala:333)
        at dotty.tools.dotc.transform.Pickler.run(Pickler.scala:109)
        at dotty.tools.dotc.core.Phases$Phase.runOn$$anonfun$1(Phases.scala:311)
        at scala.collection.immutable.List.map(List.scala:246)
        at dotty.tools.dotc.core.Phases$Phase.runOn(Phases.scala:312)
        at dotty.tools.dotc.transform.Pickler.runOn(Pickler.scala:114)
        at dotty.tools.dotc.Run.runPhases$1$$anonfun$1(Run.scala:225)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
        at scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
        at scala.collection.ArrayOps$.foreach$extension(ArrayOps.scala:1328)
        at dotty.tools.dotc.Run.runPhases$1(Run.scala:236)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$1(Run.scala:244)
        at dotty.tools.dotc.Run.compileUnits$$anonfun$adapted$1(Run.scala:253)
        at dotty.tools.dotc.util.Stats$.maybeMonitored(Stats.scala:68)
        at dotty.tools.dotc.Run.compileUnits(Run.scala:253)
        at dotty.tools.dotc.Run.compileSources(Run.scala:186)
        at dotty.tools.dotc.Run.compile(Run.scala:170)
        at dotty.tools.dotc.Driver.doCompile(Driver.scala:35)
        at dotty.tools.dotc.Driver.process(Driver.scala:195)
        at dotty.tools.dotc.Driver.process(Driver.scala:163)
        at dotty.tools.dotc.Driver.process(Driver.scala:175)
        at dotty.tools.dotc.Driver.main(Driver.scala:205)
        at dotty.tools.MainGenericCompiler$.run$1(MainGenericCompiler.scala:162)
        at dotty.tools.MainGenericCompiler$.main(MainGenericCompiler.scala:186)
        at dotty.tools.MainGenericCompiler.main(MainGenericCompiler.scala)"
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    1, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    2, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    3, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    4, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    5, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    6, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    7, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    8, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    9, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    10, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    11, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    12, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    13, 20, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    14, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    15, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    16, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    17, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    18, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    19, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    20, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    21, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    22, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    23, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    24, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    25, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    26, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    27, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    28, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    29, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    30, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    31, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    32, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    33, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    34, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    35, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    36, 8, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    37, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    38, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    39, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    40, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    41, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    42, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    43, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    44, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    45, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    46, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    47, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    48, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    49, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    50, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    51, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    52, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    53, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    54, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    55, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    56, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    57, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    58, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    59, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    60, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    61, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    62, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    63, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    64, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    65, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    66, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    67, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    68, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    69, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    70, 16, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    71, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    72, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    73, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    74, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    75, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    76, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    77, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    78, 8, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    79, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    80, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    81, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    82, 1, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    83, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    84, 5, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    85, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    86, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    87, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    88, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    89, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    90, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    91, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    92, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    93, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    94, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    95, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    96, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    97, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    98, 23, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    99, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    100, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    101, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    102, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    103, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    104, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    105, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    106, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    107, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    108, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    109, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    110, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    111, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    112, 16, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    113, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    114, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    115, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    116, 1, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    117, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    118, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    119, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    120, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    121, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    122, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    123, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    124, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    125, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    126, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    127, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    128, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    129, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    130, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    131, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    132, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    133, 4, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    134, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    135, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    136, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    137, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    138, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    139, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    140, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    141, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    142, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    143, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    144, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    145, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    146, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    147, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    148, 20, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    149, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    150, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    151, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    152, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    153, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    154, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    155, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    156, 1, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    157, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    158, 1, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    159, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    160, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    161, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    162, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    163, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    164, 16, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    165, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    166, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    167, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    168, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    169, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    170, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    171, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    172, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    173, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    174, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    175, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    176, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    177, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    178, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    179, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    180, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    181, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    182, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    183, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    184, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    185, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    186, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    187, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    188, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    189, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    190, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    191, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    192, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    193, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    194, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    195, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    196, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    197, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    198, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    199, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    200, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    201, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    202, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    203, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    204, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    205, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    206, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    207, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    208, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    209, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    210, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    211, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    212, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    213, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    214, 17, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    215, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    216, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    217, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    218, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    219, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    220, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    221, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    222, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    223, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    224, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    225, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    226, 0, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    227, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    228, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    229, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    230, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    231, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    232, 13, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    233, 12, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    234, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    235, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    236, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    237, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    238, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    239, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    240, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    241, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    242, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    243, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    244, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    245, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    246, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    247, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    248, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    249, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    250, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    251, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    252, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    253, 0, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    254, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    255, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    256, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    257, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    258, 0, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    259, 19, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    260, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    261, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    262, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    263, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    264, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    265, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    266, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    267, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    268, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    269, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    270, 17, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    271, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    272, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    273, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    274, 10, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    275, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    276, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    277, 19, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    278, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    279, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    280, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    281, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    282, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    283, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    284, 18, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    285, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    286, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    287, 5, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    288, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    289, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    290, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    291, 10, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    292, 24, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    293, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    294, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    295, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    296, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    297, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    298, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    299, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    300, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    301, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    302, 2, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    303, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    304, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    305, 17, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    306, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    307, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    308, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    309, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    310, 17, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    311, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    312, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    313, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    314, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    315, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    316, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    317, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    318, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    319, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    320, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    321, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    322, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    323, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    324, 1, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    325, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    326, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    327, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    328, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    329, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    330, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    331, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    332, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    333, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    334, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    335, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    336, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    337, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    338, 9, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    339, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    340, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    341, 15, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    342, 7, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    343, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    344, 22, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    345, 6, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    346, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    347, 3, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    348, 21, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    349, 5, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    350, 11, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    351, 14, 83
);

INSERT INTO "CompilerBugFeatures" (
    "bfid", "fid", "bid"
) VALUES (
    352, 3, 83
);
