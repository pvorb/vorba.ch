<% var monthNames = {
  '01': 'January',
  '02': 'February',
  '03': 'March',
  '04': 'April',
  '05': 'May',
  '06': 'June',
  '07': 'July',
  '08': 'August',
  '09': 'September',
  '10': 'October',
  '11': 'November',
  '12': 'December'
};

var path = ('/'+__dir).split('/');
var pathref = '/';
%><!DOCTYPE html>
<html lang="en" id="top">
  <head>
    <meta charset="utf-8">
    <title><%- monthNames[title] %> <%- path[2] %> | <%- siteTitle %></title>
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
        <li class="active"><a href="/log/" accesskey="l">Blog</a>
        <li><a href="/info/" accesskey="i">Info</a>
      </ul>
      <ol id="path">
<%
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
      <header>
        <h1><%- monthNames[title] %> <%- path[2] %></h1>
      </header>
      <ul>
<% __files.forEach(function(file) { %>
        <li><a href="<%= file %>"><%- file %></a>
<% }); %>
      </ul>
    </section>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
      </form>
    </aside>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%- siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
