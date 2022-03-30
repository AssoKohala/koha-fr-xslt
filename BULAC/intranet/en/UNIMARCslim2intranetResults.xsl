<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE stylesheet>

<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
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

 <xsl:variable name="IntranetBiblioDefaultView" select="marc:sysprefs/marc:syspref[@name='IntranetBiblioDefaultView']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="biblionumber" select="marc:controlfield[@tag=001]"/>
 <xsl:variable name="isbn" select="marc:datafield[@tag=010]/marc:subfield[@code='a']"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>

 <!-- Titre-Auteur -->
 <xsl:if test="marc:datafield[@tag=200]">
 <xsl:for-each select="marc:datafield[@tag=200]">
 <xsl:if test="not (position() = 1)"><br/></xsl:if>
 <a>
 <xsl:attribute name="href">
 <xsl:call-template name="buildBiblioDefaultViewURL">
 <xsl:with-param name="IntranetBiblioDefaultView">
 <xsl:value-of select="$IntranetBiblioDefaultView"/>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:value-of select="str:encode-uri($biblionumber, true())"/>
 </xsl:attribute>
 <xsl:attribute name="class">title</xsl:attribute>
 <xsl:variable name="title" select="marc:subfield[@code='a']"/>
 <xsl:variable name="ntitle"
            select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
 <xsl:value-of select="$ntitle" />
<xsl:if test="marc:subfield[@code='a'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='a'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][3]" /></xsl:if>
 </a>
 <xsl:if test="marc:subfield[@code='e']">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text> = </xsl:text>
 <xsl:value-of select="translate(marc:subfield[@code='d'], '=', '')"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='h']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <br/><xsl:text> / </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']">
 <xsl:text>; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='g']"/>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>


 <div style="margin-top:10px">

<!-- Zones 45x - Traductions liées -->
 <xsl:call-template name="tag_45x">
 <xsl:with-param name="tag">453</xsl:with-param>
 <xsl:with-param name="label">Traduit sous le titre</xsl:with-param>
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
 <xsl:with-param name="label">Contient / Dans</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">464</xsl:with-param>
 <xsl:with-param name="label">Piece-Analytic Level</xsl:with-param>
 </xsl:call-template>

<!-- Zones 210-214 - Publication -->
 <xsl:if test="marc:datafield[@tag=210 or @tag=214]">
 <xsl:call-template name="tag_210-214" />
 </xsl:if>

<!-- Zone 215 - Description -->
 <xsl:call-template name="tag_215" />

 </div>

 <!-- Masquage OPAC 942$n=1 -->
 <xsl:if test="marc:datafield[@tag=942][marc:subfield[@code='n'] = '1']">
 <span class="results_summary suppressed_opac" style="color: #FF0000;">
 Hidden biblio
 </span>
 </xsl:if>

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
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:choose>
 <xsl:when test="string-length(marc:subfield[@code='y' or @code='3' or @code='z']) > 40">
 <xsl:value-of select="substring(marc:subfield[@code='y' or @code='3' or @code='z'],1,40)"/>
 <xsl:text> [...]</xsl:text>
 </xsl:when>
 <xsl:otherwise>
<xsl:value-of select="marc:subfield[@code='y' or @code='3' or @code='z']"/>
 </xsl:otherwise>
 </xsl:choose>
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
</xsl:stylesheet>
