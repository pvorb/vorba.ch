<%
function pad(n) { return n<10? '0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml" href="/comment-feed.xml"
      title="Comment feed">
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

  for (var i = 0; i < path.length - 1; i++) {
    pathref += path[i] + '/';
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorba.ch</a>
<%  } else if (i == 1) {%>
        <li><a href="/archive.html#<%= path[i] %>"><%- path[i] %></a>
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
        <li><a href="#comments" accesskey="c">Comments</a>
      </ol>
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
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
        <p class="meta">by <span class="author"><%- author
          %></span>, <span class="created"><%- getDate(created) %></span>
          &ndash; <a href="#comments">Comments</a></p>
      </header>
      <section>
        <%- __content %>
      </section>
      <footer class="meta">
        <p>Tags:
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
        <p>Teaser image by <%- teaser.url
          ? '<a href="'+teaser.url+'">'+teaser.author+'</a>' : teaser.author
          %>.<%- teaser.license ? ' License: <a href="'+teaser.license.url
          +'">'+teaser.license.name+'</a>.':'' %></p>
<% } %>
      </footer>
    </article>
    <section id="comments">
      <section id="isso-thread" data-title="<%= title %>"></section>
      <script data-isso-lang="en" src="//comments.vorba.ch/js/embed.min.js"></script>
      <noscript>Please enable JavaScript to view the comments.</noscript>
    </section>
    <footer id="about">
      <p>© <%= created.getFullYear() %> – <%= author %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
