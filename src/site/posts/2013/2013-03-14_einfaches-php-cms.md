---
title: Einfaches PHP-CMS
alias: einfaches-php-cms.md

author: Paul Vorbach
created-at: 2013-03-14

tags: [ deutsch, dev, php, cms ]
locale: de-DE

template: post-diego.ftl
properties:
  teaser:
    imageUrl: pen-and-notebook.jpg
...

Ich schreibe gerade ein CMS. In PHP.

Ja, richtig gehört: PHP. Wie kommt jemand, der täglich mit Node.js, Scala und
noch abgefahreneren Sprachen zu tun hat, ausgerechnet auf PHP? Die Antwort ist
ganz einfach. Das ganze soll auf jedem noch so günstigen Webspace laufen und das
möglichst ohne Konfiguration. Dafür kommt nur PHP in Frage.

Nachdem ich seit 2011 viel mit neuen Sprachen und Plattformen experimentiert
habe, tut es ganz gut, mal wieder einfachstes PHP in den Bildschirm zu meißeln.

## Warum _noch ein_ CMS?

Ich habe mir im Zuge eines kleineren privaten Projekts viele verschiedene
Systeme angeschaut. Bei jedem CMS habe ich mir gedacht: Das geht auch einfacher.

Mein Use Case ist eine kleine Website mit einer Hand voll Seiten, die von mir
vorgefertigt erstellt werden und danach von angemeldeten Benutzern editiert
werden können sollen. Also muss ich es halt selbst machen, es sei den jemand
nennt mir in den Kommentaren ein CMS, das genau das tut und nicht wesentlich
mehr. _Daran glaube ich aber nicht._

Hier in ein paar Stichpunkten, was mir so vorschwebt:

  * Websites bestehen aus HTML. Daher wird es einen einzigen Inhaltstyp geben:
    HTML-Snippets. Diese werden dann über Templates in einer oder mehreren
    Seite(n) platziert.
  * Andere Möglichkeiten zur Definition von Inhalten sind nur noch händisch
    getippelte HTML- oder PHP-Dateien.
  * PHP ist eine Templatesprache. D.h. für Templates wird reines HTML mit
    eingebettetem PHP verwendet.
  * Es wird keinerlei Rechteverwaltung geben. Nach dem Login darf man alles
    editieren, was existiert. Meiner Meinung stören aufwendige Rechtesysteme
    meist nur bei der täglichen Arbeit. Hier geht es definitiv ohne.
  * Das Backend umfasst nur 2 bis 3 Seiten:
      1. Eine Editor-Seite, in der man die HTML-Snippets editieren kann
      2. Eine Liste der Benutzer mit Funktionen zum Hinzufügen und Entfernen
      3. Eventuell noch zusätzlich ein Formular, in dem man die Templates
         anpassen kann, sollte man keinen FTP-Zugang o.ä. haben
  * Die Editor-Seite wird vielleicht einen WYSIWYG-Editor spendiert bekommen,
    (der sich abstellen lässt), damit auch HTML-unerfahrene Benutzer das CMS
    benutzen können. Hier habe ich lange überlegt, ob ich vielleicht nicht
    lieber stattdessen Markdown anbieten soll. Je länger ich überlege, desto
    schwerer fällt mir die Wahl. Vielleicht bleibe ich doch bei einfachem
    Markdown mit Vorschau, wie hier in den Kommentaren. Vielleicht kann mir ja
    jemand mit Erfahrung in diesem Bereich die Entscheidung erleichtern.

Beim Endprodukt kann man dann wohl kaum noch von einem CMS sprechen (denn
verwaltet wird ja nicht viel), aber einen anderen Namen habe ich dafür nicht.
Website-Editor vielleicht...

Die Entwicklung am CMS kann im [GitHub-Repository](https://github.com/pvorb/chx)
verfolgt werden. Ich habe aber gerade erst damit begonnen, also erwartet noch
nicht zu viel.

Meinungen und Ratschläge: Immer her damit!
