<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="de">
  <title><%= siteTitle %></title>
  <subtitle><%= siteSubtitle %></subtitle>
  <updated><%= (new Date()).toISOString() %></updated>
  <id><%- id %></id>
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
    <link href="http://vorb.de<%= doc._id %>"/>
    <id>http://vorb.de<%= doc._id %></id>
    <updated><%= doc.modified.toISOString() %></updated>
    <author>
      <name><%= doc.author %></name><% if (doc.authorEmail) { %>
      <email><%= doc.authorEmail %></email><% } if (doc.authorUri) { %>
      <uri><%= doc.authorUri %></uri><% } %>
    </author>
    <content type="html">
<% if (doc.screenshot) { %>

<% } else if (doc.teaser) { %>
      &lt;p&gt;&lt;img src="http://vorb.de<%= doc._id.split('/').slice(0, -1).join('/') + '/' + doc.teaser %>"&gt;&lt;/p&gt;
<% } %>
      <%- esc(doc.__content, { uri: "http://vorb.de"+doc._id }) %>
    </content>
<% doc.tags.forEach(function(tag) { %>
    <category term="<%= tag %>"/>
<% }); %>
  </entry>
<% }); %>
</feed>
