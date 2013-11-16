title: Suchschlitz und Benutzbarkeit
created: 2012-05-05T23:00:00+0200
modified: 2012-05-05T23:10:00+0200
teaser: typewriter.jpg
tags: [ deutsch, html, search ]
template: post.de.tpl


Die [Volltextsuche] hat sich jetzt schon zwei Monate bewährt. Also habe ich nun
einen Suchschlitz ins Design eingebaut.

[Volltextsuche]: /log/2012/03/volltextsuche.html

Und wo ich schon dabei war, jedes Template zu ändern, habe ich auch gleich noch
ein paar nette Tastenkombinationen eingefügt, die die Seite für
Tastatur-Fanatiker (wie mich) einfacher bedienbar machen sollen.

  * Im Firefox muss man `Alt` + `⇧ Shift` + die genannte Taste unter Windows und
    `Ctrl` + Taste unter Mac drücken.
  * Im Chrome reicht `Alt` + die genannte Taste (bei bereits belegten
    Kombinationen muss zusätzlich `⇧ Shift` gedrückt werden) unter Windows, Mac
    benötigt `Ctrl` + `⌥ Opt`.
  * Genauso geht es in Safari.
  * Im Internet Explorer funktioniert es wie in Chrome und Safari mit `Alt`, nur
    dass die Links hier lediglich vorausgewählt werden und man mit `Return`
    bestätigen muss.
  * In Opera aktiviert man den „Access-Key-Modus“ mit `⇧ Shift` + `Esc` und kann
    dann die genannten Tasten drücken.

Sinnvoll fände ich, wenn das plattformübergreifend ganz ohne Modifier-Tasten
funktionieren würde. Das ist nämlich nirgends belegt und könnte somit überall
gleich funktionieren. Aber man kann schließlich nicht alles haben.

Die Tasten sind folgendermaßen belegt:

  * `H`: Zur Startseite wechseln
  * `L`: Zum „Blog“ wechseln
  * `I`: Zu den Info-Seiten wechseln
  * `T`: Zum Seitenanfang springen
  * `S`: Zur Suche springen
  * `C`: Zu den Kommentaren springen (nur bei Seiten mit Kommentarfunktion)
  * `P`: Zur vorherigen Seite wechseln (nur bei Index-Seiten)
  * `N`: Zur nächsten Seite wechseln (nur bei Index-Seiten)

Das ganze funktioniert ganz einfach über das HTML-Attribut [`accesskey`][a].

[a]: http://www.w3.org/TR/html-markup/global-attributes.html#common.attrs.accesskey
