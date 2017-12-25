<%
function pad(n) { return n<10?'0'+n:n; }
function getDate(d) {
  return pad(d.getDate())+'.'+pad(d.getMonth()+1)+'.'+d.getFullYear();
}
%><!DOCTYPE html>
<html lang="de" id="top">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/milten.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Artikel-Feed">
    <link rel="alternate" type="application/atom+xml" href="/comment-feed.xml"
      title="Comment feed">
    <meta name="author" content="<%= author %>">
<%
if (locals.tags) {
%>
    <meta name="keywords" content="<%= tags.join(", ") %>">
<%
}
%>
  </head>
  <body>
    <header id="site">
      <a href="/" accesskey="h"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ol id="path"><%
  var path = _id.split('/');
  var pathref = '';

  for (var i = 0; i < path.length; i++) {
    pathref += path[i] + '/';
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorba.ch</a>
<%  } else if (i < path.length - 1) {%>
        <li><a href="/#<%= path[i] %>"><%- path[i] %></a>
<%  } else {%>
        <li><%- path[i] %>
<%  }
  }
%>
      </ol>
      <ol id="access">
        <li><a href="#top" title="Zum Anfang" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Inhalt</a>
        <li><a href="#comments" accesskey="c">Kommentare</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1><%= title %></h1>
        <p class="meta">von <span class="author"><%- author
          %></span>, <span class="created"><%- getDate(created) %></span></p>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <% if (typeof teaser == 'string') {
            %><img src="<%= teaser %>"><% }
          else if (typeof teaser == 'object') {
            %><img src="<%= teaser.img %>"><% } %>
        </figure>
<% } %>
      </header>
      <section>
        <%- __content %>
      </section>
      <footer class="meta">
        <p>Kategorien:
<%
if (locals.tags)
  for (var i = 0, len = tags.length; i < len; i++) { var tag = locals.tags[i];
%>
          <a href="/tag/<%= tag %>.html"><%= tag %></a> <%= (i == len - 1) ?
            '' : '·' %>
<%
  }
%>
        </p>
<% if (typeof locals.teaser == 'object') { %>
        <p>Aufmacherbild von <%- teaser.url
          ? '<a href="'+teaser.url+'">'+teaser.author+'</a>' : teaser.author
          %>.<%- teaser.license ? ' Lizenz: <a href="'+teaser.license.url
          +'">'+teaser.license.name+'</a>.':'' %></p>
<% } %>
      </footer>
    </article>
    <section id="comments">
      <section id="isso-thread" data-title="<%= title %>"></section>
      <script data-isso-lang="de" src="//comments.vorba.ch/js/embed.min.js"></script>
      <noscript>Bitte aktivieren Sie JavaScript, um die Kommentare zu sehen.</noscript>
    </section>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </aside>
    <footer id="about">
      <p>© <%= created.getFullYear() %> – <%= author %>.
        <a href="http://paul.vorba.ch/">Kontakt</a>.</p>
    </footer>
  </body>
</html>
