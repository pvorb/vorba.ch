<%
function pad(n) { return n < 10 ? '0' + n : n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}

var byYear = {};
var years = [];
__docs.forEach(function(doc) {
  var year = doc.created.getFullYear();
  if (typeof byYear[year] == 'undefined') {
    byYear[year] = [];
    years.push(year);
  }

  byYear[year].push(doc);
});
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Archive | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml" href="/comment-feed.xml"
      title="Comment feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body id="top">
    <nav id="nav">
      <ol id="path">
        <li><a href="/">vorba.ch</a></li>
        <li>archive.html</li>
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </nav>
    <article id="content" class="digest">
      <header>
        <h1>Archive</h1>
      </header>
      <section>
<% years.forEach(function(year) { %>
        <h2 id="<%= year %>"><%= year %></h1>
        <ul>
<% byYear[year].forEach(function(doc) { %>
          <li><%- getDate(doc.created) %>, <a href="/<%= doc._id %>"><%-
            doc.title %></a></li>
<% }); %>
        </ul>
<% }); %>
      </section>
    </section>
    <footer id="about">
      <p>© 2008-<%= __docs[0].created.getFullYear() %> – <%= siteAuthor %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
