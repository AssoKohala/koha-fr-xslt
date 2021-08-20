<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">

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
<xsl:variable name="ppn" select="marc:controlfield[@tag=009]"/>
<xsl:variable name="coverCD" select="marc:datafield[@tag=933]/marc:subfield[@code='a']"/>
<xsl:variable name="type_doc" select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>

<!--<xsl:if test="$coverCD!=' '">
<div id='jacquette'>
<xsl:if test="marc:datafield[@tag=933]">
<xsl:for-each select="marc:datafield[@tag=933]">
<img class="coverimages" height="80" width="80"><xsl:attribute name="src"><xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute></img>
<xsl:choose>
<xsl:when test="position()=last()"/>
</xsl:choose>
</xsl:for-each>
</xsl:if> </div></xsl:if>
-->

<xsl:if test="marc:datafield[@tag=200]">
<xsl:for-each select="marc:datafield[@tag=200]">
<h1>
<xsl:call-template name="addClassRtl" />
<xsl:variable name="title" select="marc:subfield[@code='a']"/>
<xsl:variable name="ntitle"
select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
<!--<xsl:value-of select="$ntitle" />-->
<xsl:value-of select="marc:subfield[@code='a'][1]" />
<xsl:if test="marc:subfield[@code='e'][1]"><xsl:text> : </xsl:text><xsl:value-of select="marc:subfield[@code='e'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][1]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='c'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][1]"><xsl:text> = </xsl:text><xsl:value-of select="marc:subfield[@code='d'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='v'][1]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='v'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='h'][1]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='h'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][1]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='i'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='e'][2]"><xsl:text> : </xsl:text><xsl:value-of select="marc:subfield[@code='e'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][2]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='c'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][2]"><xsl:text> = </xsl:text><xsl:value-of select="marc:subfield[@code='d'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='h'][2]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='h'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][2]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='i'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='e'][3]"><xsl:text> : </xsl:text><xsl:value-of select="marc:subfield[@code='e'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='c'][3]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='c'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='d'][3]"><xsl:text> = </xsl:text><xsl:value-of select="marc:subfield[@code='d'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='h'][3]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='h'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='i'][3]"><xsl:text> . </xsl:text><xsl:value-of select="marc:subfield[@code='i'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='a'][2]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='a'][3]"><xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='a'][3]" /></xsl:if>
<xsl:if test="marc:subfield[@code='b']"><xsl:text> [</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/><xsl:text>] </xsl:text>
</xsl:if>
<xsl:if test="marc:subfield[@code='f']">
<xsl:text> / </xsl:text>
<xsl:if test="marc:subfield[@code='f'][1]"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='f'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='f'][2]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='f'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='f'][3]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='f'][3]" /></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='g'][1]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][1]" /></xsl:if>
<xsl:if test="marc:subfield[@code='g'][2]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][2]" /></xsl:if>
<xsl:if test="marc:subfield[@code='g'][3]"><xsl:text> ; </xsl:text><xsl:value-of select="marc:subfield[@code='g'][3]" /></xsl:if>
</h1>
</xsl:for-each>
</xsl:if>


<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">412</xsl:with-param>
<xsl:with-param name="label">Is an excerpt or taken apart from</xsl:with-param>
</xsl:call-template>

<xsl:for-each select="marc:datafield[@tag=413]">
<span class="results_summary">
<span class="label">A for extract or pulled apart : </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='t']) and (marc:subfield[@code='o']) and  (marc:subfield[@code='f']) and (marc:subfield[@code='c']) and (marc:subfield[@code='n']) and (marc:subfield[@code='d'])">
 <xsl:value-of select="marc:subfield[@code='t']"/>
<xsl:text> : </xsl:text>
 <xsl:value-of select="marc:subfield[@code='o']"/>
<xsl:text> / </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text>. - </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 <xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t']) and (marc:subfield[@code='o']) and (marc:subfield[@code='c']) and (marc:subfield[@code='n']) and (marc:subfield[@code='d'])">
 <xsl:value-of select="marc:subfield[@code='t']"/>
<xsl:text> : </xsl:text>
 <xsl:value-of select="marc:subfield[@code='o']"/>
 <xsl:text>. - </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 <xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t']) and (marc:subfield[@code='f']) and (marc:subfield[@code='c']) and (marc:subfield[@code='n']) and (marc:subfield[@code='d'])">
 <xsl:value-of select="marc:subfield[@code='t']"/>
