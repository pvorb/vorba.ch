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
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Artikel-Feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Kommentar-Feed">
    <link rel="pingback" href="http://vorb.de/log/pingback">
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
      <ul id="branches">
        <li class="active"><a href="/log/" accesskey="l">Blog</a>
        <li><a href="/info/" accesskey="i">Info</a>
      </ul>
      <ol id="path"><%
  var path = _id.split('/');
  var pathref = '';

  for (var i = 0; i < path.length; i++) {
    pathref += path[i] + '/';
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorb.de</a>
<%  } else if (i < path.length - 1) {%>
        <li><a href="<%= pathref %>"><%- path[i] %></a>
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
        <p class="meta"><%- getDate(created) %></p>
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
          <a href="/log/tag/<%= tag %>.html"><%= tag %></a> <%= (i == len - 1) ?
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
    <section id="comments"></section>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </aside>
    <footer id="about">
      <p>© <%= created.getFullYear() %> – <%= author %>.
        <a href="/info/contact.html">Kontakt</a>.</p>
    </footer>
    <script src="/res/comments.de.min.js"></script>
  </body>
</html>
