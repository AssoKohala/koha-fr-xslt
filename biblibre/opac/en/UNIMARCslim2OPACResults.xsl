<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">

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
<xsl:variable name="type_doc" select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>

<xsl:if test="marc:datafield[@tag=200]">
<!--Nouveaute-->
<xsl:call-template name="nouveaute" />
<xsl:for-each select="marc:datafield[@tag=200]">
<xsl:call-template name="addClassRtl" />
<xsl:for-each select="marc:subfield">
<xsl:choose>
<xsl:when test="@code='a'">
<xsl:variable name="title" select="."/>
<xsl:variable name="ntitle"
select="translate($title, '&#x0088;&#x0089;&#x0098;&#x009C;','')"/>
<a>
<xsl:attribute name="href">
<xsl:call-template name="buildBiblioDefaultViewURL">
<xsl:with-param name="BiblioDefaultView">
<xsl:value-of select="$BiblioDefaultView"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="$biblionumber"/>
</xsl:attribute>
<xsl:attribute name="class">title</xsl:attribute>
<xsl:value-of select="$ntitle" />
</a>
</xsl:when>
<xsl:when test="@code='b'">
<xsl:text> [</xsl:text>
<xsl:value-of select="."/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="@code='d'">
<xsl:text> = </xsl:text>
<xsl:value-of select="."/>
</xsl:when>
<xsl:when test="@code='e'">
<xsl:text> : </xsl:text>
<xsl:value-of select="."/>
</xsl:when>
<xsl:when test="@code='f'">
<xsl:text> / </xsl:text>
<xsl:value-of select="."/>
</xsl:when>
<xsl:when test="@code='g'">
<xsl:text> ; </xsl:text>
<xsl:value-of select="."/>
</xsl:when>
<xsl:otherwise>
<xsl:text>, </xsl:text>
<xsl:value-of select="."/>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</xsl:if>


<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
  <span class="results_summary">
    <span class="label">Category of document : </span>
    <xsl:for-each select="marc:datafield[@tag=099]/marc:subfield[@code='t']">
      <xsl:value-of select="."/>
      <xsl:if test="not(position()=last())"><xsl:text> ; </xsl:text></xsl:if>
    </xsl:for-each>
  </span>
</xsl:if>

<!--Titre de serie - autorité 461-->
<!--<xsl:call-template name="tag_461" />-->

<!--Titre de serie non autorité 461-->
<xsl:call-template name="tag_461bis" />

<!--Titre dépouillé 463-->
<xsl:call-template name="tag_463" />

<xsl:if test="contains($type_doc,'Périodique')">
<xsl:choose>
<xsl:when test="$ppn">
<xsl:call-template name="tag_462_ppn" />
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="tag_462" />
</xsl:otherwise>
</xsl:choose>
</xsl:if>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">412</xsl:with-param>
<xsl:with-param name="label">Is an excerpt or taken apart from</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">413</xsl:with-param>
<xsl:with-param name="label">A for extract or pulled apart</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">421</xsl:with-param>
<xsl:with-param name="label">Has for supplement</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">422</xsl:with-param>
<xsl:with-param name="label">Is a supplement of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">423</xsl:with-param>
<xsl:with-param name="label">Is published with</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">424</xsl:with-param>
<xsl:with-param name="label">Is updated by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">430</xsl:with-param>
<xsl:with-param name="label">Following</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">431</xsl:with-param>
<xsl:with-param name="label">Succeeds after division of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">432</xsl:with-param>
<xsl:with-param name="label">Replace</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">433</xsl:with-param>
<xsl:with-param name="label">Replace partially</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">434</xsl:with-param>
<xsl:with-param name="label">Absorbed</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">435</xsl:with-param>
<xsl:with-param name="label">Absorbed partially</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">436</xsl:with-param>
<xsl:with-param name="label">Merge of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">437</xsl:with-param>
<xsl:with-param name="label">Partial sequence of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">440</xsl:with-param>
<xsl:with-param name="label">Become</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">441</xsl:with-param>
<xsl:with-param name="label">Become partially</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">442</xsl:with-param>
<xsl:with-param name="label">Replaced by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">443</xsl:with-param>
<xsl:with-param name="label">Remplaced partially by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">444</xsl:with-param>
<xsl:with-param name="label">Absorbed by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">447</xsl:with-param>
<xsl:with-param name="label">Meged with...to form</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">451</xsl:with-param>
<xsl:with-param name="label">Other edition,same support</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">452</xsl:with-param>
<xsl:with-param name="label">Other edition, different support</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">453</xsl:with-param>
<xsl:with-param name="label">Translated under the title</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">454</xsl:with-param>
<xsl:with-param name="label">Is a translation of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">455</xsl:with-param>
<xsl:with-param name="label">Is a reproduction of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">456</xsl:with-param>
<xsl:with-param name="label">Is reproducted as</xsl:with-param>
</xsl:call-template>

<!--<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">464</xsl:with-param>
<xsl:with-param name="label">Composante</xsl:with-param>
</xsl:call-template>-->

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">470</xsl:with-param>
<xsl:with-param name="label">Analysed document</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">481</xsl:with-param>
<xsl:with-param name="label">Is also linked in this volume</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">482</xsl:with-param>
<xsl:with-param name="label">Linked as a result of</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">488</xsl:with-param>
<xsl:with-param name="label">Other type of relation</xsl:with-param>
</xsl:call-template>

<xsl:if test="(marc:datafield[@tag=214] or marc:datafield[@tag=210])">
<xsl:choose>
<xsl:when test="(marc:datafield[@tag=214]/marc:subfield[@code='r'])">
<xsl:call-template name="tag_214_r" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=214]/marc:subfield[@code='s'])">
<xsl:call-template name="tag_214_s" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=210]/marc:subfield[@code='r'])">
<xsl:call-template name="tag_210_r" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=210]/marc:subfield[@code='s'])">
<xsl:call-template name="tag_210_s" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=214] and  marc:datafield[@tag=210])">
<xsl:call-template name="tag_214" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=214])">
<xsl:call-template name="tag_214" />
</xsl:when>
<xsl:when test="(marc:datafield[@tag=210])">
<xsl:call-template name="tag_210" />
</xsl:when>
</xsl:choose>
</xsl:if>

