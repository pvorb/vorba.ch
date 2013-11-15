title: Die Reichweite von Node.js
created: 2013-03-19T01:45:00+0100
modified: 2013-03-19T01:50:00+0100

tags: [ deutsch, nodejs ]
template: post.diego.de.tpl
teaser: chart.jpg


Seit letztem Sommer werden in [npm](http://npmjs.org/) Download-Statistiken
angezeigt. Sieht man sich ein einzelnes Modul an, so werden die Downloads des
letzten Tages, der letzten Woche und des letzten Monats angezeigt.

Das ist ganz nett, aber nicht immer besonders vielsagend. Da npm seine Daten
über eine [CouchDB](http://couchdb.apache.org/) bezieht, ist eine ansprechende
JSON API gleich mit von der Partie. Da die Daten wohldefiniert vorliegen, habe
ich mir schon vor gut einem halben Jahr eine kleine Statistik-Seite gebastelt,
die aus den Download-Daten drei Balkendiagramme für tägliche, wöchentliche und
monatliche Downloads baut: [npm-stat](http://npm-stat.vorb.de/).

Ich möchte aber auf was anderes hinaus:

Keine Community entwickelt sich derzeit so schnell, wie die von Node.js. Ein
paar Kennzahlen:

  * Im Monat werden insgesamt rund 26 Mio. Pakete heruntergeladen.
  * Es gibt ca. 25000 Pakete im Index. Das sind bereits fast so viele wie im
    Python Package Index (ca. 29000) und etwa halb so viele wie auf RubyGems
    (ca. 53000).
  * Wenn mit der gleichen Geschwindigkeit neue Pakete hinzukommen wie bisher,
    verdoppelt sich diese Zahl innerhalb des nächsten Jahres.
  * Im Schnitt wird ein Modul pro Monat 1000 Mal heruntergeladen.

Das sind äußerst beeindruckende Zahlen, bedenkt man, dass Node.js erst vier
Jahre alt ist und seit rund zwei Jahren so richtig in Fahrt kommt. Vor zwei
Jahren habe ich auch mit Node angefangen und seither [32 (meist kleinste)
Pakete][packages] geschrieben. Das beliebteste der Pakete[^1] wurde
[im Februar 15800 mal heruntergeladen][clone-stats]. 44 andere Pakete benutzen
das Paket und niemend weiß, wie viele andere Projekte außerhalb von npm noch.
Sogar Yahoo hat ein [kleines Testframework geschrieben][yahoo-arrow], das clone
einsetzt.

[^1]: [clone] kopiert einen beliebigen Wert, ob `Array`, `Object`,
völlig egal, und das rekursiv mit beliebiger Tiefe. Das ist eigentlich nichts
weltbewegendes und wird von einigen JS-Frameworks auch angeboten. Einziger
Unterschied ist vermutlich, dass _clone_ auch sog. _circular references_ korrekt
auflöst und mit kopiert. Ich habe es damals während der Arbeiten an [bread]
geschrieben. Ich wollte keinen 500-Pfund-Gorilla à la _underscore_ oder
ähnliches im Projekt haben, weil das meiner Meinung gegen den Ansatz von Node.js
geht, alles in kleinen Modulen zu halten, die miteinander verknüpft und
wiederverwendet werden können.

[packages]: http://npmjs.org/~pvorb
[clone]: http://npmjs.org/package/clone
[clone-stats]: http://npm-stat.vorb.de/charts.html?package=clone
[yahoo-arrow]: https://npmjs.org/package/yahoo-arrow
[bread]: /log/tag/bread.html

Dieser Eintrag kommt zu einer Zeit, zu der ich eher Distanz von Node.js nehme.
Es hat unglaublich viele Probleme und Schwachstellen, die die Entwicklung dafür
zur Hölle machen können. Dabei ist das Haupt-Problem JavaScript, das sich meiner
Ansicht nach nicht für größere Projekte eignet. Aber dazu ein ander mal mehr.

Trotzdem kann die Entwicklung Spaß machen und die Zahlen sprechen eine
eindeutige Sprache. Ich glaube nicht, dass ich ähnliche Download-Zahlen auf
einer anderen Plattform erreicht hätte.

Ich will damit gar niemanden von Node.js überzeugen, aber für so manches
Vorhaben mag es gerade wegen des riesigen Vorrats an Modulen und der aktiven
Community genau das Richtige Werkzeug sein.