<xsl:text> / </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text>. - </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 <xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t']) and (marc:subfield[@code='c']) and (marc:subfield[@code='n']) and (marc:subfield[@code='d'])">
 <xsl:value-of select="marc:subfield[@code='t']"/>
 <xsl:text>. - </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 <xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:when>
</xsl:choose>
 </span>
 </xsl:for-each>

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
<xsl:with-param name="label">Becomes</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">441</xsl:with-param>
<xsl:with-param name="label">Become partially</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">442</xsl:with-param>
<xsl:with-param name="label">Replace by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">443</xsl:with-param>
<xsl:with-param name="label">Replace partially by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">444</xsl:with-param>
<xsl:with-param name="label">Absorbed by</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">447</xsl:with-param>
<xsl:with-param name="label">Merged with...to train</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">451</xsl:with-param>
<xsl:with-param name="label">Other edition, same support</xsl:with-param>
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

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">464</xsl:with-param>
<xsl:with-param name="label">Component</xsl:with-param>
</xsl:call-template>

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

<xsl:if test="contains($type_doc,'Périodique')">
<xsl:call-template name="tag_462" />
<xsl:choose>
<xsl:when test="$ppn">
<xsl:call-template name="tag_462_ppn" />
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="tag_462" />
</xsl:otherwise>
</xsl:choose>
</xsl:if>

<!--Titre de serie autorite 461-->
<!--<xsl:call-template name="tag_461" />-->

<!---Titre de serie non autorite 461-->
<xsl:call-template name="tag_461bis" />

<!--Titre dépouillé 463-->
<xsl:call-template name="tag_463" />


<xsl:if test="marc:datafield[@tag=531]"> 
<span class="results_summary">
<span class="label">Short title : </span>
<xsl:for-each select="marc:datafield[@tag=531]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>

<xsl:if test="marc:datafield[@tag=540]">
<span class="results_summary">
<span class="label">Title added by the cataloguer : </span>
<xsl:for-each select="marc:datafield[@tag=540]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>

<xsl:if test="marc:datafield[@tag=541]">
<span class="results_summary">
<span class="label">Title translated by the cataloger : </span>
<xsl:for-each select="marc:datafield[@tag=541]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</span>
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

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">700</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">710</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">701</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">702</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">711</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">712</xsl:with-param>
 <xsl:with-param name="label">Author(s)</xsl:with-param>
 </xsl:call-template>

<xsl:if test="marc:datafield[@tag=101]"> 
<span class="results_summary">
<span class="label">Language(s) : </span>
<xsl:for-each select="marc:datafield[@tag=101]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
 <!--<xsl:choose>
 <xsl:when test="@code='b'">du texte intermédiaire, </xsl:when>
 <xsl:when test="@code='c'">de l'oeuvre originale, </xsl:when>
 <xsl:when test="@code='d'">du résumé, </xsl:when>
 <xsl:when test="@code='e'">de la table des matières, </xsl:when>
 <xsl:when test="@code='f'">de la page de titre, </xsl:when>
 <xsl:when test="@code='g'">du titre propre, </xsl:when>
 <xsl:when test="@code='h'">du livret ou des paroles, </xsl:when>
 <xsl:when test="@code='i'">du matériel d'accompagnement, </xsl:when>
 <xsl:when test="@code='j'">des sous-titres </xsl:when>n> </xsl:choose>
 <xsl:value-of select="text()"/>-->
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> ; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>

<xsl:if test="marc:datafield[@tag=102]">
<span class="results_summary">
<span class="label">Country : </span>
<xsl:for-each select="marc:datafield[@tag=102]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>

<xsl:if test="marc:datafield[@tag=205]">
<span class="results_summary">
<span class="label">Edition : </span>
<xsl:for-each select="marc:datafield[@tag=205]">
<xsl:for-each select="marc:subfield">
<xsl:value-of select="text()"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>

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

<xsl:if test="marc:controlfield[@tag=009]">
<span class="results_summary">
<span class="label">SUDOC : </span>
<a><xsl:attribute name="href">http://www.sudoc.fr/<xsl:value-of select="$ppn"/></xsl:attribute><xsl:value-of select="$ppn"/></a>
</span>
</xsl:if>

<!--ISBN-->
<xsl:if test="(marc:datafield[@tag=010]/marc:subfield[@code='a']) or (marc:datafield[@tag=010]/marc:subfield[@code='b']) or (marc:datafield[@tag=010]/marc:subfield[@code='z'])">


 <span class="results_summary">
