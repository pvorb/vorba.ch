<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="utf-8"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/atom:feed"/>
  </xsl:template>
  <xsl:template match="/atom:feed">
    <html lang="en">
      <head>
        <title><xsl:value-of select="atom:title"/> (Feed)</title>
        <link rel="stylesheet" href="/res/diego.css"/>
      </head>
      <body>
        <nav id="nav">
          <ol id="path">
            <li><a href="/">vorba.ch</a></li>
            <li>feed.xml</li>
          </ol>
          <ol id="access">
            <li><a href="#top" title="To the top" id="back"
              accesskey="t">↑</a></li>
            <li><a href="#nav">Navigation</a></li>
            <li><a href="#content">Content</a></li>
          </ol>
          <form id="search" action="/search.html" method="GET">
            <input type="search" name="s" accesskey="s" placeholder="Search"/>
          </form>
        </nav>
        <section id="content" class="digest">
          <header class="meta">
          <h1>Article Feed</h1>
          <form>
            Add the following link to your favorite feed reader:
            <input type="text"
              size="{string-length(atom:link[attribute::rel='self']/@href)}"
              value="{atom:link[attribute::rel='self']/@href}"
              onclick="select()"/>
          </form>
          </header>
          <xsl:apply-templates select="atom:entry"/>
        </section>
        <footer id="about">
          <p>© 2012-2013 – Paul Vorbach.
            <a href="http://paul.vorba.ch/">Contact</a>.</p>
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
      <section>
        <xsl:value-of select="atom:content" disable-output-escaping="yes"/>
      </section>
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
