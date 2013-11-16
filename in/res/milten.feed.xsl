<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="utf-8"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/atom:feed"/>
  </xsl:template>
  <xsl:template match="/atom:feed">
    <html lang="en" id="top">
      <head>
        <title><xsl:value-of select="atom:title"/> (Feed)</title>
        <link rel="stylesheet" href="/res/milten.css"/>
      </head>
      <body>
        <header id="site">
          <a href="/" accesskey="h"><xsl:value-of select="atom:author"/></a>
        </header>
        <nav id="nav">
          <ul id="branches">
            <li class="active"><a href="/log/" accesskey="l">/log</a></li>
            <li><a href="/info/" accesskey="i">/info</a></li>
          </ul>
          <ol id="path">
            <li><a href="/">vorb.de</a></li>
            <li><a href="/log/">log</a></li>
            <li>feed.xml</li>
          </ol>
          <ol id="access">
            <li><a href="#top" title="To the top" id="back"
              accesskey="t">↑</a></li>
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
        <aside id="extra">
          <form id="sf" action="/search.html" method="GET">
            <input type="search" name="s" accesskey="s" placeholder="Search"/>
          </form>
        </aside>
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