<span class="label">ISBN : </span>
 <xsl:for-each select="marc:datafield[@tag=010]">

 <xsl:choose>
 <xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='b']) and (marc:subfield[@code='z'])">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='z']"/><xsl:text>(erroné)</xsl:text>
<xsl:text>  </xsl:text>
<xsl:text>(</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/><xsl:text>)</xsl:text>
 </xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='b'])">
 <xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>  </xsl:text>
<xsl:text>(</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/><xsl:text>)</xsl:text>
 </xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='z'])">
 <xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='z']"/><xsl:text>(erroné)</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='b']) and (marc:subfield[@code='z'])">
 <xsl:value-of select="marc:subfield[@code='z']"/>
<xsl:text>(erroné) </xsl:text><xsl:text>(</xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/><xsl:text>)</xsl:text>
</xsl:when>
 <xsl:when test="(marc:subfield[@code='a'])">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:when>
<xsl:when test="(marc:subfield[@code='b'])">
 <xsl:value-of select="marc:subfield[@code='b']"/>
 </xsl:when>
<xsl:when test="(marc:subfield[@code='d'])">
 <xsl:value-of select="marc:subfield[@code='d']"/>
 </xsl:when>
</xsl:choose>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text> </xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text> .- </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>




<xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='d']">
<span class="results_summary">
<span class="label">Price : </span>
<xsl:for-each select="marc:datafield[@tag=010]">
<xsl:variable name="isbn" select="marc:subfield[@code='d']"/>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text> ; </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>

<xsl:if test="marc:datafield[@tag=011]">
<span class="results_summary">
<span class="label">ISSN : </span>
<xsl:for-each select="marc:datafield[@tag=011]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>; </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">225</xsl:with-param>
 <xsl:with-param name="label">Collection</xsl:with-param>
 </xsl:call-template>


<!--410 Collection-->
<xsl:for-each select="marc:datafield[@tag=410]">
<span class="results_summary">
<span class="label">Collection : </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='9']) and (marc:subfield[@code='x']) and (marc:subfield[@code='v'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code='9']"/></xsl:attribute>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:element>
<xsl:text>, ISSN </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=ns&amp;q=<xsl:value-of select="marc:subfield[@code='x']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x']"/></xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='9'])  and (marc:subfield[@code='v'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code='9']"/></xsl:attribute>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='v']"/>
      </xsl:when>
<xsl:when test="(marc:subfield[@code='9']) and (marc:subfield[@code='x'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code='9']"/></xsl:attribute>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:element>
<xsl:text>, ISSN </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=ns&amp;q=<xsl:value-of select="marc:subfield[@code='x']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x']"/></xsl:element>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t']) and (marc:subfield[@code='x']) and (marc:subfield[@code='v'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=Title-series&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
<xsl:text>, ISSN </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=ns&amp;q=<xsl:value-of select="marc:subfield[@code='x']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x']"/></xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t'])  and (marc:subfield[@code='v'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=Title-series&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='t'])">
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=Title-series&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
 </xsl:choose>
</span>
</xsl:for-each>



<!--500 DE UNIFORME-->
<xsl:for-each select="marc:datafield[@tag=500]">
<span class="results_summary">
<span class="label">Uniform title : </span>
 <xsl:if test="marc:subfield[@code='a']">
<xsl:text>[</xsl:text>
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='i']) and (marc:subfield[@code='m']) and  (marc:subfield[@code='k'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='m']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='k']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='i']) and (marc:subfield[@code='l'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='l']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m']) and (marc:subfield[@code='k'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='k']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='i']) and (marc:subfield[@code='k'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='k']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='i'][3])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i'][1]"/>
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i'][2]"/>
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i'][3]"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='i'][2])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i'][1]"/>
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i'][2]"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='l'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='l']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>]</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
 </span>
 </xsl:for-each>


<!--503 TITRE FORME-->
<xsl:for-each select="marc:datafield[@tag=503]">
 <span class="results_summary">
<span class="label">Form title : </span>
 <xsl:if test="marc:subfield[@code='a']">
<xsl:text>[</xsl:text>
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='i']) and  (marc:subfield[@code='m']) and  (marc:subfield[@code='n']) and (marc:subfield[@code='o']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='i']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='o']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='m']) and (marc:subfield[@code='n']) and (marc:subfield[@code='o']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='m']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='n']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='o']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='j']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m']) and (marc:subfield[@code='n']) and (marc:subfield[@code='o']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='o']"/>
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
 <xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='m']) and (marc:subfield[@code='n']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m']) and (marc:subfield[@code='n']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='h']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='f']) and (marc:subfield[@code='h'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='f'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='i']) and (marc:subfield[@code='n'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='i']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m']) and (marc:subfield[@code='n'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='n']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m']) and (marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='j']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='m'])">
 <xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='m']"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>]</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</span>
