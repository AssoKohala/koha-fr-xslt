<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:items="http://www.koha.org/items" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="marc items">
  <xsl:import href="UNIMARC_Detail_utils_brise_es.xsl"/>
  
<!-- a enlever en prod a utiliser en local   
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
<!-- a remettre en prod a enlever en local -->
<xsl:output method = "xml" indent="yes" omit-xml-declaration = "yes" />   
  
<!-- 3 lignes a remettre en prod a enlever en local -->
   <xsl:template match="/">
   <xsl:apply-templates/>
   </xsl:template>
 
  
  <xsl:template match="marc:record">
    <xsl:variable name="leader" select="marc:leader" />
    <xsl:variable name="leader6" select="substring($leader,7,1)" />
    <xsl:variable name="leader7" select="substring($leader,8,1)" />
    <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='9']" />
    <xsl:variable name="isbn" select="marc:datafield[@tag=010]/marc:subfield[@code='a']"/>
    <xsl:variable name="urlCBLcover" select="marc:datafield[@tag=976]/marc:subfield[@code='u']"/>
<span><xsl:attribute name="id"><xsl:value-of select="$isbn"/></xsl:attribute><xsl:attribute name="urlcblcover"><xsl:value-of select="$urlCBLcover"/></xsl:attribute><xsl:attribute name="class">isbn</xsl:attribute></span>
   <div class="container">
   <div id="catalogue_detail_bibliogr">

<xsl:if test="marc:datafield[@tag=115]">
  <xsl:call-template name="tag_115" />
</xsl:if>

<xsl:if test="marc:datafield[@tag=200]">
      <xsl:for-each select="marc:datafield[@tag=200]">
        <h1><span class="detail_titre">
        <xsl:for-each select="marc:subfield">
          <xsl:choose>
            <xsl:when test="@code='a'">
              <xsl:if test="preceding-sibling::marc:subfield[@code='a']"><xsl:text> ; </xsl:text></xsl:if>
              <xsl:variable name="title" select="."/>
              <xsl:variable name="ntitle"
               select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
              <xsl:value-of select="$ntitle" />
                <!-- <xsl:if test="following-sibling::marc:subfield[@code='a']"><xsl:text> ; </xsl:text></xsl:if> -->
                <xsl:if test="following-sibling::*[1][@code='a']"><xsl:text> ; </xsl:text></xsl:if>
            </xsl:when>
            <xsl:when test="@code='c'">
              <xsl:text> ; </xsl:text>
              <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="@code='d'">
              <xsl:text> = </xsl:text>
              <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="@code='h'">
             <xsl:choose>
               <xsl:when test="(preceding-sibling::*[1][@code='f'] or preceding-sibling::*[1][@code='g'])">
                <xsl:value-of select="."/>
               </xsl:when>
               <xsl:otherwise>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="."/>
               </xsl:otherwise>
             </xsl:choose>
            </xsl:when>
            <xsl:when test="@code='i'">
             <xsl:choose>
              <xsl:when test="@code='h'">
               <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:otherwise>
               <xsl:text>. </xsl:text>
              </xsl:otherwise>
             </xsl:choose>
             <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="@code='e'">
              <xsl:text> : </xsl:text>
              <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="@code='f'">
             <xsl:choose>
               <xsl:when test="(following-sibling::*[1][@code='g'])">
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_resp"&gt; / </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> ; </xsl:text>
                <xsl:value-of select="(following-sibling::*[1][@code='g'])"/>
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_titre"&gt;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_resp"&gt; / </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_titre"&gt;</xsl:text>
               </xsl:otherwise>
             </xsl:choose>
            </xsl:when>
            <xsl:when test="@code='g'">
             <xsl:choose>
               <xsl:when test="(not(preceding-sibling::*[1][@code='f'] or preceding-sibling::*[1][@code='g']))">
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_resp"&gt; / </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_titre"&gt;</xsl:text>
               </xsl:when>
               <xsl:when test="(preceding-sibling::*[1][@code='g'])">
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_resp"&gt; ; </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/span&gt;&lt;span class="detail_titre"&gt;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
               </xsl:otherwise>
             </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
        </span></h1>
      </xsl:for-each>
 </xsl:if>

<div class="notice">
<xsl:if test="marc:datafield[@tag=856]">
<xsl:call-template name="tag_856" /><!-- url -->
</xsl:if>

<xsl:call-template name="tag_7xx" /><!-- auteurs -->

<xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a' or @code='b']">
<xsl:call-template name="tag_205" /><!-- édition -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='c' or @code='d']">
<xsl:call-template name="tag_210" /><!-- éditeur -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=225]/marc:subfield[@code='a']">
<xsl:call-template name="tag_225" /><!-- collection -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=327]">
<xsl:call-template name="tag_note327" /><!-- contenu -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=330]">
<xsl:call-template name="tag_note330" /><!-- résumé -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=359]">
<xsl:call-template name="tag_note359" /><!-- sommaire -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=300]">
<xsl:call-template name="tag_300" /><!-- note géné -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=302]">
<xsl:call-template name="tag_302" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=303]">
<xsl:call-template name="tag_303" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=304]">
<xsl:call-template name="tag_304" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=305]">
<xsl:call-template name="tag_305" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=306]">
<xsl:call-template name="tag_306" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=307]">
<xsl:call-template name="tag_307" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=308]">
<xsl:call-template name="tag_308" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=312]">
<xsl:call-template name="tag_312" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=314]">
<xsl:call-template name="tag_314" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=316]">
<xsl:call-template name="tag_316" /><!-- note CJB -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=990]">
<xsl:call-template name="tag_990" /><!-- notes locales CJB -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=322]">
<xsl:call-template name="tag_322" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=323]">
<xsl:call-template name="tag_323" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=324]">
<xsl:call-template name="tag_324" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=325]">
<xsl:call-template name="tag_325" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=326]">
<xsl:call-template name="tag_326" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=328]">
<xsl:call-template name="tag_328" /><!-- note thèses-->
</xsl:if>

<xsl:if test="marc:datafield[@tag=310]">
<xsl:call-template name="tag_310" /><!-- note disponibilité (these confidentielle ou pas) et reliure -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=336]">
<xsl:call-template name="tag_336" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=337]">
<xsl:call-template name="tag_337" /><!-- note -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=320]">
<xsl:call-template name="tag_320" /><!-- note biblio -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
<xsl:call-template name="tag_099" /><!-- ccode / type de doc -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=463]">
<xsl:call-template name="tag_463" /><!-- lien titre revue si article -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=215]">
<xsl:call-template name="tag_215" /><!-- description -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='a']">
<xsl:call-template name="tag_010" /><!-- isbn -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=011]/marc:subfield[@code='a']">
<xsl:call-template name="tag_011" /><!-- issn -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=930]">
<xsl:call-template name="tag_930" /><!-- collection perio -->
</xsl:if>

<xsl:call-template name="tag_6xx" /><!-- sujets -->

<xsl:if test="marc:datafield[@tag=940]">
<xsl:call-template name="tag_940" /><!-- en commande -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=992]">
<xsl:call-template name="tag_992" /><!-- sujet en3s -->
</xsl:if>

<xsl:if test="marc:datafield[@tag=993]">
<xsl:call-template name="tag_993" /><!-- sujet ensase -->
</xsl:if>

</div>

</div></div> <!-- <div style="height:150px;margin-top:50px;"><hr /></div> -->
</xsl:template>

</xsl:stylesheet>
