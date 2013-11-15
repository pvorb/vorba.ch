<%
var path = ('/'+__dir).split('/');
var pathref = '/';
%><!DOCTYPE html>
<html lang="en" id="top">
  <head>
    <meta charset="utf-8">
    <title><%- title %> | <%- siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Comment feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body id="top">
    <nav id="nav">
      <ol id="path">
<%
  for (var i = 0; i < path.length; i++) {
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorba.ch</a>
<%  } else if (i < path.length - 1) {%>
        <li><a href="<%= pathref %>"><%- path[i] %></a>
<%  } else {%>
        <li><%- path[i] %>
<%  }
    pathref += path[i+1]+'/';
  }
%>
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
      </form>
    </nav>
    <article id="content" class="digest">
      <header>
        <h1><%- title %></h1>
      </header>
      <section>
        <ul>
<% __files.forEach(function(file) { %>
        <li><a href="<%= file %>"><%- file %></a>
<% }); %>
        </ul>
      </section>
    </article>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%- siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