</xsl:for-each>


<!--517 AUTRE TITRE-->
<xsl:for-each select="marc:datafield[@tag=517]">
<span class="results_summary">
<span class="label">Other title : </span>
 <xsl:if test="marc:subfield[@code='a']">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='h']) and  (marc:subfield[@code='i'])">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='h']"/>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='i']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e'])">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='j'])">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='j']"/>
</xsl:when>
</xsl:choose>
</xsl:if>
</span>
</xsl:for-each>


<xsl:if test="marc:datafield[@tag=686]">
<span class="results_summary">
<span class="label">Other classification :  </span>
<xsl:for-each select="marc:datafield[@tag=686]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='2']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='2']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='z']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:if>
<xsl:if test="not (position()=last())">
<xsl:text> ; </xsl:text>
</xsl:if>
</xsl:for-each>
</span>
</xsl:if>

<xsl:if test="marc:datafield[@tag=675]">
<span class="results_summary">
<span class="label">Classification - CDU : </span>
<xsl:for-each select="marc:datafield[@tag=675]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='b']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:if>
<xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
</xsl:for-each>
</span>
</xsl:if>


<xsl:if test="marc:datafield[@tag=676]">
<span class="results_summary">
<span class="label">Classification - Dewey : </span>
<xsl:for-each select="marc:datafield[@tag=676]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='b']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:if>
<xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
</xsl:for-each>
</span>
</xsl:if>



<!--onglet Description-->
<div id="tab-content-descr" class="tab-content">
<p>
 <xsl:if test="marc:datafield[@tag=300]">
 <span class="results_summary">
 <span class="label">Note : </span>
 <xsl:for-each select="marc:datafield[@tag=300]">
  <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=303]">
 <span class="results_summary">
 <span class="label">Note about the bibliographic description : </span>
<xsl:for-each select="marc:datafield[@tag=303]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=304]">
 <span class="results_summary">
 <span class="label">Note about the title and the authors : </span>
<xsl:for-each select="marc:datafield[@tag=304]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=305]">
 <span class="results_summary">
 <span class="label">Note about the edition and the history : </span>
<xsl:for-each select="marc:datafield[@tag=305]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=306]">
 <span class="results_summary">
 <span class="label">Note about the production : </span>
<xsl:for-each select="marc:datafield[@tag=306]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=307]">
 <span class="results_summary">
 <span class="label">Note about the material desscription : </span>
<xsl:for-each select="marc:datafield[@tag=307]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=308]">
 <span class="results_summary">
 <span class="label">Note about the collection : </span>
<xsl:for-each select="marc:datafield[@tag=308]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=310]">
 <span class="results_summary">
 <span class="label">Note about the availability : </span>
<xsl:for-each select="marc:datafield[@tag=310]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=311]">
 <span class="results_summary">
 <span class="label">Note about the links : </span>
<xsl:for-each select="marc:datafield[@tag=311]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=312]">
 <span class="results_summary">
 <span class="label">Note about the titles : </span>
<xsl:for-each select="marc:datafield[@tag=312]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=314]">
 <span class="results_summary">
 <span class="label">Note about the responsability : </span>
<xsl:for-each select="marc:datafield[@tag=314]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=315]">
 <span class="results_summary">
 <span class="label">Note about the source : </span>
<xsl:for-each select="marc:datafield[@tag=315]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<!--316 Note sur l'exemplaire-->
<p>
<xsl:for-each select="marc:datafield[@tag=316]">
 <span class="results_summary">
 <span class="label">Note about the item : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='5'])">
<xsl:value-of select="marc:subfield[@code='5']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<!--317 Note sur la provenance-->
<p>
<xsl:for-each select="marc:datafield[@tag=317]">
 <span class="results_summary">
 <span class="label">Note about the provenance : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='5'])">
<xsl:value-of select="marc:subfield[@code='5']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:for-each select="marc:datafield[@tag=320]">
 <span class="results_summary">
 <span class="label">Note about the bibliographies and the index : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='u'])">
<xsl:value-of select="marc:subfield[@code='u']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:for-each select="marc:datafield[@tag=321]">
 <span class="results_summary">
 <span class="label">Note about the index, extract : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='u'])">
