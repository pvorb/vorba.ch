title: Living up to Your own Standards
created: 2017-12-23
template: post.corristo.en.tpl
highlight: "#6daaff"
tags: [ english, howto, testing, java, gradle, maven, code-coverage ]


My reader Rebeca asked me yesterday if I could post about how to let your test suite fail if it falls below a certain
threshold. So here's how you can do this using the JaCoCo plugins for Maven and Gradle.

## Maven

You can configure a rule in `jacoco-maven-plugin` as follows.

~~~ xml
<build>
    <plugin>
        <groupId>org.jacoco</groupId>
        <artifactId>jacoco-maven-plugin</artifactId>
        <version>0.7.9</version>
        <executions>
            <!-- ... -->
            <execution>
                <id>check</id>
                <phase>test</phase>
                <goals>
                    <goal>check</goal>
                </goals>
                <configuration>
                    <rules>
                        <rule implementation="org.jacoco.maven.RuleConfiguration">
                            <element>BUNDLE</element>
                            <limits>
                                <limit implementation="org.jacoco.report.check.Limit">
                                    <counter>INSTRUCTION</counter>
                                    <value>COVEREDRATIO</value>
                                    <minimum>0.80</minimum>
                                </limit>
                            </limits>
                        </rule>
                    </rules>
                </configuration>
            </execution>
        </executions>
    </plugin>
</build>
~~~

Now, if your test suite falls below 80% instruction coverage, the build will fail with the following message:

~~~
$ mvn verify
...
[ERROR] Failed to execute goal org.jacoco:jacoco-maven-plugin:0.7.9:check (check) on project platon: Coverage checks have not been met. See log for details. -> [Help 1]
~~~

There are many other possible rules for the check mojo
[documented in the official JaCoCo documentation](http://www.jacoco.org/jacoco/trunk/doc/check-mojo.html). 

## Gradle

Configuring these rules is even simpler for Gradle.

~~~ groovy
apply plugin: 'jacoco'

// ...

jacocoTestReport {
    reports {
        xml.enabled = true
        html.enabled = true
    }
}

jacocoTestCoverageVerification {
    violationRules {
        rule {
            limit {
                minimum = 0.9
            }
        }
    }
}

jacocoTestCoverageVerification.dependsOn(jacocoTestReport)
check.dependsOn(jacocoTestCoverageVerification)
~~~

Here's what you get when you run `gradle check` and test coverage is low.

~~~
$ gradle check
...
:jacocoTestReport
[ant:jacocoReport] Rule violated for bundle property-providers: instructions covered ratio is 0.7, but expected minimum is 0.8
:jacocoTestCoverageVerification FAILED
FAILURE: Build failed with an exception.
* What went wrong:
Execution failed for task ':jacocoTestCoverageVerification'.
> Rule violated for bundle property-providers: instructions covered ratio is 0.7, but expected minimum is 0.8
* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
* Get more help at https://help.gradle.org
BUILD FAILED in 14s
~~~

You can find more configuration examples in
[Gradle's JaCoCo plugin documentation](https://docs.gradle.org/current/userguide/jacoco_plugin.html#sec:jacoco_report_violation_rules).

I hope this guide will help one or the other trying to achieve something similar.
