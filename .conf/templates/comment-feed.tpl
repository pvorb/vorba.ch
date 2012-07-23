<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="/res/milten.feed.xsl"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="de">
  <title>vorb.de: Comments</title>
  <subtitle>Comments and Pingbacks on vorb.de</subtitle>
  <updated><%- (new Date()).toISOString() %></updated>
  <id>http://vorb.de/log/comment-feed.xml</id>
  <author>
    <name>Paul Vorbach</name>
  </author>
  <rights>© 2008-<%= (new Date()).getFullYear() %> Paul Vorbach</rights>
  <link href="https://vorb.de/log/"/>
  <link rel="self" href="https://vorb.de/log/comment-feed.xml"/>
  <category term="computer"/>
  <category term="web"/>
  <category term="development"/>
  <icon>https://vorb.de/favicon.ico</icon>
<% __comments.forEach(function(comment) { %>
  <entry>
    <title>Comment on <%- comment.res %> by <%- comment.author %></title>
    <link href="https://vorb.de<%= comment.res %>#<%= comment._id %>"/>
    <id>http://vorb.de/log/comments?id=<%- comment._id %></id>
    <updated><%= comment.modified.toISOString() %></updated>
    <author>
      <name><%= comment.author %></name><% if (comment.website) { %>
      <uri><%= comment.website %></uri><% } %>
    </author>
    <content type="html">
      <%- esc(comment.message, { uri: "https://vorb.de"+comment.res }) %>
    </content>
  </entry>
<% }); %>
</feed>
