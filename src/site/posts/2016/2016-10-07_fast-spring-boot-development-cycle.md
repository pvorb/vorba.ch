---
title: Fast Front End Development Cycle with Spring Boot
alias: fast-spring-boot-development-cycle.md

author: Paul Vorbach
created-at: 2016-10-07

tags: [ english, howto, java, spring-boot, maven ]
locale: en-US

template: post-diego.ftl
teaser:
  image-url: /2016/train.jpg
  author: Donnie Nunley
  url: https://www.flickr.com/photos/dbnunley/8431588976/
  license:
    name: CC BY 2.0
    url: https://creativecommons.org/licenses/by/2.0/
...

[Spring Boot][spring-boot] makes developing microservices a breeze. It's easy to get to speed without the need for much
configuration. However, it can be quite annoying to compile and restart the program every time you change a component.
To overcome this drawback, the Spring Boot documentation includes a how-to guide about configuring
[hot swapping][hot-swap] such as static web resources, templates and Java classes while the server keeps running. A big
part of the solution is to use [the developer tools][devtools], which provide some helpful settings that improve the
overall development experience.

When it comes to front end development, it can be quite annoying to have to manually hit "Make Project" every time a
file changes. Especially when running a separate build tool for front end components like Webpack even IntelliJ's
setting "Make project automatically" won't always update the generated resources on the server in time.

What I wanted to have instead was to be able to just refresh the browser and see the exact same static resources as in
the IDE. As it shows, this is possible with Spring Boot and Maven. The described method has been tested with
Spring Boot 1.3.8.RELEASE and IntelliJ IDEA 2016.2.4.

In my `pom.xml` file I have configured the `spring-boot-starter-parent` artifact as the parent of my project,
so I don't need to specify Spring Boot-managed dependency versions on my own. You may also want to explicitly specify
dependency and plugin versions instead.

While not required, it makes sense to add a dependency on `spring-boot-devtools`:

~~~ xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>
~~~

## Solution

Key to the solution is to keep static resources in `src/main/webapp` instead of `src/main/resources/static`. You may
already know this directory from typical WAR-packaged applications.
Then, you'll also need to configure `maven-resources-plugin` to copy files under `src/main/webapp` directly to
`target/classes/public` or `target/classes/static`:

~~~ xml
<build>
    <plugins>
        <!-- ... -->
        <plugin>
            <artifactId>maven-resources-plugin</artifactId>
            <version>3.0.1</version>
            <executions>
                <execution>
                    <id>copy-resources</id>
                    <phase>generate-resources</phase>
                    <goals>
                        <goal>copy-resources</goal>
                    </goals>
                    <configuration>
                        <outputDirectory>${basedir}/target/classes/public</outputDirectory>
                        <resources>
                            <resource>
                                <directory>src/main/webapp</directory>
                                <filtering>false</filtering>
                            </resource>
                        </resources>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
~~~

This way a running instance of Spring Boot can always serve the most recent version of a file. Hitting refresh in the
browser will show it immediately.

You can find the [complete POM file on GitHub][sample-pom].

*P.S.:* If you run a front end build tool like Webpack with `--watch`, changing a file will not always trigger a
rebuild of affected bundles, when you use IntelliJ for editing. This is caused by a feature called "safe write" which
you can turn off in the settings under "Appearance &amp; Behavior" &rarr; "System Settings".

[spring-boot]: https://projects.spring.io/spring-boot/
[hot-swap]: https://docs.spring.io/spring-boot/docs/1.3.8.RELEASE/reference/html/howto-hotswapping.html
[devtools]: https://docs.spring.io/spring-boot/docs/1.3.8.RELEASE/reference/html/using-boot-devtools.html
[sample-pom]: https://github.com/pvorb/platon/blob/913647edbaf69d309df75f1b871ff922a5b23aca/pom.xml
