<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE stylesheet>

<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="marc str">

<xsl:import href="UNIMARCslimUtils.xsl"/>
<xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
<xsl:template match="/">
 <xsl:apply-templates/>
</xsl:template>

 <xsl:template match="marc:record">
 <xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='Display856uAsImage']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="biblionumber" select="marc:controlfield[@tag=001]"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>

<!-- Zone 200 - Titre-Auteur -->
 <xsl:if test="marc:datafield[@tag=200]">
 <xsl:for-each select="marc:datafield[@tag=200]">
 <h1>
 <xsl:call-template name="addClassRtl" />
 <xsl:variable name="title" select="marc:subfield[@code='a']"/>
 <xsl:variable name="ntitle"
         select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
 <xsl:value-of select="marc:subfield[@code='a'][1]" />
<xsl:if test="marc:subfield[@code='e'][1]"><xsl:text>: </xsl:text><xsl:value-of select="marc:subfield[@code='e'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][1]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='c'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][1]"><xsl:text> = </xsl:text><xsl:value-of select="translate(marc:subfield[@code='d'][1], '=', '')" /></xsl:if>
<xsl:if test="marc:subfield[@code='h'][1]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='h'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][1]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='i'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='e'][2]"><xsl:text>: </xsl:text><xsl:value-of select="marc:subfield[@code='e'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='c'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][2]"><xsl:text> = </xsl:text> <xsl:value-of select="translate(marc:subfield[@code='d'][2], '=', '')"/></xsl:if>
<xsl:if test="marc:subfield[@code='h'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='h'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='i'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='e'][3]"><xsl:text>: </xsl:text><xsl:value-of select="marc:subfield[@code='e'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='c'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][3]"><xsl:text> = </xsl:text><xsl:value-of select="translate(marc:subfield[@code='d'][3], '=', '')" /></xsl:if>
<xsl:if test="marc:subfield[@code='h'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='h'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='i'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='a'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='a'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][3]" /></xsl:if>
</h1>
<h2>
<xsl:if test="marc:subfield[@code='f']">
<xsl:text> / </xsl:text>
<xsl:if test="marc:subfield[@code='f'][1]"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='f'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='f'][2]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='f'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='f'][3]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='f'][3]" /></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='g'][1]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='g'][2]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='g'][3]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][3]" /></xsl:if>
</h2>
</xsl:for-each>
</xsl:if>

<!-- Bouton vers l'OPAC -->
 <xsl:if test="marc:controlfield[@tag=001]">
 <span id="vue_opac_button">
 <span class="results_summary online_resources">
 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=942]/marc:subfield[@code='n'=1]">
 <button style="background-color: #ffb6b6;">
 <a style="color: #ff0000;">
 <xsl:attribute name="href">
 <xsl:value-of select="marc:sysprefs/marc:syspref[@name='OPACBaseURL']"/>/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:controlfield[@tag=001]"/>
 </xsl:attribute>
 <xsl:attribute name="title">This biblio is hidden on the OPAC</xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:text>Hidden biblio</xsl:text>
 </a>
 </button>
 </xsl:when>
 <xsl:otherwise>
 <button>
 <a style="color: #333;">
 <xsl:attribute name="href">
 <xsl:value-of select="marc:sysprefs/marc:syspref[@name='OPACBaseURL']"/>/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:controlfield[@tag=001]"/>
 </xsl:attribute>
 <xsl:attribute name="title">Go to OPAC</xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:text>Go to OPAC</xsl:text>
 </a>
 </button>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 </span>
 </xsl:if>

<!-- Zones 45x - Traductions liées -->
 <xsl:call-template name="tag_45x">
 <xsl:with-param name="tag">453</xsl:with-param>
 <xsl:with-param name="label">Transletd version</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_45x">
 <xsl:with-param name="tag">454</xsl:with-param>
 <xsl:with-param name="label">Translation of</xsl:with-param>
 </xsl:call-template>

<!-- Zones 500-503 - Titre uniforme / de forme -->
 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">500</xsl:with-param>
 <xsl:with-param name="label">Uniform Title</xsl:with-param>
 <xsl:with-param name="spanclass">uniform_title</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">503</xsl:with-param>
 <xsl:with-param name="label">Uniform Conventional Heading</xsl:with-param>
 <xsl:with-param name="spanclass">uniform_conventional_heading</xsl:with-param>
 </xsl:call-template>

