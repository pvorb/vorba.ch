<%
function pad(n) { return n<10?'0'+n:n; }
function getDate(d) {
  return pad(d.getDate())+'.'+pad(d.getMonth()+1)+'.'+d.getFullYear();
}
%><!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Artikel-Feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Kommentar-Feed">
    <meta name="author" content="<%= author %>">
<%
if (locals.tags) {
%>
    <meta name="keywords" content="<%= tags.join(", ") %>">
<%
}
%>
  </head>
  <body id="top">
    <nav id="nav">
      <ol id="path"><%
  var path = _id.split('/');
  var pathref = '';

  for (var i = 0; i < path.length; i++) {
    pathref += path[i] + '/';
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorba.ch</a>
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
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </nav>
    <article id="content">
      <header>
        <h1><%= title %></h1>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <% if (typeof teaser == 'string') {
            %><img src="<%= teaser %>"><% }
          else if (typeof teaser == 'object') {
            %><img src="<%= teaser.img %>"><% } %>
        </figure>
<% } %>
        <p class="meta">von <span class="author"><%- author
          %></span>, <span class="created"><%- getDate(created) %></span>
          &ndash; <a href="http://vorba.ch<%= _id %>#disqus_thread">Kommentare</a></p>
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
      <div id="disqus_thread"></div>
      <script type="text/javascript">
        var disqus_shortname = 'vorbach';
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
      </script>
      <noscript>Bitte aktivieren Sie JavaScript, um die Kommentare zu sehen.</noscript>
    </section>
    <footer id="about">
      <p>© <%= created.getFullYear() %> – <%= author %>.
        <a href="/info/contact.html">Kontakt</a>.</p>
    </footer>
  </body>
</html>
