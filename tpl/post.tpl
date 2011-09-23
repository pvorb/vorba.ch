<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/<%= stylesheet %>">
    <link rel="icon" href="/favicon.ico">
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
    <header id="top">
      <a href="/"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li class="active"><a href="/log/">Blog</a>
        <li><a href="/info/">Info</a>
      </ul>
      <ol id="path">
<%
var path = _id.split('/'),
    pathref = '/';

for (var i = 1; i < path.length; i++) {
  if (i < path.length - 1)
    pathref += path[i] + '/';
  else
    pathref += path[i];
%>
        <li><%
  if (i < path.length - 1) {
    %><a href="<%- pathref %>"><%
  }
  %><%= path[i] == 'log' ? 'blog' : path[i] %><%
  if (i < path.length - 1) {
    %></a><%
  }
}
%>
      </ol>
      <ol id="access">
        <li><a href="#top" title="Zum Anfang" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Inhalt</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1><%= title %></h1>
<% if (locals.teaser) { %>
        <aside>
          <figure class="teaser">
            <img src="<%= teaser %>">
          </figure>
        </aside>
<% } %>
      </header>
      <section>
        <%- __content %>
      </section>
<%
var datestr = date.getDate()+'.'+date.getMonth()+'.'+date.getFullYear();
%>
      <footer class="meta">
        <p>Geschrieben am <time><%= datestr %></time>; Kategorien:
<%
if (locals.tags)
  for (var i = 0, len = tags.length; i < len; i++) { var tag = locals.tags[i];
%>
          <a href="/log/tag/<%= tag %>.html"><%= tag %></a><%= (i == len - 1) ? '' : ',' %>
<%
  }
%>
        </p>
      </footer>
    </article>
    <footer id="about">
      <p>© <%= date.getFullYear() %> – <%= author %>
        <a href="/info/contact.html">Kontakt</a>.</p>
    </footer>
  </body>
</html>
