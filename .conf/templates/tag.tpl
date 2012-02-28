<%
function pad(n) { return n<10?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title>Tag: <%- title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/milten.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Comment feed">
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
      <a href="/"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li class="active"><a href="/log/">Blog</a>
        <li><a href="/info/">Info</a>
      </ul>
      <ol id="path"><%
  var path = ('/log/tag/'+title).split('/');
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
        <li><a href="#top" title="To the beginning" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <article id="content">
      <header>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <img src="<%= teaser %>">
        </figure>
<% } %>
        <h1>Tag: <em><%- title %></em></h1>
        <p class="meta"><%- __docs.length %> articles</p>
      </header>
<% if (locals.__content) { %>
      <section>
        <%- __content %>
      </section>
<% } %>
      <ul>
<% __docs.forEach(function (doc) { %>
        <li><a href="<%= doc._id %>"><%- doc.title %></a>, <%-
          getDate(doc.created) %>
<% }); %>
      </ul>
    </article>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%= author %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
