---
title: Migration von Bread zu Sokrates
alias: bread-sokrates-migration.md

author: Paul Vorbach
created-at: 2018-08-19

tags: [ deutsch, self, bread, sokrates, cms, weblog ]
locale: de-DE

template: post-corristo.ftl
teaser:
  image-url: /2018/sokrates.jpg

properties:
  highlight: "#3D8536"
...

Selbstbezogene Blog-Posts schreiben sich immer am leichtesten. ;-)

Gestern habe ich meinen vorherigen, selbstgeschriebenen *Static-Site-Generator* Bread[^bread] durch [Sokrates] abgelöst.
Die Software funktioniert weitestgehend gleich, ist jedoch in Java geschrieben, was seit einiger Zeit eher meiner
täglichen Arbeit entspricht.
 
[^bread]: [Einführungsartikel zu Bread](/2012/bread.html) und
  [Repository auf GitHub](https://github.com/pvorb/node-bread).

[Sokrates]: https://github.com/pvorb/sokrates

Im Gegensatz zu Bread setzt Sokrates auf die SQL-Datenbank [H2] statt auf MongoDB. Das bringt den Vorteil mit sich, für
die Generierung der Site keinen Datenbank-Dienst laufen lassen zu müssen. Während der letzten Jahre musste ich MongoDB
immer wieder neu aufsetzen und Bread an die jeweils neueste MongoDB-Version anpassen, um Änderungen an diesem Blog
vornehmen zu können. Darauf hatte ich keine Lust mehr, da ich auch das Interesse an MongoDB im Allgemeinen verloren
habe.

[H2]: https://www.h2database.com

H2 hingegen ist eine in Java geschriebene relationale Datenbank, die ähnlich zu Sqlite In-Memory oder embedded
betrieben werden kann. Das bedeutet, der komplette Inhalt der Datenbank liegt entweder im Speicher oder in einer
einzigen Datei (embedded), die jederzeit wieder verworfen und neu generiert werden kann. Das und die Mächtigkeit von SQL
und die Kompatibilität zum ganzen Tooling rund um SQL waren der Grund für den Einsatz in Sokrates.

Da ich bei der täglichen Arbeit Spring Boot einsetze, baut Sokrates auf Spring Boot als Dependency-Injection-Framework
auf. Die Datenbank-Schemaverwaltung übernimmt [Flyway] und SQL-Queries sind mit [jOOQ] geschrieben. Als Template-Engine
kommt [Freemarker] zum Einsatz und das Übersetzen von Markdown in HTML übernimmt wieder [Pandoc].

[Flyway]: https://boxfuse.org/flyway
[jOOQ]: https://jooq.org
[Freemarker]: https://freemarker.apache.org
[Pandoc]: https://pandoc.org

## Features

### Einfache Konfiguration per YAML-Datei

Das hier ist die aktuelle Konfiguration dieses Blogs:

~~~ yaml
logging.level:
  root: WARN
  de.vorb.sokrates: INFO

spring.datasource:
  url: jdbc:h2:./sokrates
  driver-class-name: org.h2.Driver
  username: sa
  password:

sokrates:
  site:
    title: vorba.ch
    subtitle: Paul’s personal blog about software and technology
    default-locale: en-US
    public-url: https://vorba.ch
    author: Paul Vorbach
    author-url: https://paul.vorba.ch
    translations: src/site/resources/translations
    properties:
      hostname: vorba.ch
      feed:
        id: http://vorb.de/log/feed.xml
        categories:
          - computer
          - software
          - development
          - software engineering
          - java
          - kotlin
  directory:
    output: target/sokrates/
    templates: src/site/resources/templates/
  generator:
    pandoc-executable: /usr/bin/pandoc
    extension-mapping:
      md: html
    generate-rules:
      - pattern: src/site/resources/posts/**/*.md
        base-directory: src/site/resources/posts
        format: markdown
    copy-rules:
      - pattern: src/site/resources/posts/**/*
        base-directory: src/site/resources/posts
      - pattern: src/site/resources/tag/**/*
        base-directory: src/site/resources
      - pattern: src/site/resources/static/**/*
        base-directory: src/site/resources/static
    tag-rule:
      source-file-pattern: src/site/resources/tag/%s.md
      output-file-pattern: tag/%s.html
      format: markdown
      template: tag.ftl
      index-output-file: tags/index.html
      index-template: tag-index.ftl
  indexes:
    - name: Blog index
      title: Blog index
      template: index.ftl
      output-file: index.html
      order-by:
        - created_at DESC
      grouping: BY_YEAR_CREATED
    - name: Feed
      title: Atom feed
      template: feed.ftl
      output-file: feed.xml
      order-by:
        - created_at DESC
      limit: 10
~~~

Interessant sind in erster Linie die Properties unterhalb von `sokrates`. Unter `sokrates.site` finden sich Metadaten
zur Website. Unter `sokrates.generator` werden Regeln zum Übersetzen der Blog-Posts und Tags sowie zum Kopieren
statischer Dateien definiert. Unter `sokrates.indexes` lassen sich Indexseiten definieren. Das sind einerseits die
`index.html` und andererseits der Artikel-Feed unter [`feed.xml`].

[`feed.xml`]: /feed.xml

## Übersetzung der Inhalte

Beim Übersetzen der Inhalte hat sich eigentlich nicht viel im Vergleich zu Bread geändert. Es wird nach wie vor Pandoc
zum Übersetzen von Markdown zu HTML eingesetzt. Ich hatte bei der Entwicklung kurzzeitig überlegt, direkt [CommonMark]
einzusetzen, mich dann jedoch vorerst dagegen entschieden, um die Migration dieses Blogs einfacher zu halten.
Langfristig ergibt der Einsatz von CommonMark jedoch durchaus Sinn. 

[CommonMark]: https://commonmark.org 

~~~ markdown
---
title: Migration von Bread zu Sokrates
alias: bread-sokrates-migration.md

author: Paul Vorbach
created-at: 2018-08-19

tags: [ deutsch, self, bread, sokrates, cms, weblog ]
locale: de-DE

template: post-corristo.ftl
teaser:
  image-url: /2018/sokrates.jpg

properties:
  highlight: "#43679C"
...

Selbstbezogene Blog-Posts schreiben sich immer am leichtesten. ;-)
~~~