<xsl:value-of select="marc:subfield[@code='u']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:for-each select="marc:datafield[@tag=322]">
 <span class="results_summary">
 <span class="label">Note about the music : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='u'])">
<xsl:value-of select="marc:subfield[@code='u']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:for-each select="marc:datafield[@tag=323]">
 <span class="results_summary">
 <span class="label">Note about the actors : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='u'])">
<xsl:value-of select="marc:subfield[@code='u']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:for-each select="marc:datafield[@tag=324]">
 <span class="results_summary">
 <span class="label">Note about original reproduction : </span>
<xsl:if test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="(marc:subfield[@code='u'])">
<xsl:value-of select="marc:subfield[@code='u']"/>
<xsl:text>. </xsl:text>
</xsl:if>
</span>
</xsl:for-each>
</p>
<p>
<xsl:if test="marc:datafield[@tag=325]">
 <span class="results_summary">
 <span class="label">Note about reproduction : </span>
<xsl:for-each select="marc:datafield[@tag=325]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
</xsl:for-each>
</span>
</xsl:if>
</p>
<p>
 <xsl:if test="marc:datafield[@tag=327]">
  <span class="results_summary">
 <span class="label">Note of content : </span>
 <xsl:for-each select="marc:datafield[@tag=327]">
 <xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> | </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
  </xsl:for-each>
</span>
 </xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=326]">
  <span class="results_summary">
 <span class="label">Periodicity : </span>
 <xsl:for-each select="marc:datafield[@tag=326]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 </p>
 <p>
 <xsl:if test="marc:datafield[@tag=328]">
  <span class="results_summary">
 <span class="label">Note of thesis : </span>
 <xsl:for-each select="marc:datafield[@tag=328]">
<xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> . </xsl:text></xsl:when><xsl:otherwise><xsl:text> - </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=336]">
  <span class="results_summary">
 <span class="label">Type electronic source : </span>
 <xsl:for-each select="marc:datafield[@tag=336]">
<xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> . </xsl:text></xsl:when><xsl:otherwise><xsl:text> - </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
</p>
<p>
<xsl:if test="marc:datafield[@tag=337]">
  <span class="results_summary">
 <span class="label">Note of academic thesis : </span>
 <xsl:for-each select="marc:datafield[@tag=337]">
<xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> . </xsl:text></xsl:when><xsl:otherwise><xsl:text> - </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
</p>
</div>



<div id="tab-content-330">
<xsl:if test="marc:datafield[@tag=330]">
<span class="results_summary">
<span class="label">Abstract : </span>
<xsl:for-each select="marc:datafield[@tag=330]">
<xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <br></br><xsl:text> </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
</xsl:for-each>
</span>
</xsl:if>
</div>

<!--onglet Table des matières-->
<div id="tab-content-359">
<xsl:for-each select="marc:datafield[@tag=359]">
 <xsl:for-each select="node()">
<dd><xsl:value-of select="."/></dd>
 </xsl:for-each> </xsl:for-each>
</div>

<xsl:if test="marc:datafield[@tag=610]">
<span class="results_summary">
<span class="label">Subject : </span>
<xsl:for-each select="marc:datafield[@tag=610]">
<xsl:choose>
<xsl:when test="contains(marc:subfield[@code='a'],'(')">
<a>
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=su,phr:
<xsl:value-of select="marc:subfield[@code='a']"/>-->
<xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
<xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
<xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='a']"/>
</a>
</xsl:when>
<xsl:otherwise>
<a>
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=su,phr:<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='a']"/>
</a>
</xsl:otherwise>
</xsl:choose>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text> </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text> .  </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>


<!--<xsl:if test="marc:datafield[@tag=902]">
<span class="results_summary">
<span class="label">Level :</span> 
 <xsl:for-each select="marc:datafield[@tag=902]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text> </xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> .  </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>-->

<!--<xsl:if test="marc:datafield[@tag=903]">
<span class="results_summary">
<span class="label">Domain : </span>
<xsl:for-each select="marc:datafield[@tag=903]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:value-of select="marc:subfield[@code='p']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text> </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>; </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>-->

