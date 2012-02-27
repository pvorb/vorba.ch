<form id="cf" method="POST">
  <h3>Leave a comment</h3>
  <textarea name="message" rows="12" cols="30" placeholder="Comment"
    id="cf-message"></textarea><br>

  <input name="author" type="text" size="30" id="cf-author">
  <label for="cf-author">Name</label><br>

  <input name="email" type="text" size="30" id="cf-email">
  <label for="cf-email">E-mail address</label>
  <span class="opt" title="optional; nur für Gravatar">?</span><br>

  <input name="website" type="text" size="30" id="cf-website">
  <label for="cf-website">Website</label>
  <span class="opt" title="optional">?</span><br>

  <input name="nospam" type="checkbox" id="cf-nospam">
  <label for="cf-nospam">I’m neither dog nor spambot.</label><br>

  <input name="save" type="button" value="Kommentar veröffentlichen" id="cf-save">
  <img id="cf-status" src="/res/load.gif" style="display:none">
</form>
<article id="cp">
  <h3>Preview</h3>
  (<a id="cp-doc" href="/res/markdown.en.html">Syntax notes</a>)
  <section id="cp-stage"></section>
</article>