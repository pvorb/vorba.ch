<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><%- siteTitle %></title>
    <link rel="stylesheet" href="/res/compact.css">
    <link rel="icon" href="/favicon.ico">
    <meta name="author" content="<%= author %>">
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
        <li>Home
      </ol>
      <ol id="access">
        <li><a href="#top" title="To the top" id="back">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
    </nav>
    <section id="content">
      <article class="intro">
        <figure class="teaser">
          <img src="logo.png">
        </figure>
        <h1>Hi,</h1>
        <p>my name is Paul. I live near Würzburg, Germany,
        where I’m currently working on my bachelor’s degree in
        <a href="http://www.informatik.uni-wuerzburg.de/">Computer Science</a>.
        <p>I’m interested in web development and design. Recently, I spend much
        of my time on server-side development with
        <a href="http://nodejs.org/" title="Node.js">JavaScript</a>,
        <a href="http://scala-lang.org/">Scala</a> and
        <a href="http://www.oracle.com/technetwork/java/index.html">Java</a>.
        <p>You can also</p>
        <ul>
          <li><p>follow me on <img src="/res/github-icon.png">
            <a href="https://github.com/pvorb">Github</a>. Almost all of my
            personal projects are hosted on this website. The majority of them
            is licensed under a <a href="/license/mit.html">MIT license</a>.</p>
          <li><p>follow me on <img src="/res/twitter-icon.png">
            <a href="https://twitter.com/pvorb">Twitter</a>, where I irregularly
            post things that I find newsworthy.</p>
        </ul>
      </article>
      <section class="blog">
        <h1>Blog</h1>
        <p>Most of the articles in the <a href="/log/">blog</a> are in German,
        though there may be one or the other English article. Latest
        article:</p><%
__docs.forEach(function(doc) { %>
        <article lang="<%= doc.language %>">
          <header>
            <h2><a href="<%= doc._id %>"><%= doc.title %></a></h2>
<%
function pad(n) { return n<10 ? '0'+n : n; }
var datestr = doc.created.getFullYear()
  + '-'+pad(doc.created.getMonth()+1)+'-'+pad(doc.created.getDate());
%>
            <p class="meta"><%= datestr %></meta>
<%
if (doc.teaser) {
  var teaser = doc._id.split('/').slice(0, -1);
  teaser.push(doc.teaser);
  teaser = teaser.join('/');
%>
            <figure class="teaser">
              <img src="<%= teaser %>">
            </figure>
<%
}

function indentHeadings(text) {
  return text.replace(/h5>/g, 'h6>').replace(/h4>/g, 'h5>')
      .replace(/h3>/g, 'h4>').replace(/h2>/g, 'h3>').replace(/h1>/g, 'h2>');
}
%>
          </header>
          <section>
            <%- indentHeadings(doc.__content) %>
          </section>
        </article>
<% }); %>
      </section>
    </section>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="/info/contact.html">Contact</a>.</p>
    </footer>
  </body>
</html>
