---
title: FontAwesome-Dateigröße reduzieren
alias: fontawesome-dateigroesse-reduzieren.md

author: Paul Vorbach
created-at: 2014-04-11

tags: [ deutsch, css, '@font-face', fontawesome, fontforge ]
locale: de-DE

template: post-diego.ftl
teaser:
  image-url: /2014/fontawesome.png
...

Seit heute habe ich hier ein paar Pictogramme von [FontAwesome] im Einsatz. Mich
hat aber die initiale Download-Größe von rund 29 kByte für das WOFF-File
gestört. Die anderen Dateien bewegen sich ebenfalls in diesem Rahmen, werden
aber in den meisten Browsern nicht gebraucht. Wer braucht schon ein Arsenal von
369 Icons (Tendenz steigend) für sein Nullachtfünfzehn-Blog?

Also habe ich [FontForge] angeworfen und alle Icons entfernt, die ich nicht
benötige. Übrig geblieben sind ganze drei Icons. Mit FontForge lassen sich
außerdem die wichtigen Dateiformate exportieren &ndash; mit Außnahme von
_Embedded Open-Type_. Hierfür habe ich kurzerhand den
[OTF-zu-EOT-Konverter][otf2eot] verwendet.

Ergebnis ist eine WOFF-Datei von 2,14 kByte. Das sind nur noch 7,6 Prozent der
ursprünglichen Dateigröße. Ich kann also jedem empfehlen, der FontAwesome im
Einsatz hat und nur einen Bruchteil der angebotenen Icons verwendet, die
Dateigröße zu reduzieren. Der Aufwand ist vergleichsweise gering.


[FontAwesome]: http://fontawesome.io/
[FontForge]: http://fontforge.org
[otf2eot]: http://everythingfonts.com/otf-to-eot