<!-- Zones 46x - Notices liées -->
 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">461</xsl:with-param>
 <xsl:with-param name="label">Set Level</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">463</xsl:with-param>
 <xsl:with-param name="label">Set Level</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">464</xsl:with-param>
 <xsl:with-param name="label">Piece-Analytic Level</xsl:with-param>
 </xsl:call-template>

 <!-- Zones 7xx - Auteurs -->
 <!-- Zones 700-701 - Auteurs + co-auteurs -->
 <xsl:if test="marc:datafield[@tag=700 or @tag=701]">
 <span class="results_summary author main_author">
 <span class="label">Main Author<xsl:if test="marc:datafield[starts-with(@tag,'701')]">s</xsl:if>: </span>
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:datafield[@tag=700 or @tag=701]">
 <li style="list-style-type: none;">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=an:</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code=9], true())"/>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=au:</xsl:text>
 <xsl:text>"</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='a'], true())"/>
 <xsl:text>%20</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='b'], true())"/>
 <xsl:text>%20</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='d'], true())"/>
 <xsl:text>"</xsl:text>
 </xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text> </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 </xsl:if>
 </a>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']">
 <xsl:text> (</xsl:text>
 <xsl:value-of select="marc:subfield[@code='g']"/>
 <xsl:text>)</xsl:text>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <span dir="ltr">
 <xsl:text> (</xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text>)</xsl:text>
 </span>
 </xsl:if>
  <xsl:if test="marc:subfield[@code='p']">
 <xsl:text> </xsl:text>
 <xsl:value-of select="marc:subfield[@code='p']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='4']">
 <xsl:text>, </xsl:text>
 <xsl:for-each select="marc:subfield[@code='4']">
 <xsl:if test="not (position() = 1)"><xsl:text> - </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 </li>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zones 710-711 - Auteurs + co-auteurs collectivités -->
 <xsl:if test="marc:datafield[@tag=710 or @tag=711]">
 <span class="results_summary author corporate_main_author">
 <span class="label">Main Corporate Author<xsl:if test="marc:datafield[starts-with(@tag,'711')]">s</xsl:if>: </span>
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:datafield[@tag=710 or @tag=711]">
 <li style="list-style-type: none;">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=an:</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code=9], true())"/>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=au:</xsl:text>
 <xsl:text>"</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='a'], true())"/>
 <xsl:text>%20</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='b'], true())"/>
 <xsl:text>%20</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='d'], true())"/>
 <xsl:text>"</xsl:text>
 </xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text> </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 </xsl:if>
 </a>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']">
 <xsl:text> (</xsl:text>
 <xsl:value-of select="marc:subfield[@code='g']"/>
 <xsl:text>)</xsl:text>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <span dir="ltr">
 <xsl:text> (</xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text>)</xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='p']">
 <xsl:text> </xsl:text>
 <xsl:value-of select="marc:subfield[@code='p']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='4']">
 <xsl:text>, </xsl:text>
 <xsl:for-each select="marc:subfield[@code='4']">
 <xsl:if test="not (position() = 1)"><xsl:text> - </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 </li>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">702</xsl:with-param>
 <xsl:with-param name="label">Secondary Author<xsl:if test="count(marc:datafield[starts-with(@tag,'702')])>1">s</xsl:if></xsl:with-param>
 <xsl:with-param name="spanclass">secondary_author</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">712</xsl:with-param>
 <xsl:with-param name="label">Secondary Corporate Author<xsl:if test="count(marc:datafield[starts-with(@tag,'712')])>1">s</xsl:if></xsl:with-param>
 <xsl:with-param name="spanclass">corporate_secondary_author</xsl:with-param>
 </xsl:call-template>

 <!-- Zone 101 - Langues -->
 <xsl:if test="marc:datafield[@tag=101]">
 <span class="results_summary language">
 <span class="label">Language<xsl:if test="count(marc:datafield[@tag=101]/*)>1">s</xsl:if>: </span>
 <xsl:if test="marc:datafield[@tag=101]">
 <xsl:for-each select="marc:datafield[@tag=101]">
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:for-each select="marc:subfield[@code='a']">
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:for-each select="marc:subfield[@code='b']">
 <xsl:if test="position() = 1"><xsl:text> • of intermediate text: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:for-each select="marc:subfield[@code='c']">
 <xsl:if test="position() = 1"><xsl:text> • of original work: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:for-each select="marc:subfield[@code='d']">
 <xsl:if test="position() = 1"><xsl:text> • of summary: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:if test="position() = 1"><xsl:text> • of contents page: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <xsl:for-each select="marc:subfield[@code='f']">
 <xsl:if test="position() = 1"><xsl:text> • of title page: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']">
 <xsl:for-each select="marc:subfield[@code='g']">
 <xsl:if test="position() = 1"><xsl:text> • of title proper: </xsl:text></xsl:if> 
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:for-each select="marc:subfield[@code='h']">
 <xsl:if test="position() = 1"><xsl:text> • of libretto: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:for-each select="marc:subfield[@code='i']">
 <xsl:if test="position() = 1"><xsl:text> • of accompanying material: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='j']">
 <xsl:for-each select="marc:subfield[@code='j']">
 <xsl:if test="position() = 1"><xsl:text> • of subtitles: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>
 </span>
 </xsl:if>

 <!-- Zone 102 - Pays -->
 <xsl:if test="marc:datafield[@tag=102]">
 <span class="results_summary country">
 <span class="label">Countr<xsl:if test="count(marc:datafield[@tag=102]/*)=1">y</xsl:if><xsl:if test="count(marc:datafield[@tag=102]/*)>1">ies</xsl:if>: </span>
 <xsl:for-each select="marc:datafield[@tag=102]">
 <xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:if test="not (position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 205 - Mention d'édition -->
 <xsl:if test="marc:datafield[@tag=205]">
 <span class="results_summary edition">
 <span class="label">Edition Statement: </span>
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:datafield[@tag=205]">
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='6'"/>
 <xsl:when test="@code='7'"/>
 <xsl:otherwise>
 <xsl:value-of select="text()"/>
 <xsl:if test="not (position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 <xsl:if test="not (position()=last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zones 210-214 - Publication -->
 <xsl:if test="marc:datafield[@tag=210]">
 <xsl:call-template name="tag_210" />
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=214]">
 <xsl:call-template name="tag_214" />
 </xsl:if>

 <!-- Zone 215 - Description -->
 <xsl:call-template name="tag_215" />

 <!-- Zone 009 - ppn + lien vers notice SUDOC -->
 <span class="results_summary ppn">
 <span class="label">ppn: </span>
 <xsl:choose>
 <xsl:when test="marc:controlfield[@tag=009]">
  <xsl:value-of select="marc:controlfield[@tag=009]"/>
 <!-- Début logo SUDOC -->
 <xsl:text> </xsl:text>
 <a>
  <xsl:attribute name="href">http://www.sudoc.fr/<xsl:value-of select="marc:controlfield[@tag=009]"/></xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:attribute name="id">ppn</xsl:attribute>
 <img src="https://abes.fr/wp-content/uploads/2020/01/logo-sudoc.svg" alt="SUDOC" title="See record on SUDOC" width="25px" />
 </a>
 <!-- Fin logo SUDOC -->
 </xsl:when>
 <xsl:otherwise><span class='nosudoc'>Local record out of SUDOC</span></xsl:otherwise>
 </xsl:choose>
 </span>

 <!-- Zone 010 - ISBN -->
 <xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='a']">
 <span class="results_summary isbn">
 <span class="label">ISBN: </span>
 <xsl:for-each select="marc:datafield[@tag=010]/marc:subfield[@code='a']">
 <span property="isbn">
 <xsl:value-of select="."/>
 <xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
 </span>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 011 - ISSN -->
 <xsl:if test="marc:datafield[@tag=011]/marc:subfield[@code='a']">
 <span class="results_summary issn">
 <span class="label">ISSN: </span>
 <xsl:for-each select="marc:datafield[@tag=011]/marc:subfield[@code='a']">
 <span property="issn">
 <xsl:value-of select="."/>
 <xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
 </span>
 </xsl:for-each>
 </span>
 </xsl:if>

