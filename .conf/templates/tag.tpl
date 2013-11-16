<%
function pad(n) { return n<10?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="de" id="top">
  <head>
    <meta charset="utf-8">
    <title>Tag: <%- title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/comment-feed.xml" title="Comment feed">
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
    <nav id="nav">
      <ol id="path"><%
  var path = ('/tag/'+file).split('/');
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
        <h1>Tag: <em><%- title %></em></h1>
        <p class="meta"><%- __docs.length %> article<%= __docs.length === 1 ? '' : 's' %></p>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <img src="<%= teaser %>">
        </figure>
<% } %>
      </header>
      <section>
<% if (locals.__content) { %>
        <%- __content %>
<% } %>
<% if (__docs.length > 0) { %>
        <ul>
<% __docs.forEach(function (doc) { %>
          <li><%- getDate(doc.created) %>, <a href="/<%= doc._id %>"><%-
          doc.title %></a>
<% }); %>
        </ul>
      </section>
<% } %>
    </article>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%= author %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
