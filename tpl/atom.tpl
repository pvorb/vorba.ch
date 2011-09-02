<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="de">
	<title><%= siteTitle %></title>
	<subtitle><%= siteSubtitle %></subtitle>
	<updated><%= (new Date()).toISOString() %></updated>
	<id>http://vorb.de/log/feed.xml</id>
	<author>
		<name><%= author %></name>
		<uri><%= authorLink %></uri>
	</author>
	<rights>© 2008-2011 Paul Vorbach</rights>
	<link href="http://vorb.de/log/"/>
	<link rel="self" href="http://vorb.de/log/feed.xml"/>
	<category term="computer"/>
	<category term="web"/>
	<category term="development"/>
	<icon>http://vorb.de/favicon.ico</icon>
<% for (var doc in __docs) {
	<entry>
		<title><%= doc.title %></title>
		<link href="http://vorb.de/log/<%= doc.__path %>"/>
		<id>http://vorb.de/log/<%= doc.__path %></id>
		<updated><%= doc.date.toISOString() %></updated>
		<summary>
			
		</summary>
	</entry>
<% } %>
</feed>
