<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="de">
	<title><%= siteTitle %></title>
	<subtitle><%= siteSubtitle %></subtitle>
	<updated><%= (new Date()).toISOString() %></updated>
	<id>http://vorb.de/log/feed.xml</id>
	<author>
		<name><%= author %></name>
<% if (locals.authorLink) { %>    <uri><%= authorLink %></uri><% } %>
	</author>
	<rights>© 2008-2011 Paul Vorbach</rights>
	<link href="http://vorb.de/log/"/>
	<link rel="self" href="http://vorb.de/log/feed.xml"/>
	<category term="computer"/>
	<category term="web"/>
	<category term="development"/>
	<icon>http://vorb.de/favicon.ico</icon>
<% __docs.forEach(function(doc) { %>
	<entry>
		<title><%= doc.title %></title>
		<link href="http://vorb.de/log/<%= doc._id %>"/>
		<id>http://vorb.de/log/<%= doc._id %></id>
		<updated><%= doc.date.toISOString() %></updated>
    <content type="html">
<% esc(__docs.__content) %>
    </content>
	</entry>
<% }); %>
</feed>
