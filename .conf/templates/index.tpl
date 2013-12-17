<%
function pad(n) { return n<10?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml" href="/comment-feed.xml"
      title="Comment feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body id="top">
    <nav id="nav">
      <ol id="path">
        <li>vorba.ch</li>
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </nav>
    <section id="content" class="digest">
      <header class="meta">
        <p>
          <a href="/archive.html" class="button">Archive</a> ·
          <a href="/tag/" class="button">Tags</a> ·
          <a href="/feed.xml" class="feed button">Article feed</a> ·
          <a href="/comment-feed.xml" class="feed button">Comment feed</a> ·
          <a href="/blogroll.html" class="button"%>Blogroll</a></p>
      </header>
<% __docs.forEach(function(doc) { %>
      <article<%= doc.lang ? ' lang="'+doc.lang+'"' : '' %>>
        <header>
<%
var lines = doc.__content.split('</p>', 2);
doc.__content = lines.join('</p>');
%>
          <h1><a href="/<%= doc._id %>"><%= doc.title %></a></h1>
<% if (doc.teaser) {
  var teaser = doc._id.split('/').slice(0, -1);
  if (typeof doc.teaser == 'string')
    teaser.push(doc.teaser);
  else if (typeof doc.teaser == 'object')
    teaser.push(doc.teaser.img);
  teaser = teaser.join('/');
%>
          <figure class="teaser">
            <a href="/<%= doc._id %>"><img src="/<%= teaser %>"></a>
          </figure>
<% } %>
          <p class="meta"><%- getDate(doc.created) %> &ndash; <a href="/<%= doc._id %>#disqus_thread">Comments</a></p>
        </header>
        <section>
          <%- doc.__content %>
          <p><a href="/<%= doc._id %>">Read on &hellip;</a></p>
        </section>
      </article>
<% }); %>
      <ul class="pagination">
<% if (__pagination.first) { %>
        <li><a href="/<%= __pagination.first.file %>"><%-
          __pagination.first.page %></a>
        <li>…
<% }
if (__pagination.prev) { %>
        <li><a href="/<%= __pagination.prev.file %>" accesskey="p"><%-
          __pagination.prev.page %></a>
<% } %>
        <li><span><%- __pagination.this %></span>
<% if (__pagination.next) { %>
        <li><a href="/<%= __pagination.next.file %>" accesskey="n"><%-
          __pagination.next.page %></a>
<% }
if (__pagination.last) { %>
        <li>…
        <li><a href="/<%= __pagination.last.file %>"><%-
          __pagination.last.page %></a>
<% } %>
      </ul>
    </section>
    <footer id="about">
      <p>© 2008-<%= __docs[0].created.getFullYear() %> – <%= siteAuthor %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
    <script type="text/javascript">
      var disqus_shortname = 'vorbach';

      (function () {
        var s = document.createElement('script'); s.async = true;
        s.type = 'text/javascript';
        s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
        (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
      }());
    </script>
  </body>
</html>