<!-- Collection 410 sinon 225 -->
 <xsl:if test="marc:datafield[@tag=225 or @tag=410]">
 <span class="results_summary Collection">
 <span class="label">Serie<xsl:if test="count(marc:datafield[starts-with(@tag,'410')])>1 or count(marc:datafield[starts-with(@tag,'225')])>1">s</xsl:if>: </span>
 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=410]">
 <xsl:for-each select="marc:datafield[@tag=410]">
 <xsl:if test="marc:subfield[@code='t']">
<a>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=se,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute>
 <xsl:attribute name="title">Other titles of the serie "<xsl:value-of select="marc:subfield[@code='t']"/>" </xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
</a>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='l']">
 <xsl:text> = </xsl:text>
 <xsl:value-of select="marc:subfield[@code='l']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='o']">
 <xsl:for-each select="marc:subfield[@code='o']">
 <xsl:if test="position() = 1"><xsl:text>: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <xsl:text> / </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='g']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='h']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='v']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='x']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='x']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='y']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='y']"/>
 </xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 
 </xsl:when>
 <xsl:otherwise test="marc:datafield[@tag=225]">
 <xsl:for-each select="marc:datafield[@tag=225]">
 <xsl:if test="marc:subfield[@code='a']">
 <a>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=se,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
 <xsl:attribute name="title">Other titles of the serie "<xsl:value-of select="marc:subfield[@code='t']"/>" </xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </a>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text> = </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:if test="marc:subfield[@code='z']">
 <xsl:text> (</xsl:text>
 <xsl:value-of select="marc:subfield[@code='z']"/>
 <xsl:text>)</xsl:text>
 </xsl:if>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:if test="position() = 1"><xsl:text>: </xsl:text></xsl:if>
 <xsl:if test="not (position() = 1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <xsl:text> / </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='h']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='v']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='x']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='x']"/>
 </xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 </xsl:if>

 <!-- Zone 686 - Classification -->
 <xsl:if test="marc:datafield[@tag=686]">
 <span class="results_summary classification">
 <span class="label">Classification: </span>
 <xsl:for-each select="marc:datafield[@tag=686]">