<xsl:call-template name="tag_215" />

<!--Collection autorité-->
<!--
<xsl:for-each select="marc:datafield[@tag=410]">
<span class="results_summary">
<span class="label">
Collection-Authority : </span>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code='9']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='t'] and marc:subfield[@code='v']">
<xsl:text> . </xsl:text>
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:if>
</span>
</xsl:for-each>-->


<xsl:if test="marc:datafield[@tag=856]/marc:subfield[@code='u']"> 
<span class="results_summary"> 
<span class="label">Online resource : </span> 
<xsl:for-each select="marc:datafield[@tag=856]"> 
<xsl:variable name="url" select="substring-before(marc:subfield[@code='u'], '//')"/> 
<xsl:if test="contains($url,'http:') or contains($url,'https:')"> 
<a> 
<xsl:attribute name="href"> 
<xsl:value-of select="marc:subfield[@code='u']"/> 
</xsl:attribute> 
<xsl:choose> 
<xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']"> 
<xsl:call-template name="subfieldSelect"> 
<xsl:with-param name="codes">y3z</xsl:with-param> 
</xsl:call-template> 
</xsl:when> 
<xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])"> 
Cliquer ici 
</xsl:when> 
</xsl:choose> 
</a> 
</xsl:if> 
<xsl:if test="not(contains($url,'http:')) and not(contains($url,'https:'))"> 
<a> 
<xsl:attribute name="href"> 
http://<xsl:value-of select="marc:subfield[@code='u']"/> 
</xsl:attribute> 
<xsl:choose> 
<xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']"> 
<xsl:call-template name="subfieldSelect"> 
<xsl:with-param name="codes">y3z</xsl:with-param> 
</xsl:call-template> 
</xsl:when> 
<xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])"> 
Cliquer ici 
</xsl:when> 
</xsl:choose> 
</a> 
</xsl:if> 
<xsl:choose> 
<xsl:when test="position()=last()"/> 
<xsl:otherwise> | </xsl:otherwise> 
</xsl:choose> 
</xsl:for-each> 
</span> 
</xsl:if>


<!--Public  995q-->
<!--<xsl:call-template name="public" />-->

<!--Fonds 995h-->
<!--<xsl:call-template name="fonds" />-->


