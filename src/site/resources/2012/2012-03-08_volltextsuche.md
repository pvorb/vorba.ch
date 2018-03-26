title: Volltextsuche mit Node.js
created: 2012-03-08T11:00:00+0100

teaser: hdd-search.jpg
tags: [ deutsch, dev, search, bread ]
template: post.de.tpl


Hier fehlt noch eine Volltextsuche. Das ist aufgrund der Architektur von Bread
nicht ganz trivial. Also habe ich mir überlegt, ob es vielleicht für den Moment
ausreichen würde, das einfache UNIX-Kommando


    find . -iname '*.html' | xargs grep 'suchterm' -sl


dafür zu benutzen. Das durchsucht dann alle HTML-Dateien nach dem exakten
Begriff und gibt eine Liste aus. Diese Liste könnte ich dann einfach so als
dynamisch gerendertes HTML ausgeben.

Ja, ich glaube, das versuche ich mal.
