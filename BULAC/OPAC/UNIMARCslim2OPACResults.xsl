<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE stylesheet>

<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="marc items str">

<xsl:import href="UNIMARCslimUtils.xsl"/>
<xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
<xsl:key name="item-by-status" match="items:item" use="items:status"/>
<xsl:key name="item-by-status-and-branch-home" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>
<xsl:key name="item-by-status-and-branch-holding" match="items:item" use="concat(items:status, ' ', items:holdingbranch)"/>

<xsl:template match="/">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="marc:record">
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="biblionumber" select="marc:controlfield[@tag=001]"/>
 <xsl:variable name="isbn" select="marc:datafield[@tag=010]/marc:subfield[@code='a']"/>
 <xsl:variable name="OPACResultsLibrary" select="marc:sysprefs/marc:syspref[@name='OPACResultsLibrary']"/>
 <xsl:variable name="BiblioDefaultView" select="marc:sysprefs/marc:syspref[@name='BiblioDefaultView']"/>
 <xsl:variable name="hidelostitems" select="marc:sysprefs/marc:syspref[@name='hidelostitems']"/>
 <xsl:variable name="singleBranchMode" select="marc:sysprefs/marc:syspref[@name='singleBranchMode']"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>

 <!-- Titre-Auteur -->
 <xsl:if test="marc:datafield[@tag=200]">
 <xsl:for-each select="marc:datafield[@tag=200]">
 <xsl:if test="not (position() = 1)"><br/></xsl:if>
 <xsl:call-template name="addClassRtl" />
 <a>
 <xsl:attribute name="href">
 <xsl:call-template name="buildBiblioDefaultViewURL">
 <xsl:with-param name="BiblioDefaultView">
 <xsl:value-of select="$BiblioDefaultView"/>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:value-of select="str:encode-uri($biblionumber, true())"/>
 </xsl:attribute>
 <xsl:attribute name="class">title</xsl:attribute>
 <xsl:variable name="title" select="marc:subfield[@code='a']"/>
 <xsl:variable name="ntitle"
                select="translate($title, '&#x0088;&#x0089;&#x0098;&#x009C;','')"/>
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
 <xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='g']"/>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <!-- OpenURL
 <xsl:variable name="OPACShowOpenURL" select="marc:sysprefs/marc:syspref[@name='OPACShowOpenURL']" />
 <xsl:variable name="OpenURLImageLocation" select="marc:sysprefs/marc:syspref[@name='OpenURLImageLocation']" />
 <xsl:variable name="OpenURLText" select="marc:sysprefs/marc:syspref[@name='OpenURLText']" />
 <xsl:variable name="OpenURLResolverURL" select="marc:variables/marc:variable[@name='OpenURLResolverURL']" />

 <xsl:if test="$OPACShowOpenURL = 1 and $OpenURLResolverURL != ''">
 <xsl:variable name="openurltext">
 <xsl:choose>
 <xsl:when test="$OpenURLText != ''">
 <xsl:value-of select="$OpenURLText" />
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>OpenURL</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>

 <span class="results_summary"><a>
 <xsl:attribute name="href">
 <xsl:value-of select="$OpenURLResolverURL" />
 </xsl:attribute>
 <xsl:attribute name="title">
 <xsl:value-of select="$openurltext" />
 </xsl:attribute>
 <xsl:attribute name="class">
 <xsl:text>OpenURL</xsl:text>
 </xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">
 <xsl:text>_blank</xsl:text>
 </xsl:attribute>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$OpenURLImageLocation != ''">
 <img>
 <xsl:attribute name="src">
 <xsl:value-of select="$OpenURLImageLocation" />
 </xsl:attribute>
 </img>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="$openurltext" />
 </xsl:otherwise>
 </xsl:choose>
 </a></span>
 </xsl:if>
 End of OpenURL -->

 <div style="margin-top:5px">