<xsl:if test="marc:datafield[@tag=995]">
<span class="results_summary availability">
<span class="label">Availability : </span>
<xsl:choose>
<xsl:when test="marc:datafield[@tag=1856]">
<xsl:for-each select="marc:datafield[@tag=1856]">
<xsl:choose>
<xsl:when test="@ind2=0">
<a>
<xsl:attribute name="href">
<xsl:value-of select="marc:subfield[@code='u']"/>
</xsl:attribute>
<xsl:if test="$OPACURLOpenInNewWindow='1'">
<xsl:attribute name="target">_blank</xsl:attribute>
</xsl:if>
<xsl:choose>
<xsl:when test="marc:subfield[@code='y' or code='3' or  @code='z']">
<xsl:call-template name="subfieldSelect">
<xsl:with-param name="codes">y3z</xsl:with-param>
</xsl:call-template>
</xsl:when>
<xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">
Click here to see the online document
</xsl:when>
</xsl:choose>
</a>
<xsl:choose>
<xsl:when test="position()=last()"></xsl:when>
<xsl:otherwise> | </xsl:otherwise>
</xsl:choose>
</xsl:when>
</xsl:choose>
</xsl:for-each>
</xsl:when>
<xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">
No item available </xsl:when>
<xsl:when test="count(key('item-by-status', 'available'))>0">
<span class="available">
<b><xsl:text>Item(s) onloan: </xsl:text></b>
<xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
<xsl:choose>
<xsl:when test="$singleBranchMode=1">
<xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
<xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
<xsl:text> (</xsl:text>
<xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
<xsl:text>)</xsl:text>
<xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$OPACResultsLibrary='homebranch'">
<xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
<xsl:value-of select="items:homebranch"/>
<xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">[<xsl:value-of select="items:itemcallnumber"/>]
</xsl:if>
<xsl:text> (</xsl:text>
<xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
<xsl:text>)</xsl:text>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>. </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch-holding', concat(items:status, ' ', items:holdingbranch))[1])]">
<xsl:value-of select="items:holdingbranch"/>
<xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">[<xsl:value-of select="items:itemcallnumber"/>]
</xsl:if>
<xsl:text> (</xsl:text>
<xsl:value-of select="count(key('item-by-status-and-branch-holding', concat(items:status, ' ', items:holdingbranch)))"/>
<xsl:text>)</xsl:text>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>. </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</span>
</xsl:when>
</xsl:choose>
<xsl:choose>
<xsl:when test="count(key('item-by-status', 'reference'))>0">
<span class="unavailable">
<b><xsl:text>Item(s) onsite :</xsl:text></b>
<xsl:variable name="reference_items"
select="key('item-by-status', 'reference')"/>
<xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch))[1])]">
<xsl:if test="$singleBranchMode=0">
<xsl:value-of select="items:homebranch"/>
</xsl:if>
<xsl:if test="items:itemcallnumber != '' and items:itemcallnumber">[<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
<xsl:text> (</xsl:text>
<xsl:value-of select="count(key('item-by-status-and-branch-home', concat(items:status, ' ', items:homebranch)))"/>
<xsl:text>)</xsl:text>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>. </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:when>
</xsl:choose>
<xsl:if test="count(key('item-by-status', 'Checked out'))>0">
<span class="unavailable">
<xsl:text> Onloan (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'Checked out'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
<span class="unavailable">
<xsl:text> Withdrawn (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="$hidelostitems='0' and count(key('item-by-status', 'Lost'))>0">
<span class="unavailable">
<xsl:text> Lost (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="count(key('item-by-status', 'Damaged'))>0">
<span class="unavailable">
<xsl:text> Damaged (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="count(key('item-by-status', 'On order'))>0">
<span class="unavailable">
<xsl:text> In order (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'On order'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="count(key('item-by-status', 'In transit'))>0">
<span class="unavailable">
<xsl:text> In Transit (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
<xsl:if test="count(key('item-by-status', 'Waiting'))>0">
<span class="unavailable">
<xsl:text> Hold (</xsl:text>
<xsl:value-of select="count(key('item-by-status', 'Waiting'))"/>
<xsl:text>). </xsl:text>
</span>
</xsl:if>
</span>
</xsl:if>
</xsl:template>

</xsl:stylesheet>