<xsl:choose>

 <xsl:when test="marc:subfield[@code='a'] and marc:subfield[@code='c']">
 <a>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=igeo=<xsl:value-of select="marc:subfield[@code='a']"/> AND icla=<xsl:value-of select="marc:subfield[@code='c']"/></xsl:attribute>
 <xsl:attribute name="title"> Search for <xsl:call-template name="igeo">
 <xsl:with-param name="igeocode" select="marc:subfield[@code='a']"/></xsl:call-template> and <xsl:call-template name="icla"><xsl:with-param name="iclacode" select="marc:subfield[@code='c']"/></xsl:call-template> documents </xsl:attribute>
 <xsl:call-template name="igeo"><xsl:with-param name="igeocode" select="marc:subfield[@code='a']"/></xsl:call-template><xsl:text>, </xsl:text><xsl:call-template name="icla"><xsl:with-param name="iclacode" select="marc:subfield[@code='c']"/></xsl:call-template>
 </a>
 </xsl:when>

 <xsl:when test="marc:subfield[@code='a']">
 <a>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=igeo=<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
 <xsl:attribute name="title"> Search for <xsl:call-template name="igeo">
 <xsl:with-param name="igeocode" select="marc:subfield[@code='a']"/> documents </xsl:call-template></xsl:attribute>
 <xsl:call-template name="igeo"><xsl:with-param name="igeocode" select="marc:subfield[@code='a']"/></xsl:call-template>
 </a>
 </xsl:when>

 <xsl:when test="marc:subfield[@code='c']">
 <a>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=icla=<xsl:value-of select="marc:subfield[@code='c']"/></xsl:attribute>
 <xsl:attribute name="title"> Search for <xsl:call-template name="icla"><xsl:with-param name="iclacode" select="marc:subfield[@code='c']"/></xsl:call-template> documents </xsl:attribute>
 <xsl:call-template name="icla"><xsl:with-param name="iclacode" select="marc:subfield[@code='c']"/></xsl:call-template>
 </a>
 </xsl:when>
 </xsl:choose>
 <xsl:if test="not (position()=last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 327 - Notes de contenu -->
 <xsl:if test="marc:datafield[@tag=327]">
 <span class="results_summary contents">
 <span class="label">Contents note: </span>
 <xsl:for-each select="marc:datafield[@tag=327]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdjpvxyz</xsl:with-param>
 <xsl:with-param name="subdivCodes">jpxyz</xsl:with-param>
 <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 330 - Résumé -->
 <xsl:if test="marc:datafield[@tag=330]">
 <span class="results_summary abstract">
 <span class="label">Abstract: </span>
 <xsl:for-each select="marc:datafield[@tag=330]">
 <div style="padding-bottom: 4px;">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:if test="not (position()=last())"><br/></xsl:if>
 </div>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 320 - Bibliographie -->
 <xsl:if test="marc:datafield[@tag=320]">
 <span class="results_summary bibliography">
 <span class="label">Bibliography: </span>
 <xsl:for-each select="marc:datafield[@tag=320]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:if test="not (position()=last())"><br/></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 328 - Notes de thèse -->
 <xsl:if test="marc:datafield[@tag=328]">
 <span class="results_summary thesis">
 <span class="label">Thesis: </span>
 <xsl:for-each select="marc:datafield[@tag=328]">
 <xsl:if test="marc:subfield[@code='a']"><xsl:value-of select="marc:subfield[@code='a']" /></xsl:if>
