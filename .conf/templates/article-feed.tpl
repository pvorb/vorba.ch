<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="/res/milten.feed.xsl"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="de">
  <title>vorb.de: Articles</title>
  <subtitle>vorb opposes recursive backronyms</subtitle>
  <updated><%= (new Date()).toISOString() %></updated>
  <id><%- id %></id>
  <author>
    <name><%= author %></name><%
if (locals.authorLink) { %>
    <uri><%= authorLink %></uri><% } %>
  </author>
  <rights>© 2008-<%- (new Date()).getFullYear() %> Paul Vorbach</rights>
  <link href="https://vorb.de/log/"/>
  <link rel="self" href="https://vorb.de/log/feed.xml"/>
  <category term="computer"/>
  <category term="web"/>
  <category term="development"/>
  <icon>https://vorb.de/favicon.ico</icon>
<%
__docs = __docs.reverse();
__docs.forEach(function(doc) { %>
  <entry>
    <title><%= doc.title %></title>
    <link href="https://vorb.de/<%= doc._id %>"/>
    <id>http://vorb.de/<%- doc._id %></id>
    <updated><%= doc.modified.toISOString() %></updated>
    <author>
      <name><%= doc.author %></name><% if (doc.authorEmail) { %>
      <email><%= doc.authorEmail %></email><% } if (doc.authorUri) { %>
      <uri><%= doc.authorUri %></uri><% } %>
    </author>
    <content type="html">
<% if (doc.screenshot) { %>

<% } else if (doc.teaser) {
  var teaser = doc._id.split('/').slice(0, -1);
  if (typeof doc.teaser == 'string')
    teaser.push(doc.teaser);
  else if (typeof doc.teaser == 'object')
    teaser.push(doc.teaser.img);
  teaser = teaser.join('/');
%>
      &lt;p&gt;&lt;img src="http://vorb.de/<%= teaser %>"&gt;&lt;/p&gt;
<% } %>
      <%- esc(doc.__content, { uri: "http://vorb.de/"+doc._id }) %>
    </content>
<% doc.tags.forEach(function(tag) { %>
    <category term="<%= tag %>"/>
<% }); %>
  </entry>
<% }); %>
</feed>
