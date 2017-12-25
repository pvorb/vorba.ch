<%
const pad = (n) => (n < 10) ? '0' + n : n;
const getDate = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

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
    <title><%= siteTitle %></title>
    <link rel="stylesheet" href="/res/corristo.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/feed.xml"
      title="Article feed">
    <meta name="author" content="<%= author %>">
  </head>
  <body id="top">
    <nav id="nav">
      <ol id="path">
        <li><a href="/">vorba.ch</a></li>
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
    <section id="content" class="digest">
      <section>
<% years.forEach(function(year) { %>
        <h2 id="<%= year %>"><%= year %></h2>
        <ul>
<% byYear[year].forEach(function(doc) { %>
          <li><%- getDate(doc.created) %> – <a href="/<%= doc._id %>"><%- doc.title %></a></li>
<% }); %>
        </ul>
<% }); %>
      </section>
      <footer class="meta">
        <p>
          <a href="/tag/" class="button">Tags</a> ·
          <a href="/feed.xml" class="feed button">Article feed</a>
        </p>
      </footer>
    </section>
    <footer id="about">
      <p>© 2008-<%= __docs[0].created.getFullYear() %> – <%= siteAuthor %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
