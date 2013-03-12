<!DOCTYPE html>
<html lang="en" id="top">
  <head>
    <meta charset="utf-8">
    <title>Search<%= locals.query ? ': '+query : ''
      %> | Paul Vorbach</title>
    <link rel="stylesheet" href="/res/milten.css">
    <link rel="icon" href="/favicon.ico">
    <meta name="author" content="Paul Vorbach">
  </head>
  <body>
    <header id="site">
      <a href="/">Paul Vorbach</a>
    </header>
    <nav id="nav">
      <ul id="branches">
        <li><a href="/log/">/log</a>
        <li><a href="/info/">/info</a>
      </ul>
      <ol id="path"><%
  var path = '/search.html';
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
        <li><a href="#top" title="To the top" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1>Search</h1>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <img src="<%= teaser %>">
        </figure>
<% } %>
      </header>
      <form id="search" action="/search.html" method="get">
        <input type="text" name="s"<%- locals.query ? ' value="'+query+'"' : ''
          %>> <input type="submit" value="Search">
      </form>
      <section>
<% if (locals.results) { %>
        <ul>
<% locals.results.forEach(function (result) {
  result = result.replace(/^\./, ''); %>
          <li><a href="<%- result %>"><%- result %></a>
<% }); %>
        <ul>
<% } %>
      </section>
    </article>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – Paul Vorbach.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
