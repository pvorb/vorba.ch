<form id="cf" method="POST">
  <h2>Kommentar schreiben</h2>
  <textarea name="message" rows="12" cols="30" placeholder="Kommentar"
    id="cf-message"></textarea><br>

  <input name="author" type="text" size="30" id="cf-author">
  <label for="cf-author">Name</label><br>

  <input name="email" type="text" size="30" id="cf-email">
  <label for="cf-email">E-Mail-Adresse</label>
  <span class="opt" title="optional; nur für Gravatar">?</span><br>

  <input name="website" type="text" size="30" id="cf-website">
  <label for="cf-website">Website</label>
  <span class="opt" title="optional">?</span><br>

  <input name="nospam" type="checkbox" id="cf-nospam">
  <label for="cf-nospam">Bin weder Hund noch Spambot.</label>
  <span class="opt" title="Zum Kommentieren ankreuzen.">?</span><br>

  <input name="save" type="button" value="Kommentar veröffentlichen" id="cf-save">
  <img id="cf-status" src="/res/load.gif" style="display:none">
</form>
<article id="cp">
  <h3>Vorschau</h3>
  (<a id="cp-doc" href="/info/markdown.de.html">Markdown-Anleitung</a>)
  <section id="cp-stage"></section>
</article>