<xsl:if test="marc:subfield[@code='z']"><xsl:value-of select="marc:subfield[@code='z']" /><xsl:text> </xsl:text></xsl:if>
<xsl:if test="marc:subfield[@code='b']"><xsl:value-of select="marc:subfield[@code='b']" /></xsl:if>
<xsl:if test="marc:subfield[@code='c']"><xsl:text>: </xsl:text><xsl:value-of select="marc:subfield[@code='c']" /></xsl:if>
<xsl:if test="marc:subfield[@code='e']"><xsl:text> (</xsl:text><xsl:value-of select="marc:subfield[@code='e']" />
<xsl:if test="marc:subfield[@code='d']"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']" /></xsl:if>)
</xsl:if>
  <xsl:if test="not (position()=last())"><br/></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zones 455-456 - Reproductions de thèse -->
 <xsl:call-template name="thesisrepro">
 <xsl:with-param name="tag">455</xsl:with-param>
 <xsl:with-param name="label">Reproduction of</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="thesisrepro">
 <xsl:with-param name="tag">456</xsl:with-param>
 <xsl:with-param name="label">Reproduction version</xsl:with-param>
 </xsl:call-template>


 <!-- Zone 326 - Périodicité -->
 <xsl:if test="marc:datafield[@tag=326]">
 <span class="results_summary sudoc_serial_history">
 <span class="label">Serial Frequency: </span>
 <xsl:for-each select="marc:datafield[@tag=326]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='b']"><xsl:text> (</xsl:text><xsl:value-of select="marc:subfield[@code='b']" />)</xsl:if>
 <xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 955 - État de collection -->
 <xsl:if test="marc:datafield[@tag=955]/marc:subfield[@code='r']">
 <span class="results_summary sudoc_serial_history">
 <span class="label">SUDOC serial history: </span>
 <xsl:for-each select="marc:datafield[@tag=955]">
 <xsl:sort select="marc:subfield[@code='9']" data-type="text" />
 <xsl:sort select="marc:subfield[@code='z']" data-type="text" />
 <xsl:if test="marc:subfield[@code='r']">
 <li style="list-style-type: none; padding-top: 4px;">
 <span class='sitecoll'><xsl:attribute name="style">font-weight:bold;</xsl:attribute>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CESLA'">Centre d'études slaves (CESLA)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOT'">EFEO Chiang Mai (Thaïlande)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOH'">EFEO Hanoï (Vietnam)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOJ'">EFEO Jakarta (Indonésie)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOK'">EFEO Kyoto (Japon)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEO'">EFEO Paris</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOP'">EFEO Pondichéry (Inde)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOS'">EFEO Siem Reap (Cambodge)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOF'">EFEO Toulouse</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EFEOV'">EFEO Ventiane (Laos)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CASE'">EHESS-CNRS : Centre Asie du Sud-Est (CASE)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CECMC'">EHESS-CNRS: Centre d'études sur la Chine moderne et contemporaine (CECMC)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CEIAS'">EHESS-CNRS: Centre d’études de l’Inde et de l’Asie du Sud (CEIAS)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CERCEC'">EHESS-CNRS: Centre d’études des mondes russe, caucasien et centre-européen (CERCEC)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CEJAP'">EHESS-CNRS: Centre de recherches sur le Japon (CEJAP)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CEAFR'">EHESS-IRD: Centres d'études africaines (CEAFR)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='BSR'">EPHE - Bibliothèque des sciences religieuses</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='BMF'">EPHE - Bibliothèque Michel Fleury</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CEMS'">EPHE - Centre d'études mongoles et sibériennes (CEMS)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CEMSI'">EPHE - Centre d'études mongoles et sibériennes (CEMSI)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CDAT'">EPHE - Centre de documentation sur l'aire tibétaine (CDAT)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='EPHEJ'">EPHE - Centre Japon</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='CWG'">EPHE - Centre Wladimir Golenischeff</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='SHP'">EPHE 4 - Sciences historiques et philologiques</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='IEIMI'">IEI - Ivry</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='MAISA'">Maison de l'Asie</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='LCAO'">Paris 7 - LCAO Corée</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='LCAOC'">Paris 7 - LCAO Corée</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='SORBO'">Sorbonne (SORBO)</xsl:when>
 <xsl:when test="marc:subfield[@code='9' or @code='z']='IFRIT'">Téhéran - Institut français de recherches en Iran</xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="translate(marc:subfield[@code='9' or @code='z'], ' : ', '')"/>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='r']"/>
 </li>
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Zone 6xx - Sujets -->
 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">600</xsl:with-param>
 <xsl:with-param name="label">Subject - Personal Name</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">601</xsl:with-param>
 <xsl:with-param name="label">Subject - Corporate Author</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">602</xsl:with-param>
 <xsl:with-param name="label">Subject - Family</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">604</xsl:with-param>
 <xsl:with-param name="label">Subject - Author/Title</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">605</xsl:with-param>
 <xsl:with-param name="label">Subject - Uniform Title</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">606</xsl:with-param>
 <xsl:with-param name="label">Subject - Topical Name</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">607</xsl:with-param>
 <xsl:with-param name="label">Subject - Geographical Name</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">608</xsl:with-param>
 <xsl:with-param name="label">Subject - Form</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">610</xsl:with-param>
 <xsl:with-param name="label">Subject</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">615</xsl:with-param>
 <xsl:with-param name="label">Subject Category</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">616</xsl:with-param>
 <xsl:with-param name="label">Trademark</xsl:with-param>
 </xsl:call-template>

