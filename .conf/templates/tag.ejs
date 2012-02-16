<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/milten.css">
    <link rel="icon" href="/favicon.ico">
    <meta name="author" content="<%= author %>">
  </head>
  <body>
    <header id="site">
      <a href="/"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li class="active"><a href="/log/">Blog</a>
        <li><a href="/info/">Info</a>
      </ul>
      <ol id="path">
<%
var path = ('/log/tag/'+title+'.html').split('/'),
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
        <h1>Kategorie: <em><%= title %></em></h1>
        <p class="meta"><%= __docs.length %> Artikel</p>
      </header>
      <section>
        <ul>
<%
__docs.forEach(function(doc) {
  var date = doc.date;
  var datestr = date.getDate()+'.'+date.getMonth()+'.'+date.getFullYear();
%>
          <li><a href="<%= doc._id %>"><%= doc.title %></a>, <%= datestr %>
<%
});
%>
        </ul>
      </section>
    </article>
    <footer id="about">
      <p>© 2008-<%= __docs[0].date.getFullYear() %> – <%= author %>
        <a href="/info/contact.html">Kontakt</a>.</p>
    </footer>
  </body>
</html>
