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
        <li><a href="/log/" accesskey="l">Blog</a>
        <li><a href="/info/" accesskey="i">Info</a>
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
        <p><strong>Hi, my name is
        <a href="http://paul.vorba.ch/">Paul Vorbach</a>.</strong>
        I live near <strong>Würzburg, Germany</strong>, where I study
        <strong><a href="//www.informatik.uni-wuerzburg.de/">Computer Science</a></strong>.
        <p>I’m interested in <strong>web development</strong> and
        <strong>web design</strong>. I spend much of my time on
        <strong>server-side</strong> web development, mainly in
        <strong><a href="//nodejs.org/" title="Node.js">JavaScript</a></strong>,
        <strong><a href="//scala-lang.org/">Scala</a></strong> and
        <strong><a href="//www.oracle.com/technetwork/java/index.html">Java</a></strong>.
        I have also worked a lot with PHP, Delphi as well as some Python, C++
        and C#.</p>
        <p>This web site contains information on what I do. You can also follow
        me on <strong><a href="https://github.com/pvorb"><img
        src="/res/github-icon.png"> Github</a></strong>. Almost all of my
        personal projects are hosted there. Most of them are
        <a href="/license/mit.html">MIT licensed</a>.</p>
      </article>
      <section class="log">
        <p>You might want to visit the <a href="/log/">weblog</a>. Most of the
        articles in the blog are <a href="/log/tag/deutsch.html">German</a>,
        although there may be one or the other
        <a href="/log/tag/english.html">English article</a>.</p>
        <p>Recent article:</p>
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