<!-- Zone 856 - Ressources en ligne -->
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary online_resources">
 <span class="label">Online Resources: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:if test="marc:subfield[@code='u']">

 <xsl:variable name="SubqText">
 <xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <button style="margin: 5px;">
 <a style="color: #333;">
 <xsl:attribute name="href">
 <xsl:value-of select="marc:subfield[@code='u']"/>
 </xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Details' or $Show856uAsImage='Both') and (substring($SubqText,1,6)='image/' or $SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
 <xsl:element name="img">
 <xsl:attribute name="src">
 <xsl:value-of select="marc:subfield[@code='u']"/>
 </xsl:attribute>
 <xsl:attribute name="alt">
 <xsl:value-of select="marc:subfield[@code='y']"/>
 </xsl:attribute><xsl:attribute name="height">100</xsl:attribute>
 </xsl:element>
 <xsl:text></xsl:text>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">Click here to access online</xsl:when>
 </xsl:choose>
 </a>
 </button>
 </xsl:if>
 <xsl:if test="not(marc:subfield[@code='u'])">
 <xsl:value-of select="."/>
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>
</xsl:template>


 <xsl:template name="nameABCDQ">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">aq</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 <xsl:with-param name="punctuation">
 <xsl:text>:,;/ </xsl:text>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:call-template name="termsOfAddress"/>
 </xsl:template>


 <xsl:template name="nameABCDN">
 <xsl:for-each select="marc:subfield[@code='a']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='n']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cdn</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>


 <xsl:template name="nameACDEQ">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">acdeq</xsl:with-param>
 </xsl:call-template>
 </xsl:template>
 <xsl:template name="termsOfAddress">
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bc</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>


 <xsl:template name="part">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">n</xsl:with-param>
 <xsl:with-param name="anyCodes">n</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partNumber"/>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partName"/>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>


 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>

</xsl:stylesheet>