<!-- Zones 45x - Traductions liées -->
 <xsl:call-template name="tag_45x">
 <xsl:with-param name="tag">453</xsl:with-param>
 <xsl:with-param name="label">Transletd version</xsl:with-param>
 <xsl:with-param name="spanclass">translation_title</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_45x">
 <xsl:with-param name="tag">454</xsl:with-param>
 <xsl:with-param name="label">Translation of</xsl:with-param>
 <xsl:with-param name="spanclass">original_title</xsl:with-param>
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
 <xsl:with-param name="spanclass">set_level</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">463</xsl:with-param>
 <xsl:with-param name="label">Set Level</xsl:with-param>
 <xsl:with-param name="spanclass">set_level</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_46x">
 <xsl:with-param name="tag">464</xsl:with-param>
 <xsl:with-param name="label">Piece-Analytic Level</xsl:with-param>
 <xsl:with-param name="spanclass">piece_analytic_level</xsl:with-param>
 </xsl:call-template>

<!-- Zones 210-214 - Publication -->
 <xsl:call-template name="tag_210-214" />

<!-- Zone 215 - Description -->
 <xsl:call-template name="tag_215" />

 </div>

<!-- Zone 856 - Ressources en ligne -->
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary online_resources">
 <span class="label">Online Resources: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:if test="marc:subfield[@code='u']">
 <xsl:variable name="SubqText">
 <xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <button class="btn btn-sm btn-secondary" style="background-color: ; margin: 5px;">
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


<!-- Disponibilité 
 <span class="results_summary availability">
 <span class="label">Disponibilité : </span> -->
 <div style="margin-top:5px">
 <xsl:choose>

 <xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">
 <span class="unavailable" style="color: #666;">
 <strong><xsl:text>No items available</xsl:text></strong><br/>
 </span>
 </xsl:when>
 <xsl:when test="count(key('item-by-status', 'available'))>0">
	 <span class="available">
	<strong><xsl:text>Available items: </xsl:text></strong>
	 <xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
		<xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
			<strong><xsl:value-of select="items:homebranch"/></strong>
			 <xsl:text> (</xsl:text>
			 <xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
			 <xsl:text>)</xsl:text>
	 	<xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">: <xsl:value-of select="items:itemcallnumber"/></xsl:if>
		<xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
		</xsl:for-each>
		<xsl:if test="not (position() = last())"><br/></xsl:if>

	</span>
 </xsl:when>
 </xsl:choose>
 </div>

 <div style="margin-top:5px">
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="unavailable" style="color: #666;">
 <strong><xsl:text>Unavailable items: </xsl:text></strong>
 <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="$singleBranchMode=0">
 <strong><xsl:value-of select="items:homebranch"/></strong>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 </xsl:if>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">: <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:if test="not (position() = last())"><br/></xsl:if>
 </span>
 </xsl:when>
 </xsl:choose>
 </div>

 <div style="margin-top:5px">
   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Checked out'))>0">
      <span class="unavailable" style="color: #b92020;">
        <strong><xsl:text>Checked out: </xsl:text></strong>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Checked out')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="$singleBranchMode=0">
 <strong><xsl:value-of select="items:homebranch"/></strong>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 </xsl:if>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">: <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:if test="not (position() = last())"><br/></xsl:if>
 </span>
 </xsl:when>
 </xsl:choose>
 </div>

 <div style="margin-top:5px">
 <xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
 <span class="unavailable">
 <xsl:text>Withdrawn (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="$hidelostitems='0' and count(key('item-by-status', 'Lost'))>0">
 <span class="unavailable">
 <xsl:text>Lost (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Damaged'))>0">
 <span class="unavailable">
 <xsl:text>Damaged (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'On order'))>0">
 <span class="unavailable">
 <xsl:text>On order (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'On order'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'In transit'))>0">
 <span class="unavailable">
 <xsl:text>In transit (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Waiting'))>0">
 <span class="unavailable">
 <xsl:text>On hold (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Waiting'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 </div>
<!-- </span>-->

</xsl:template>

</xsl:stylesheet>
