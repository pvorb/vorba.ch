<%
function pad(n) { return (n<10)?'0'+n:n; }
function getDate(d) {
  return d.getFullYear()+'-'+pad(d.getMonth()+1)+'-'+pad(d.getDate());
}
function indentHeadings(text) {
  return text.replace(/h5>/g, 'h6>').replace(/h4>/g, 'h5>')
      .replace(/h3>/g, 'h4>').replace(/h2>/g, 'h3>').replace(/h1>/g, 'h2>');
}
%><!DOCTYPE html>
<html lang="en" id="top">
  <head>
    <meta charset="utf-8">
    <title><%- siteTitle %></title>
    <link rel="stylesheet" href="/res/milten.css">
    <link rel="icon" href="/favicon.ico">
    <link rel="alternate" type="application/atom+xml" href="/log/feed.xml"
      title="Article feed">
    <link rel="alternate" type="application/atom+xml"
      href="/log/comment-feed.xml" title="Comment feed">
    <meta name="author" content="<%= author %>">
    <meta name="keywords" content="development, web, node.js, scala, github">
    <meta name="description" content="Personal website of Paul Vorbach.
      Scala, Node.js and Java development. Work and personal weblog.">
  </head>
  <body>
    <header id="site"><%- siteTitle %></header>
    <nav id="nav">
      <ul id="branches">
        <li><a href="/log/" accesskey="l">/log</a>
        <li><a href="/info/" accesskey="i">/info</a>
      </ul>
      <ol id="path">
        <li>vorb.de
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <section id="content" class="digest">
      <article class="intro">
        <p>Hi, my name is <a href="http://paul.vorba.ch/">Paul Vorbach</a>.
        <p>This is my blog, where I occasionally write about
        <a href="/log/tag/dev.html">web development</a> in
        <a href="/log/tag/javascript.html">JavaScript</a> (including
        <a href="/log/tag/nodejs.html">Node.js</a>),
        <a href="/log/tag/scala.html">Scala</a> and
        <a href="/log/tag/java.html">Java</a>. I also have worked a lot with
        <a href="/log/tag/php.html">PHP</a> and
        <a href="/log/tag/pascal.html">Delphi</a> and
        ActionScript (Flash) as well as some
        <a href="/log/tag/python.html">Python</a>,
        <a href="/log/tag/c.html">C</a>,
        <a href="/log/tag/c++.html">C++</a>,
        <a href="/log/tag/csharp.html">C#</a> and
        <a href="/log/tag/haskell.html">Haskell</a>.</p>
        <p>Most of the articles in the blog are written in
        <a href="/log/tag/deutsch.html">German</a>, but there are also some
        <a href="/log/tag/english.html">English articles</a>.</p>
      </article>
      <section class="log">
<% __docs.forEach(function(doc) { %>
        <article lang="<%= doc.language %>">
          <header>
<%
var lines = doc.__content.split('</p>', 3);
doc.__content = lines.join('</p>');
%>
            <h2><a href="/<%= doc._id %>"><%= doc.title %></a></h2>
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
              <a href="/<%= doc._id %>"><img src="<%= teaser %>"></a>
            </figure>
<% } %>
          </header>
          <section>
            <%- indentHeadings(doc.__content) %>
          </section>
          <footer>
            <p><a href="/<%= doc._id %>">Read on »</a></p>
          </footer>
        </article>
<% }); %>
        <footer>
          <p><a href="/log/">More articles »</a></p>
        </footer>
      </section>
    </section>
    <aside id="extra">
      <form id="sf" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Search">
      </form>
    </aside>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
