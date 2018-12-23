---
title: Building Native Images of Kotlin Programs Using GraalVM
alias: native-kotlin-on-graalvm.md

author: Paul Vorbach
created-at: 2018-12-23

tags: [ english, jvm, graalvm, kotlin ]
locale: en-US

template: post-corristo.ftl

properties:
  highlight: "#02677d"
...

In April of this year, Oracle announced [GraalVM], a new virtual machine that claims to run applications written in a
diverse set of languages either in a runtime environment like OpenJDK or Node.js, but also as a standalone program.

[GraalVM]: https://www.graalvm.org/

The last part attracted my attention. This could be used to improve the startup time of Java applications. The startup
time of the JVM is often taken as a reason not to use it for writing command-line applications. Consequently Jan Stępień
showed only a few days after the announcement that you can
[use GraalVM to build native binaries of Clojure applications][native-clojure].

[native-clojure]: https://www.innoq.com/en/blog/native-clojure-and-graalvm/

Now I wanted to try how easy GraalVM is to use with Kotlin, which is slowly becoming my new go-to language for JVM-based
projects. Therefore I installed the latest version of GraalVM (1.0.0-rc-10), which was quite easy using [SDKman]:

[SDKman]: https://sdkman.io/

~~~
$ sdk install java 1.0.0-rc-10-grl
$ sdk use java 1.0.0-rc-10-grl
~~~

If you haven’t already done so, also install Kotlin:

~~~
$ sdk install kotlin 1.3.11
$ sdk use kotlin 1.3.11
~~~

Now I wrote the typical “hello world” in Kotlin (`main.kt`):

~~~ kotlin
fun main(vararg args: String) {
    println("Hello, world")
}
~~~

Then we need to compile it:

~~~
$ kotlinc main.kt -include-runtime -d main.jar
~~~

And finally we’re able to build a native binary from it:

~~~
$ native-image --static -jar main.jar
Build on Server(pid: 5484, port: 35163)
[main:5484]    classlist:     441.34 ms
[main:5484]        (cap):   1,017.18 ms
[main:5484]        setup:   1,581.26 ms
[main:5484]   (typeflow):   2,216.25 ms
[main:5484]    (objects):     516.04 ms
[main:5484]   (features):      86.21 ms
[main:5484]     analysis:   2,876.19 ms
[main:5484]     universe:     131.56 ms
[main:5484]      (parse):     610.96 ms
[main:5484]     (inline):     518.10 ms
[main:5484]    (compile):   2,818.48 ms
[main:5484]      compile:   4,187.55 ms
[main:5484]        image:     354.83 ms
[main:5484]        write:     164.75 ms
[main:5484]      [total]:   9,769.44 ms
~~~

This new native binary is about 3.4 MB in size, which is acceptable when you consider the alternative of having to
bundle an entire JVM with your application. Also, the files in the JAR alone contain 4.6 MB of data. The compressed JAR
file is only 1.2 MB in size.

So let’s run it:

~~~
$ ./main
Hello, world
~~~

That was smooth, wasn’t it?

And if we compare startup time using `time`, we see that only takes around three milliseconds of CPU time to run:

~~~
$ time ./main
Hello, world
./main  0.00s user 0.00s system 84% cpu 0.003 total
~~~

Compare that to running the JAR file using the JVM:

~~~
$ time java -jar main.jar
Hello, world
java -jar main.jar  0.07s user 0.01s system 107% cpu 0.079 total
~~~

## Conclusion

I’ve shown that it is quite easily possible to create a command-line application using Kotlin and building a native
binary from it using GraalVM. My next steps are to compile a project that does a little more than simply printing
“Hello, world” and also have a look into how to debug such a native library. Additionally, a comparison to Kotlin/Native
would make sense.

If you're interested in playing around on your own with Kotlin and GraalVM, you can have a look at
[this little project](https://github.com/pvorb/graalvm-kotlin-native-image-sample) I created on GitHub. It uses Maven to
automate the various steps involved.
