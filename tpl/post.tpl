<!DOCTYPE html>
<html lang="de">
	<head>
		<meta charset="utf-8">
		<title><%= title %> | <%= siteTitle %></title>
		<link rel="stylesheet" href="/res/<%= stylesheet %>">
		<style>/*#content > h1 { font-size: 1.5em; }*/</style>
		<link rel="icon" href="/favicon.ico">
		<meta name="author" content="<%= author %>">
<% if (tags != undefined) { %>
		<meta name="keywords" content="<%= tags.join(", ") %>">
<% } %>
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
		<article id="content">
			<h1><%= title %></h1>
			<p class="meta">von <%= author %></p>
<%= __content %>
		</article>
		<footer id="about">
			<p>© <%= date.getYear() %> – <%= author %>
				<a href="/info/contact.html">Kontakt</a>.</p>
		</footer>
	</body>
</html>
