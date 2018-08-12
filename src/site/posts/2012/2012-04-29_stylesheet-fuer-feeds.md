---
title: Stylesheet für Atom-Feeds
alias: stylesheet-fuer-feeds.md

author: Paul Vorbach
created-at: 2012-04-29

tags: [ deutsch, dev, xml, xsl ]
locale: de-DE

template: post-milten.ftl
properties:
  teaser:
    imageUrl: milten-xsl.png
...

Seit gerade eben hat der [Artikel-Feed](/log/feed.xml) hier ein eigenes
Stylesheet. Wie das funktioniert kann man bei
[24ways.org](http://24ways.org/2006/beautiful-xml-with-xsl) nachlesen.

Für die meisten wird das vermutlich zu viel Aufwand sein. Ich fand jedoch
interessant, dass das von den meisten Browsern unterstützt wird. Bei Feeds wird
das Stylesheet aber nur in Webkit-Browsern standardmäßig angezeigt. Schade
eigentlich.

Also hab ich das mal ausprobiert. Hier das
[vorläufige XSL-Stylesheet](/res/milten.feed.xsl):

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="utf-8"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/atom:feed"/>
  </xsl:template>
  <xsl:template match="/atom:feed">
    <html>
      <head>
        <title><xsl:value-of select="atom:title"/> (Feed)</title>
        <link rel="stylesheet" href="/res/milten.css"/>
      </head>
      <body>
        <header id="site">
          <a href="/"><xsl:value-of select="atom:author"/></a>
        </header>
        <nav id="nav">
          <ul id="branches">
            <li class="active"><a href="/log/">Blog</a></li>
            <li><a href="/info/">Info</a></li>
          </ul>
          <ol id="path">
            <li><a href="/">vorb.de</a></li>
            <li><a href="/log/">log</a></li>
            <li>feed.xml</li>
          </ol>
          <ol id="access">
            <li><a href="#top" title="To the top" id="back">↑</a></li>
            <li><a href="#nav">Navigation</a></li>
            <li><a href="#content">Content</a></li>
          </ol>
        </nav>
        <section id="content" class="digest">
          <h1>Article Feed</h1>
          <form>
            Add the following link to your favorite feed reader:
            <input type="text"
              size="{string-length(atom:link[attribute::rel='self']/@href)}"
              value="{atom:link[attribute::rel='self']/@href}"
              onclick="select()"/>
          </form>
          <xsl:apply-templates select="atom:entry"/>
        </section>
        <footer id="about">
          <p>© 2012 – Paul Vorbach.
            <a href="/info/contact.html">Contact</a>.</p>
        </footer>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:entry">
    <article>
      <header>
        <h2>
          <a href="{atom:link/@href}"><xsl:value-of select="atom:title"/></a>
        </h2>
        <p class="meta">
          <xsl:value-of select="substring-before(atom:updated,'T')"/>
        </p>
      </header>
      <xsl:value-of select="atom:content" disable-output-escaping="yes"/>
      <footer class="meta">
        <p>Author: <a href="{atom:author/atom:uri}"><xsl:value-of
              select="atom:author/atom:name"/></a></p>
        <xsl:if test="atom:category">
         <p>Tags:</p>
         <ul class="tags"><xsl:apply-templates select="atom:category"/></ul>
        </xsl:if>
      </footer>
    </article>
  </xsl:template>
  <xsl:template match="atom:category">
    <li><a href="http://vorb.de/log/tag/{@term}.html"><xsl:value-of
      select="@term"/></a></li>
  </xsl:template>
</xsl:stylesheet>
~~~
