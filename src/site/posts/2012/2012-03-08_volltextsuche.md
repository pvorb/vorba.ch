---
title: Volltextsuche mit Node.js
alias: volltextsuche.md

author: Paul Vorbach
created-at: 2012-03-08

tags: [ deutsch, self, dev, search, bread ]
locale: de-DE

template: post-milten.ftl
properties:
  teaser:
    imageUrl: hdd-search.jpg
...

Hier fehlt noch eine Volltextsuche. Das ist aufgrund der Architektur von Bread
nicht ganz trivial. Also habe ich mir überlegt, ob es vielleicht für den Moment
ausreichen würde, das einfache UNIX-Kommando


    find . -iname '*.html' | xargs grep 'suchterm' -sl


dafür zu benutzen. Das durchsucht dann alle HTML-Dateien nach dem exakten
Begriff und gibt eine Liste aus. Diese Liste könnte ich dann einfach so als
dynamisch gerendertes HTML ausgeben.

Ja, ich glaube, das versuche ich mal.
