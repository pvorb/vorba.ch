<!DOCTYPE html>
<html lang="de">
	<head>
		<meta charset="utf-8">
		<title><%= title %> | <%= siteTitle %></title>
		<link rel="stylesheet" href="/res/milten.css">
		<link rel="icon" href="/favicon.ico">
		<meta name="author" content="<%= author %>">
	</head>
	<body>
		<header id="site">
			<a href="/"><%= siteTitle %></a>
		</header>
		<nav id="nav">
			<ul id="branches">
				<li class="active"><a href="/log/">Blog</a>
				<li><a href="/info/">Info</a>
			</ul>
      <ol id="path">
<%
var path = ('/log').split('/'),
    pathref = '/';

for (var i = 1; i < path.length; i++) {
  if (i < path.length - 1)
    pathref += path[i] + '/';
  else
    pathref += path[i];
%>
        <li><%
  if (i < path.length - 1) {
    %><a href="<%- pathref %>"><%
  }
  %><%= path[i] == 'log' ? 'blog' : path[i] %><%
  if (i < path.length - 1) {
    %></a><%
  }
}
%>
      </ol>
			<ol id="access">
				<li><a href="#top" title="Zum Anfang" id="back">↑</a>
				<li><a href="#nav">Navigation</a>
				<li><a href="#content">Inhalt</a>
			</ol>
		</nav>
		<section id="content" class="digest">
<% __docs.forEach(function(doc) { %>
			<article>
        <header>
				  <h1><a href="<%= doc._id %>"><%= doc.title %></a></h1>
<%
var datestr = doc.date.getDate()+'.'+doc.date.getMonth()+'.'+doc.date.getFullYear();
%>
          <time><%= datestr %></time>
<%
if (doc.teaser) {
  var teaser = doc._id.split('/').slice(0, -1);
  teaser.push(doc.teaser);
  teaser = teaser.join('/');
%>
          <aside>
            <figure class="teaser">
              <img src="<%= teaser %>">
            </figure>
          </aside>
<%
}
%>
				</header>
				<section>
				  <%- doc.__content %>
				</section>
			</article>
<% }); %>
      <footer class="meta">
        <p><a href="tag/">Kategorien</a>. <a href="feed.xml">Feed</a>.</p>
      </footer>
		</section>
		<footer id="about">
			<p>© 2008-<%= __docs[0].date.getFullYear() %> – <%= siteAuthor %>.
				<a href="/info/contact.html">Kontakt</a>.</p>
		</footer>
	</body>
</html>
