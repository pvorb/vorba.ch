<%
function pad(n) { return (n<10)? '0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tags | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/comment-feed.xml" title="Comment feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body>
    <nav id="nav">
      <ol id="path"><%
  var path = ('/tag').split('/');
  var pathref = '/';

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
    <article id="content">
      <header>
        <h1>Tags</h1>
        <p class="meta"><%- __tags.length %> tags</p>
      </header>
      <section>
        <ul>
<% __tags.forEach(function(tag) { %>
          <li><a href="/tag/<%= tag %>.html"><%- tag %></a>
<% }); %>
        </ul>
      </section>
    </article>
    <aside id="extra">
    </aside>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
