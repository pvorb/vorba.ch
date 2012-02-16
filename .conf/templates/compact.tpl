<!DOCTYPE html>
<html lang="<%= language %>">
  <head>
    <meta charset="utf-8">
    <title><%- siteTitle %></title>
    <link rel="stylesheet" href="/res/compact.css">
    <link rel="icon" href="/favicon.ico">
    <meta name="author" content="<%= author %>">
  </head>
  <body>
    <header id="top"><a href="/"><%- siteTitle %></a></header>
    <nav id="nav">
      <ul id="branches">
        <li><a href="/log/">Blog</a>
        <li class="active"><a href="/info/">Info</a>
      </ul>
      <ol id="path">
        <li>Home
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <article id="content">
      <header>
        <h1><%- title %></h1>
      </header>
      <section>
        <%- __content %>
      </section>
    </article>
    </section>
    <footer id="about">
      <p>© 2008-<%- (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
