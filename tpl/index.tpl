<!DOCTYPE html>
<html lang="de">
	<head>
		<meta charset="utf-8">
		<title><%= title %> | <%= siteTitle %></title>
		<link rel="stylesheet" href="/res/compact.css">
		<style>#content > h1 { font-size: 1.5em; }</style>
		<link rel="icon" href="/favicon.ico">
		<meta name="author" content="<%= author %>">
	</head>
	<body>
		<header id="top">
			<a href="/"><%= siteTitle %></a>
		</header>
		<nav id="nav">
			<ul id="branches">
				<li class="active"><a href="/log/">Blog</a>
				<li><a href="/info/">Info</a>
			</ul>
			<ol id="access">
				<li><a href="#top" title="Anfang" id="back">↑</a>
				<li><a href="#nav">Navigation</a>
				<li><a href="#content">Inhalt</a>
			</ol>
		</nav>
		<section id="content">
			<h1>Blog</h1>
<% __docs.forEach(function(doc) { %>
			<article>
				<h1><%= doc.title %></h1>
				<%- doc.__content %>
			</article>
<% }); %> 
		</section>
		<footer id="about">
			<p>© 2008-<%= __docs[0].date.getFullYear() %> – <%= author %>
				<a href="/info/contact.html">Kontakt</a>.</p>
		</footer>
	</body>
</html>