Die Metadaten zum jeweiligen Blog-Post werden in einem sog. YAML-Front-Matter angegeben. Hierdurch bestimmen sich der
Titel, die Sprache, die verlinkten Tags, das Template usw.

## Ausführung über die Commandline oder Maven

Ursprünglich hatte ich auch überlegt, direkt ein Maven-Plugin für Sokrates zu schreiben, da ich plante, Maven als
Build-Tool für dieses Blog einzusetzen. Nach [anfänglichen Schwierigkeiten, Spring Boot in einem Maven-Plugin
einzusetzen](https://stackoverflow.com/q/48085705/432354), habe ich den Rat von Maven PMC-Member Karl Heinz Marbaise
befolgt und mich für die Integration per [`maven-exec-plugin`] entschieden. Nachfolgend der relevante Auszug aus der
`pom.xml`.

[`maven-exec-plugin`]: https://www.mojohaus.org/exec-maven-plugin/

~~~ xml
<dependencies>
    <dependency>
        <groupId>de.vorb.sokrates</groupId>
        <artifactId>sokrates</artifactId>
        <version>0.1.1</version>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.codehaus.mojo</groupId>
            <artifactId>exec-maven-plugin</artifactId>
            <version>1.6.0</version>
            <configuration>
                <includeProjectDependencies>true</includeProjectDependencies>
            </configuration>
            <executions>
                <execution>
                    <id>generate-site</id>
                    <phase>prepare-package</phase>
                    <goals>
                        <goal>exec</goal>
                    </goals>
                    <configuration>
                        <executable>java</executable>
                        <arguments>
                            <argument>-classpath</argument>
                            <classpath/>
                            <argument>de.vorb.sokrates.app.SokratesApp</argument>
                            <argument>generate</argument>
                            <argument>--force</argument>
                        </arguments>
                        <workingDirectory>${project.basedir}</workingDirectory>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
~~~

Alternativ kann man sich auch direkt das Fat-JAR bauen und es per `java -jar sokrates-0.1.1.jar generate` ausführen.
Selbst bevorzuge ich jedoch den Weg über Maven, da man sich so nicht merken muss, wie das Tool aufzurufen ist. Ein
einfaches `mvn package` genügt, um das Blog zu bauen.

## Fazit

Wer sich den [Markt der Static-Site-Generatoren][static-site-generators] ansieht, wird das alles hier für
Zeitverschwendung halten und das ist es mit Sicherheit auch – schließlich gibt es eine Unzahl an Generatoren in allen
erdenklichen Sprachen. Aber ich fand es amüsanter, das Tool zu schreiben, als mich in eine der Alternativen hinreichend
einzuarbeiten, um dieses Blog ohne großen Anpassungen an der URL-Struktur migrieren zu können. Außerdem sind mir so
keine Grenzen gesetzt, was zukünftige Features angeht und ich kann weiterhin sagen, die Software hinter meiner Website
selbst geschrieben zu haben.

[static-site-generators]: https://www.staticgen.com

Den Einsatz für das eigene Blog würde ich anderen jedoch nicht empfehlen, da es Sokrates wie üblich an Dokumentation und
Support mangelt. Wer sich aber dafür interessiert, kann sich gerne einmal das [Git-Repository][Sokrates] selbst und das
[Repository zu diesem Blog][vorba.ch-repo] auf GitHub ansehen.

[vorba.ch-repo]: https://github.com/pvorb/vorba.ch
