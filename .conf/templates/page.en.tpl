<%
function pad(n) { return (n<10)?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="en" id="top">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/milten.css">
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
    <header id="site">
      <a href="/" accesskey="h"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li<%- locals.branch == 'log' ? ' class="active"' : ''
          %>><a href="/log/" accesskey="l">Blog</a>
        <li<%- locals.branch == 'info' ? ' class="active"' : ''
          %>><a href="/info/" accesskey="i">Info</a>
      </ul>
      <ol id="path"><%
  var path = _id.replace(/\/index\.html$/, '');
  path = path.split('/');
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
        <li><a href="#top" title="To the top" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1><%= title %></h1>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <img src="<%= teaser %>">
        </figure>
<% } %>
      </header>
      <section>
        <%- __content %>
      </section>
<% if (locals.modified) { %>
      <footer class="meta">
        <p>Last modified: <%- getDate(modified) %></p>
      </footer>
<% } %>
    </article>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
      </form>
    </aside>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