<!--
<xsl:if test="marc:datafield[@tag=464]">
<div class="panel panel-default results_summary">
<div class="panel-heading" style="background-color:#FAFAFA">
Content :
</div>
<div class="panel-body" style="height:190px;overflow:auto;background-color:#FAFAFA">
<xsl:for-each select="marc:datafield[@tag=464]">
<p>
<xsl:choose>
<xsl:when test="marc:subfield[@code='u']">
<a>
<xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
<xsl:attribute name="title"><xsl:text>play-pause</xsl:text></xsl:attribute>
<xsl:attribute name="class"><xsl:text>sm2_button</xsl:text></xsl:attribute>
<xsl:text>play-pause</xsl:text>
<img id="play" width="18" height="18"><xsl:attribute name="src">/public/images/play.png</xsl:attribute></img>
</a>
</xsl:when>
<xsl:otherwise>
<img id="noplay" width="18" height="18"><xsl:attribute name="src">/public/images/noplay.png</xsl:attribute></img>
</xsl:otherwise>
</xsl:choose>
<xsl:text> - </xsl:text>
<xsl:if test="marc:subfield[@code='h']">
<xsl:value-of select="marc:subfield[@code='h']"/><xsl:text> - </xsl:text>
</xsl:if>
<xsl:choose>
<xsl:when test="marc:subfield[@code='t']"><xsl:value-of select="marc:subfield[@code='t']"/></xsl:when>
<xsl:when test="marc:subfield[@code='z']"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:when>
<xsl:otherwise>Titre inconnu</xsl:otherwise>
</xsl:choose>
<xsl:if test="marc:subfield[@code='a']">
<i>
<xsl:for-each select="marc:subfield[@code='a']">
<xsl:text> - </xsl:text><xsl:value-of select="."/>
</xsl:for-each>
</i>
</xsl:if>
</p>
</xsl:for-each>
</div>
</div>
</xsl:if>
-->


<!--Etat de collection-->
<xsl:if test="marc:datafield[@tag=923]">
    <dt class="prolabelxslt">Summary of collections</dt>
         <xsl:for-each select="marc:datafield[@tag=923]">
 <xsl:if test="marc:subfield[@code='r']">
            <xsl:if test="marc:subfield[@code='b']">
              <dd>
              <xsl:if test="marc:subfield[@code='b']">
                        <xsl:call-template name="RCR">
                            <xsl:with-param name="code" select="marc:subfield[@code='b']"/>
                        </xsl:call-template>
                  </xsl:if>
                      <xsl:if test="marc:subfield[@code='r']">
                  <xsl:text> : </xsl:text>
                  <span class="statutdispo">
                                <xsl:value-of select="marc:subfield[@code='r']"/>
                  </span>
                      </xsl:if>
              </dd>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='W']">
              <dd>
                <span class="profctxslt">
                  <xsl:text>Missing : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='W']"/>
                </span>
              </dd>
            </xsl:if>
                        <xsl:if test="marc:subfield[@code='Z']">
              <dd>
                <span class="profctxslt">
                  <xsl:text>Notes : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='Z']"/>
                </span>
              </dd>
            </xsl:if>
<xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='c'] or marc:subfield[@code='d']">
              <dd>
                <span class="profctxslt">
                <xsl:if test="marc:subfield[@code='a']">
                  <xsl:text>Callnumber : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='a']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='c']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='a']">
                        <xsl:text> ; Localisation : </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>Localisation : </xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='c']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='d']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='a'] or marc:subfield[@code='d']">
                        <xsl:text> ; </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='d']" />
                </xsl:if>
              </span>
              </dd>
            </xsl:if>
 </xsl:if>
         </xsl:for-each>
                  <xsl:for-each select="marc:datafield[@tag=930]">
                        <xsl:if test="marc:subfield[@code='z'] or marc:subfield[@code='p']">
                        <dd>
                       <!--<span class="profctxslt">-->
                        <span class="profctxslt">
                                <xsl:text>Conservation : </xsl:text>
                                        <xsl:value-of select="marc:subfield[@code='z']" />
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="marc:subfield[@code='p']" />
                                        <xsl:text>)</xsl:text>
                        </span>
                        </dd>
                        </xsl:if>
                  </xsl:for-each>
</xsl:if>

