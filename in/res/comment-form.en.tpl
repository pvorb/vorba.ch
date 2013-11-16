<form id="cf" method="POST">
  <h2>Leave a comment</h2>
  <textarea name="message" rows="12" cols="30" placeholder="Comment"
    id="cf-message"></textarea><br>

  <input name="author" type="text" size="30" id="cf-author">
  <label for="cf-author">Name</label><br>

  <input name="email" type="text" size="30" id="cf-email">
  <label for="cf-email">E-mail address</label>
  <span class="opt" title="optional; Gravatar only">?</span><br>

  <input name="website" type="text" size="30" id="cf-website">
  <label for="cf-website">Website</label>
  <span class="opt" title="optional">?</span><br>

  <input name="nospam" type="checkbox" id="cf-nospam">
  <label for="cf-nospam">I’m neither dog nor spambot.</label>
  <span class="opt" title="Check this box to leave a comment.">?</span><br>

  <input name="save" type="button" value="Submit comment" id="cf-save">
  <img id="cf-status" src="/res/load.gif" style="display:none">
</form>
<article id="cp">
  <h3>Preview</h3>
  (<a id="cp-doc" href="/info/markdown.en.html">Markdown guide</a>)
  <section id="cp-stage"></section>
</article>
