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
<html lang="en">
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
    <meta name="keywords" content="development, web, node.js,
      scala, github, Paul Vorbach, Paul Rafael Vorbach, pvorb, pvorbach">
    <style>#top { font-size: 3em }</style>
  </head>
  <body>
    <header id="top"><%- siteTitle %></header>
    <nav id="nav">
      <ul id="branches">
        <li><a href="/log/">Blog</a>
        <li><a href="/info/">Info</a>
      </ul>
      <ol id="path">
        <li>vorb.de
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <section id="content" class="digest">
      <article class="intro">
        <header>
          <figure class="teaser">
            <img src="/paul.png">
          </figure>
        </header>
        <p><strong>Hi, my name is Paul Vorbach.</strong> I live near
        <strong>Würzburg, Germany</strong>, where I study
        <strong><a href="http://www.informatik.uni-wuerzburg.de/">Computer Science</a></strong>.
        <p>I’m interested in <strong>web development</strong> and
        <strong>web design</strong>. Recently, I spend much
        of my time on <strong>server-side</strong> web development, mainly in
        <strong><a href="http://nodejs.org/" title="Node.js">JavaScript</a></strong>,
        <strong><a href="http://scala-lang.org/">Scala</a></strong> and
        <strong><a href="http://www.oracle.com/technetwork/java/index.html">Java</a></strong>.
        I have also worked a lot with PHP, Delphi, some Python, C++ and C#.</p>
        <p>This web site contains information on what I do. You can also</p>
        <ul>
          <li><p>follow me on <strong><img src="/res/github-icon.png">
            <a href="https://github.com/pvorb">Github</a></strong>. Almost all
            of my personal projects are hosted on this web site. The majority of
            them is licensed under a <a href="/license/mit.html">MIT
            license</a>.</p>
          <li><p>follow me on <strong><img src="/res/twitter-icon.png">
            <a href="https://twitter.com/pvorb">Twitter</a></strong>, where I irregularly
            post things that I find newsworthy.</p>
        </ul>
        <p>You won’t find me on Facebook or Google+, because I don’t have
        accounts there.</p>
      </article>
      <section class="log">
        <p>The most interesting part of this web site might be the
        <a href="/log/">weblog</a>. Most of the articles in the blog are
        <a href="/log/tag/deutsch.html">in German</a>, although there may be one
        or the other <a href="/log/tag/english.html">English article</a>.</p>
        <p>This is the most recent article:</p>
<% __docs.forEach(function(doc) { %>
        <article lang="<%= doc.language %>">
          <header>
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
            <h2><a href="/<%= doc._id %>"><%= doc.title %></a></h2>
            <p class="meta"><%- getDate(doc.created) %></p>
          </header>
          <section>
            <%- indentHeadings(doc.__content) %>
          </section>
        </article>
<% }); %>
        <p><a href="/log/">More articles »</a></p>
      </section>
    </section>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
