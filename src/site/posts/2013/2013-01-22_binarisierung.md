---
title: Binarisierung
alias: binarisierung.md

author: Paul Vorbach
created-at: 2013-01-22

tags: [ deutsch, dev, scala, computer-vision, algorithm ]
locale: de-DE

template: post-diego.ftl
properties:
  teaser:
    imageUrl: binarization.jpg
...

In meiner Bachelorarbeit, die den Titel „Erstellung von TrueType-Fonts zu
historischen Manuskripten“ trägt, stand ich vor dem Problem, wie Zeichen in
gescannten Manuskripten am besten erkannt werden können und wie sie in ein
Vektorformat überführt werden können. Dazu hat es sich als hilfreich erwiesen,
solche Scans zunächst in eine binarisierte Form zu bringen. Pixelmengen lassen
sich sehr einfach gruppieren, wenn es nur schwarze und weiße Pixel gibt.

Zunächst einmal kann man sich ohne Mühe einfache Verfahren ausdenken, die für
jeden Pixel eines Bildes entscheiden, ob er schwarz oder weiß erscheinen soll.
Das einfachste solche Verfahren ist, einen _festen Schwellwert_ zu verwenden,
nach dem das Bild aufgeteilt wird. Ist die Farbe in einem Pixel heller, so wird
der Pixel weiß gefärbt, ist der Pixel dunkler, so wird der Pixel schwarz
gefärbt.

Bei gescannten Dokumenten und besonders historischen Schriften steht man aber
vor dem Problem, dass der Kontrast zwischen Schrift und Hintergrund (teilweise
vergilbtes Papier oder Pergament) sehr klein werden können. Außerdem können
einzelne Bildbereiche heller oder dunkler sein als andere. Deshalb lässt sich
die Schrift mit einem festen Schwellwert nur noch sehr schlecht vom Hintergrund
trennen.

Für solche Fälle existieren _adaptive_ Verfahren, die jeweils nur die Umgebung
um einen Pixel beim Ermitteln eines lokalen Schwellwerts betrachten. Diese
Verfahren sind aber wesentlich aufwändiger als einfache Schwellwertverfahren.
Leider existieren keine Programme, die _out of the box_ Bilder adaptiv
binarisieren können.

Diesen Umstand habe ich mir zum Anlass genommen, ein kleines Scala-Programm zu
schreiben, das diesen Zweck erfüllt und mit einer kleinen GUI daherkommt.
Zunächst einmal habe ich nur den [Binarisierungsalgorithmus nach
Sauvola][sauvola] implementiert. Weitere Verfahren sollen folgen.

Zur Installation benötigt man lediglich das _Java Runtime Environment (JRE) 6_
oder höher. Die [Installation erfolgt über
Java WebStart](https://repo.vorb.de/downloads/image-binarization.jnlp).
Der Quelltext steht unter einer [MIT-Lizenz](/license/mit.html)
und ist bei [GitHub](https://github.com/pvorb/image-binarization) verfügbar.

[sauvola]: http://www.mediateam.oulu.fi/publications/pdf/24.p