<xsl:if test="marc:datafield[@tag=924]">
    <dt class="prolabelxslt">Missing numbers</dt>
         <xsl:for-each select="marc:datafield[@tag=924]">
 <xsl:if test="marc:subfield[@code='r']">
            <xsl:if test="marc:subfield[@code='b']">
              <dd>
              <xsl:if test="marc:subfield[@code='b']">
                        <xsl:call-template name="RCR">
                            <xsl:with-param name="code" select="marc:subfield[@code='b']"/>
                        </xsl:call-template>
                  </xsl:if>
                      <xsl:if test="marc:subfield[@code='r']">
                  <xsl:text> : </xsl:text>
                  <span class="statutdispo">
                                <xsl:value-of select="marc:subfield[@code='r']"/>
                  </span>
                      </xsl:if>
              </dd>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='W']">
              <dd>
                <span class="profctxslt">
                  <xsl:text>Lacunes : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='W']"/>
                </span>
              </dd>
            </xsl:if>
                        <xsl:if test="marc:subfield[@code='Z']">
              <dd>
                <span class="profctxslt">
                  <xsl:text>Notes : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='Z']"/>
                </span>
              </dd>
            </xsl:if>
<xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='c'] or marc:subfield[@code='d']">
              <dd>
                <span class="profctxslt">
                <xsl:if test="marc:subfield[@code='a']">
                  <xsl:text>Callnumber : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='a']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='c']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='a']">
                        <xsl:text> ; Localisation : </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>Localisation : </xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='c']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='d']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='a'] or marc:subfield[@code='d']">
                        <xsl:text> ; </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='d']" />
                </xsl:if>
              </span>
              </dd>
            </xsl:if>
 </xsl:if>
         </xsl:for-each>
                  <xsl:for-each select="marc:datafield[@tag=930]">
                        <xsl:if test="marc:subfield[@code='z'] or marc:subfield[@code='p']">
                        <dd>
                       <!--<span class="profctxslt">-->
                        <span class="profctxslt">
                                <xsl:text>Conservation : </xsl:text>
                                        <xsl:value-of select="marc:subfield[@code='z']" />
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="marc:subfield[@code='p']" />
                                        <xsl:text>)</xsl:text>
                        </span>
                        </dd>
                        </xsl:if>
                  </xsl:for-each>
</xsl:if>






<xsl:for-each select="marc:datafield[@tag=600]">
<span class="results_summary">
<span class="label">Subject - name : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>+</xsl:text> <xsl:if test="marc:subfield[@code='b']!=''"><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='d']">
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='c']">
<xsl:text>, </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='c']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='f']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text>) </xsl:text>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element>
</xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots-->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b']!=''"><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if>
<xsl:if test="marc:subfield[@code='c'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='c']!=''"><xsl:value-of select="marc:subfield[@code='c']"/></xsl:if>
<xsl:if test="marc:subfield[@code='d'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='d']!=''"><xsl:value-of select="marc:subfield[@code='d']"/></xsl:if><xsl:if test="marc:subfield[@code='x'][1] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=601]">
<span class="results_summary">
<span class="label">Subject - Collectivities : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='b'][2]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:element>
</xsl:if>

<xsl:if test="marc:subfield[@code='b'][3]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:element>
</xsl:if>

</xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>

<xsl:choose>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>

<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='b'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][2]!=''"><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='b'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][3]!=''"><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=602]">
<span class="results_summary">
<span class="label">Subject –  Name of family : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='b'][2]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:element>
</xsl:if>

<xsl:if test="marc:subfield[@code='b'][3]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:element>
</xsl:if>

       </xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>

<xsl:choose>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>

<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='t']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='b'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][2]!=''"><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='b'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][3]!=''"><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='t']!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='t']!=''"><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=604]">
<span class="results_summary">
<span class="label">Subject –  Author/Title : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='b'][2]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:element>
</xsl:if>

<xsl:if test="marc:subfield[@code='b'][3]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:element>
</xsl:if>

       </xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>

<xsl:choose>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>

<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='t']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='t']!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='t']!=''"><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=605]">
<span class="results_summary">
<span class="label">Subject –  Uniform title : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='b'][2]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:element>
</xsl:if>

<xsl:if test="marc:subfield[@code='b'][3]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:element>
</xsl:if>

       </xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>

<xsl:choose>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>

<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='t']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='t']!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='t']!=''"><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>




<xsl:for-each select="marc:datafield[@tag=606]">
<span class="results_summary">
<span class="label">Subject : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='j']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='j'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='j'][1]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element>
</xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='y'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][3]"/></xsl:element>
</xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=607]">
<span class="results_summary">
<span class="label">Subject - geographical : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element>
</xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='y'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][3]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y'][4]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][4]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][4]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y'][5]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][5]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][5]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y'][6]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y'][6]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][6]"/></xsl:element>
</xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'][1] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y'][1] !=''"><xsl:value-of select="marc:subfield[@code='y'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'][2] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y'][2] !=''"><xsl:value-of select="marc:subfield[@code='y'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'][3] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y'][3] !=''"><xsl:value-of select="marc:subfield[@code='y'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span> 
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=608]">
<span class="results_summary">
<span class="label">Subject - Form, physical types : </span>
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='a']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='b']">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='b'][2]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][2]"/></xsl:element>
</xsl:if>

