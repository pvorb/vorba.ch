---
title: How to Set Up Code Coverage for a Java Project using Gradle, Travis, JaCoCo and Codecov
alias: java-gradle-travis-jacoco-codecov.md

author: Paul Vorbach
created-at: 2015-07-23

tags: [ english, howto, testing, java, gradle, code-coverage ]
locale: en-US

template: post-diego.ftl
teaser:
  image-url: /2015/roof.jpg
...

The code coverage of a project's test suite can be a useful measure for finding
out about the quality of the project. There are several tools for Java that can
calculate the code coverage, for example [SonarQube] and [JaCoCo].

[SonarQube]: http://www.sonarqube.org/
[JaCoCo]: http://www.eclemma.org/jacoco/

During my recent work on [property-providers], I found out how to give users a
quick overview of the test coverage of the code using [Codecov]. It is not well
documented for projects that don't use Maven, so here I present the complete
setup that brings the code coverage badge to the GitHub page of the project.

[property-providers]: https://github.com/pvorb/property-providers
[Codecov]: https://codecov.io/

## Gradle

The project uses Gradle instead of Maven. Here's its `build.gradle`. It
configures JaCoCo reports. XML reports are disabled by default but those are
needed in order to work with Codecov, so enable them. Also the `check` task,
which is run by Travis, needs to depend on `jacocoTestReport`.

~~~ groovy
apply plugin: 'java'
apply plugin: 'jacoco'

version = '0.0.1'
sourceCompatibility = 1.8
targetCompatibility = 1.8

repositories {
    mavenCentral()
}

dependencies {
    // project dependencies
    // ...
}

jacocoTestReport {
    reports {
        xml.enabled = true
        html.enabled = true
    }
}

check.dependsOn jacocoTestReport
~~~


## Travis-CI

[Travis] is a hosted continuous integration service. You can sign up with a
GitHub account. It's free for open source projects.

This is what the Travis `.travis.yml` configuration file looks like. Whenever a
build succeeds, the last line uploads the JaCoCo report to Codecov.

[Travis]: https://travis-ci.org/

~~~ yaml
language: java
jdk:
  - oraclejdk8
after_success:
  - bash <(curl -s https://codecov.io/bash)
~~~

## Codecov

In order to use Codecov, you need to sign up first. It is straight forward for
Github users: just [sign up with GitHub](https://codecov.io/login/github) and
then add the repository that you wish to monitor. The service, like Travis, is
free for open source projects.

## Readme

Finally, I added this markdown snippet to my `README.md` file in order to show
the coverage badge. I used the badge from [shields.io] instead of Codecov's own
badge, because it gives better consistency with other badges.

~~~ markdown
[![Code Coverage](https://img.shields.io/codecov/c/github/pvorb/property-providers/develop.svg)](https://codecov.io/github/pvorb/property-providers?branch=develop)
~~~

[shields.io]: http://shields.io/

That's all! I hope this article may help you on your way to set up code coverage
monitoring for your Java project.
