<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" doctype-public="" doctype-system=""/>

  <!-- Copy HTML -->
  <xsl:template match="figure | p">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- Begin Document -->
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="/style.css"/>
        <!-- KaTeX renderer -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.css" integrity="sha384-GvrOXuhMATgEsSwCs4smul74iXGOixntILdUW9XmUC6+HX0sLNAK3q71HotJqlAn" crossorigin="anonymous"/>
        <script defer="" src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.js" integrity="sha384-cpW21h6RZv/phavutF+AuVYrr+dA8xD9zs6FwLpaCct6O9ctzYFfFr4dgmgccOTx" crossorigin="anonymous"></script>
        <script defer="" src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/contrib/auto-render.min.js" integrity="sha384-+VBxd3r6XgURycqtZ117nYw44OOcIax56Z4dCRWbxyPt0Koah1uHoK0o4+/RRE05" crossorigin="anonymous"
        onload="renderMathInElement(document.body);"></script>
        <!-- Meta information -->
        <title><xsl:value-of select="/article/title"/></title>
      </head>
      <body>
        <div class="side">
          <a id="bc-" href="/">Home</a>
          <a id="bc-research" href="/research">Research</a>
          <a id="bc-music" href="/music" >Music</a>
          <!-- <a id="bc-gallery" href="/gallery">Gallery</a> -->
          <!-- <a id="bc-contact" href="/contact">Contact</a> -->
          <script>
            var breadcrumb = document.getElementById("bc-" + document.location.pathname.split("/")[1]);
            breadcrumb.classList.add("current");
          </script>
        </div>
        <article>
          <span class="category"><xsl:value-of select="/article/@category"/>.</span>
          <xsl:apply-templates select="/article/section"/>
        </article>
        <div class="side empty"/>
      </body>
    </html>
  </xsl:template>

  <!-- Sections -->
  <xsl:template match="section">
    <section>
      <h1><xsl:apply-templates mode="addr" select="."/></h1>
      <xsl:apply-templates mode="meta" select=".[./meta]"/>
      <xsl:apply-templates mode="body" select=".[./body]"/>
    </section>
  </xsl:template>

  <xsl:template mode="addr" match="section[./addr]">
    <a href="{./addr}"><xsl:value-of select="./title"/></a>
  </xsl:template>

  <xsl:template mode="addr" match="section[not(./addr)]">
    <xsl:value-of select="./title"/>
  </xsl:template>

  <!-- Meta lists -->
  <xsl:template mode="meta" match="section[./meta]">
    <ul class="metadata">
      <xsl:for-each select="meta">
      <li>
        <xsl:apply-templates select="."/>
      </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="meta[@href]">
    <a href="{@href}"><xsl:copy-of select="./node()"/></a>
  </xsl:template>

  <xsl:template match="meta[not(@href)]">
    <xsl:copy-of select="./node()"/>
  </xsl:template>

  <!-- Summaries -->
  <xsl:template mode="body" match="section[./body]">
    <summary>
      <xsl:apply-templates select="body"/>
    </summary>
  </xsl:template>
</xsl:stylesheet>
