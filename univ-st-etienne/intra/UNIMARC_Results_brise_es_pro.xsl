<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:items="http://www.koha.org/items" xmlns:marc="http://www.loc.gov/MARC21/slim" version="1.0" exclude-result-prefixes="marc items">
  <xsl:import href="UNIMARC_Results_utils_brise_es_pro.xsl" />
  <!-- pour visu autonome  
  <xsl:output method="html" doctype-public="-//W3C/DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/transitional.dtd" />    
      <xsl:template match="/">
        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
            <link href="opac.css" rel="stylesheet" type="text/css" />
          </head>
          <body>
           <xsl:apply-templates />
          </body>
        </html>
      </xsl:template>
-->
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
  <!-- inutile en prof
<xsl:key name="item-by-status" match="items:item" use="items:status"/>
<xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>
<xsl:key name="item-by-status-branch-callnumber" match="items:item" use="concat(items:status, ' ', items:homebranch, ' ',items:itemcallnumber)"/> 
-->
  <!-- 
<xsl:template match="/">

<xsl:apply-templates/>
</xsl:template>
-->
  <xsl:template match="marc:record">
    <xsl:variable name="leader" select="marc:leader" />
    <xsl:variable name="leader6" select="substring($leader,7,1)" />
    <xsl:variable name="leader7" select="substring($leader,8,1)" />
    <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='9']" />
    <xsl:variable name="isbn" select="marc:datafield[@tag=010]/marc:subfield[@code='a']" />
    <span class="results_icon">
      <xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
        <xsl:choose>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Livre imprimé'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/book_b.gif" alt="book" title="book" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Livre numérique'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/binary_b.gif" alt="electronic ressource" title="electronic ressource" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Revue imprimée'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/periodical_b.gif" alt="periodical" title="periodical" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Thèse, mémoire, rapport'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/thesis_b.gif" alt="thesis, report" title="thesis, report" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Carte'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/map_b.gif" alt="map" title="map" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Partition'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/score_b.gif" alt="score" title="score" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Article'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/article_b.gif" alt="article" title="article" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Images, son, multisupport'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/sound_b.gif" alt="Images, son, multisupport" title="Images, son, multisupport" />
          </xsl:when>
          <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Support informatique'">
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/binary_b.gif" alt="electronic ressource" title="electronic ressource" />
          </xsl:when>
          <xsl:otherwise>
            <img src="/intranet-tmpl/prog/img/itemtypeimg/sudoc/unknown_b.gif" alt="other" title="other" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </span>
    <span class="results_titre">
      <xsl:for-each select="marc:datafield[@tag=200]">
        <xsl:for-each select="marc:subfield">
          <xsl:choose>
            <xsl:when test="@code='a'">
              <xsl:if test="preceding-sibling::marc:subfield[@code='a']">
                <xsl:text>;</xsl:text>
              </xsl:if>
              <a>
                <xsl:attribute name="href">/cgi-bin/koha/catalogue/detail.pl?biblionumber=<xsl:value-of select="$biblionumber" /></xsl:attribute>
                <xsl:variable name="title" select="." />
                <xsl:variable name="ntitle" select="translate($title, '˜&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')" />
                <xsl:value-of select="$ntitle" />
              </a>
              <!-- <xsl:if test="following-sibling::marc:subfield[@code='a']"><xsl:text> ; </xsl:text></xsl:if> -->
              <xsl:if test="following-sibling::*[1][@code='a']">
                <xsl:text>;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:when test="@code='c'">
              <xsl:text>;</xsl:text>
              <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
              <xsl:value-of select="." />
              <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@code='d'">
              <!-- titre parallele -->
              <xsl:text>=</xsl:text>
              <xsl:value-of select="." />
            </xsl:when>
            <xsl:when test="@code='h'">
              <!--tomaison apres mention de premiere mention de resp-->
              <xsl:choose>
                <xsl:when test="(preceding-sibling::*[1][@code='f'] or preceding-sibling::*[1][@code='g'])">
                  <xsl:text disable-output-escaping="yes">. &lt;b&gt;</xsl:text>
                  <xsl:value-of select="." />
                  <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text disable-output-escaping="yes">, &lt;b&gt;</xsl:text>
                  <xsl:value-of select="." />
                  <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="@code='i'">
              <!-- titre de partie -->
              <xsl:choose>
                <xsl:when test="@code='h'">
                  <!--tomaison-->
                  <xsl:text>,</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>.</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
              <xsl:value-of select="." />
              <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@code='e'">
              <!-- sous titre -->
              <xsl:text> : </xsl:text>
              <xsl:value-of select="." />
            </xsl:when>
            <xsl:when test="@code='f'">
              <!-- responsabilite ppale -->
              <xsl:text> / </xsl:text>
              <xsl:value-of select="." />
            </xsl:when>
            <!--  responsabilte secondaire, pas dans liste resultat
        <xsl:when test="@code='g'">
            <xsl:text> ; </xsl:text>
            <xsl:value-of select="."/>
        </xsl:when>
        -->
          </xsl:choose>
        </xsl:for-each>
      </xsl:for-each>
    </span>
    <span class="result_summary">
      <!-- <xsl:call-template name="tag_4xx" /> -->
      <xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a' or @code='b']">
        <xsl:call-template name="tag_205" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='c' or @code='d'] and marc:datafield[@tag=099]/marc:subfield[@code='t']!='Article'">
        <xsl:call-template name="tag_210" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=225]/marc:subfield[@code='a']">
        <xsl:call-template name="tag_225" />
      </xsl:if>
      <!-- <xsl:call-template name="tag_215" /> -->
      <xsl:if test="marc:datafield[@tag=463]">
        <xsl:call-template name="tag_463" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=930]">
        <xsl:call-template name="tag_930" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=940]">
        <xsl:call-template name="tag_940" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=856]">
        <xsl:call-template name="tag_856" />
      </xsl:if>
    </span>
  </xsl:template>
</xsl:stylesheet>
