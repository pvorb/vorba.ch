<%
function pad(n) { return (n<10)?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tags | <%= siteTitle %></title>
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
      <ol id="path"><%
  var path = ('/log/tag').split('/');
  var pathref = '/';

  for (var i = 0; i < path.length; i++) {
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorb.de</a>
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
        <li><a href="#top" title="To the top" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1>Tags</h1>
        <p class="meta"><%- __tags.length %> tags</p>
      </header>
      <ul>
<% __tags.forEach(function(tag) { %>
        <li><a href="/log/tag/<%= tag %>.html"><%- tag %></a>
<% }); %>
      </ul>
    </article>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
