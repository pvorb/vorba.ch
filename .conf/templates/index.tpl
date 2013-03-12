<%
function pad(n) { return n<10?'0'+n:n; }
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
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Comment feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body>
    <header id="site">
      <a href="/" accesskey="h"><%= siteTitle %></a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li class="active"><a href="/log/" accesskey="l">/log</a>
        <li><a href="/info/" accesskey="i">/info</a>
      </ul>
      <ol id="path"><%
  var path = ('/log').split('/');
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
    <section id="content" class="digest">
      <header class="meta">
        <p><a href="tag/" class="button">Tags</a> ·
          <a href="subscription.html" class="button">Subscribe</a> ·
          <a href="feed.xml" class="feed button">Article feed</a> ·
          <a href="comment-feed.xml" class="feed button">Comment feed</a> ·
          <a href="blogroll.html" class="button"%>Blogroll</a></p>
      </header>
<% __docs.forEach(function(doc) { %>
      <article>
        <header>
<%
var lines = doc.__content.split('</p>', 2);
doc.__content = lines.join('</p>');
%>
          <h1><a href="/<%= doc._id %>"><%= doc.title %></a></h1>
          <p class="meta"><%- getDate(doc.created) %></p>
<% if (doc.teaser) {
  var teaser = doc._id.split('/').slice(0, -1);
  if (typeof doc.teaser == 'string')
    teaser.push(doc.teaser);
  else if (typeof doc.teaser == 'object')
    teaser.push(doc.teaser.img);
  teaser = teaser.join('/');
%>
          <figure class="teaser">
            <a href="/<%= doc._id %>"><img src="/<%= teaser %>"></a>
          </figure>
<% } %>
        </header>
        <section>
          <%- doc.__content %>
          <p><a href="/<%= doc._id %>">Read on »</a></p>
        </section>
      </article>
<% }); %>
      <ul class="pagination">
<% if (__pagination.first) { %>
        <li><a href="/<%= __pagination.first.file %>"><%-
          __pagination.first.page %></a>
        <li>…
<% }
if (__pagination.prev) { %>
        <li><a href="/<%= __pagination.prev.file %>" accesskey="p"><%-
          __pagination.prev.page %></a>
<% } %>
        <li><span><%- __pagination.this %></span>
<% if (__pagination.next) { %>
        <li><a href="/<%= __pagination.next.file %>" accesskey="n"><%-
          __pagination.next.page %></a>
<% }
if (__pagination.last) { %>
        <li>…
        <li><a href="/<%= __pagination.last.file %>"><%-
          __pagination.last.page %></a>
<% } %>
      </ul>
    </section>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
      </form>
    </aside>
    <footer id="about">
      <p>© 2008-<%= __docs[0].created.getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