<xsl:if test="marc:subfield[@code='b'][3]">
<xsl:text>. </xsl:text>
<xsl:element name="a">
        <xsl:attribute name="href">
     /cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='b'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='b'][3]"/></xsl:element>
</xsl:if>

       </xsl:if>
<xsl:if test="marc:subfield[@code='c']">
<xsl:text>. </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>

<xsl:choose>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f']) and (marc:subfield[@code='e'])">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d']) and (marc:subfield[@code='f'])">
 <xsl:text> ( </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>

<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='t']">
<xsl:text> -- </xsl:text>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='x']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
<xsl:if test="marc:subfield[@code='x'][2]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][2]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='x'][3]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:element></xsl:if>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='y']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='y']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y']"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='a'] and  marc:subfield[@code='z']">
<xsl:text> -- </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=su,phr&amp;q=<xsl:value-of select="marc:subfield[@code='z']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='z']"/></xsl:element>
</xsl:if>
<xsl:text> | </xsl:text>
<!-- recherche sur tous les mots -->
<xsl:element name="a">
<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=su&amp;q=
<xsl:choose>
        <xsl:when test="contains(marc:subfield[@code='a'],'(')">
          <xsl:value-of select="substring-before(marc:subfield[@code='a'], '(')" />
          <xsl:value-of select="substring-before(substring-after(marc:subfield[@code='a'], '('), ')')" />
          <xsl:value-of select="substring-after(marc:subfield[@code='a'], ')')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="marc:subfield[@code='a']" />
        </xsl:otherwise>
      </xsl:choose> 
<xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='b'][1]!=''"><xsl:value-of select="marc:subfield[@code='b'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][1]!=''"><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][3]!=''"><xsl:value-of select="marc:subfield[@code='x'][3]"/></xsl:if>
<xsl:if test="marc:subfield[@code='t']!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='t']!=''"><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Search on all subject words</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">615</xsl:with-param>
 <xsl:with-param name="label">Category of subject</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">616</xsl:with-param>
 <xsl:with-param name="label">Mark</xsl:with-param>
 </xsl:call-template>


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

<!--
<xsl:if test="marc:datafield[@tag=901]">

 <span class="results_summary">
<span class="label">Type:</span>
 <xsl:for-each select="marc:datafield[@tag=901]">
 <xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise><xsl:text>, </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
-->

 <!-- 780 -->
 <xsl:if test="marc:datafield[@tag=780]">
 <xsl:for-each select="marc:datafield[@tag=780]">
 <li>
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <strong>Continue:</strong>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <strong>Continue en partie:</strong>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <strong>Remplace :</strong>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <strong>Remplace partiellement :</strong>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <strong>Formé par la réunion de ... et: ...</strong>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <strong>Absorbé:</strong>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <strong>Absorbé en partie:</strong>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <strong>Séparé de :</strong>
 </xsl:when>
 </xsl:choose>

 <xsl:variable name="f780">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">à</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f780, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f780, '()', '')"/>
 </a>
 </li>

 <xsl:choose>
 <xsl:when test="@ind1=0">
 <li><xsl:value-of select="marc:subfield[@code='n']"/></li>
 </xsl:when>
 </xsl:choose>

 </xsl:for-each>
 </xsl:if>

 <!-- 785 -->
 <xsl:if test="marc:datafield[@tag=785]">
 <xsl:for-each select="marc:datafield[@tag=785]">
 <li>
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <strong>Continué par :</strong>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <strong>Continué partiellement par :</strong>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <strong>Remplacé par :</strong>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <strong>Partiellement remplacé par :</strong>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <strong>Absorbé par:</strong>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <strong>Absorbé partiellement par:</strong>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <strong>Eclater de ... à ... :</strong>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <strong>Fusionné avec ... pour former ...</strong>
 </xsl:when>
 <xsl:when test="@ind2=8">
 <strong>Redevient:</strong>
 </xsl:when>
 </xsl:choose>
 <xsl:variable name="f785">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">à</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>

 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f785, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f785, '()', '')"/>
 </a>

 </li>
 </xsl:for-each>
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
