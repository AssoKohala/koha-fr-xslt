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
<xsl:with-param name="label">Est un extrait ou tiré à part de</xsl:with-param>
</xsl:call-template>

<!--413 Extrait ou tiré à part-->
<xsl:for-each select="marc:datafield[@tag=413]">
<span class="results_summary">
<span class="label">A pour extrait ou tiré à part : </span>
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
<xsl:with-param name="label">A pour supplément</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">422</xsl:with-param>
<xsl:with-param name="label">Est un supplément de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">423</xsl:with-param>
<xsl:with-param name="label">Est publié avec</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">424</xsl:with-param>
<xsl:with-param name="label">Est mis à jour par</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">430</xsl:with-param>
<xsl:with-param name="label">Suite de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">431</xsl:with-param>
<xsl:with-param name="label">Succède après scission à</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">432</xsl:with-param>
<xsl:with-param name="label">Remplace</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">433</xsl:with-param>
<xsl:with-param name="label">Remplace partiellement</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">434</xsl:with-param>
<xsl:with-param name="label">Absorbe</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">435</xsl:with-param>
<xsl:with-param name="label">Absorbe partiellement</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">436</xsl:with-param>
<xsl:with-param name="label">Fusion de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">437</xsl:with-param>
<xsl:with-param name="label">Suite partielle de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">440</xsl:with-param>
<xsl:with-param name="label">Devient</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">441</xsl:with-param>
<xsl:with-param name="label">Devient partiellement</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">442</xsl:with-param>
<xsl:with-param name="label">Remplacé par</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">443</xsl:with-param>
<xsl:with-param name="label">Remplacé partiellement par</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">444</xsl:with-param>
<xsl:with-param name="label">Absorbé par</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">447</xsl:with-param>
<xsl:with-param name="label">Fusionné avec...pour former</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">451</xsl:with-param>
<xsl:with-param name="label">A pour autre édition, sur le même support</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">452</xsl:with-param>
<xsl:with-param name="label">A pour autre édition, sur un support différent</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">453</xsl:with-param>
<xsl:with-param name="label">Traduit sous le titre</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">454</xsl:with-param>
<xsl:with-param name="label">Est une traduction de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">455</xsl:with-param>
<xsl:with-param name="label">Est une reproduction de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">456</xsl:with-param>
<xsl:with-param name="label">Est reproduit comme</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">464</xsl:with-param>
<xsl:with-param name="label">Composante</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">470</xsl:with-param>
<xsl:with-param name="label">Document analysé</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">481</xsl:with-param>
<xsl:with-param name="label">Est aussi relié dans ce volume</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">482</xsl:with-param>
<xsl:with-param name="label">Relié à la suite de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">488</xsl:with-param>
<xsl:with-param name="label">Autres oeuvres en liaison</xsl:with-param>
</xsl:call-template>

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

<!--Titre de serie autorite 461-->
<!--<xsl:call-template name="tag_461" />-->

<!---Titre de serie non autorite 461-->
<xsl:call-template name="tag_461bis" />

<!--Titre dépouillé 463-->
<xsl:call-template name="tag_463" />


<xsl:if test="marc:datafield[@tag=531]"> 
<span class="results_summary">
<span class="label">Titre abrégé : </span>
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
<span class="label">Titre ajouté par le catalogueur : </span>
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
<span class="label">Titre traduit par le catalogueur : </span>
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
    <span class="label">Catégorie de document : </span>
    <xsl:for-each select="marc:datafield[@tag=099]/marc:subfield[@code='t']">
      <xsl:value-of select="."/>
      <xsl:if test="not(position()=last())"><xsl:text> ; </xsl:text></xsl:if>
    </xsl:for-each>
  </span>
</xsl:if>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">700</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">710</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">701</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">702</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">711</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_71x">
 <xsl:with-param name="tag">712</xsl:with-param>
 <xsl:with-param name="label">Auteur(s)</xsl:with-param>
 </xsl:call-template>

<xsl:if test="marc:datafield[@tag=101]"> 
<span class="results_summary">
<span class="label">Langue(s) : </span>
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
<span class="label">Pays : </span>
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
<span class="label">Prix : </span>
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
<span class="label">Appartient à la collection : </span>
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
<span class="label">Titre uniforme : </span>
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
<span class="label">Titre de forme : </span>
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
<span class="label">Autre(s) titre(s) : </span>
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
<span class="label">Autre classification :  </span>
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
 <span class="label">Note générale : </span>
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
 <span class="label">Note sur la description bibliographique : </span>
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
 <span class="label">Note sur le titre et les responsabilités : </span>
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
 <span class="label">Note sur l'édition et l'histoire : </span>
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
 <span class="label">Note sur la publication, production : </span>
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
 <span class="label">Note sur la description matérielle : </span>
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
 <span class="label">Note sur la collection : </span>
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
 <span class="label">Note sur la disponiblité : </span>
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
 <span class="label">Note sur les zones de liens : </span>
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
 <span class="label">Note sur les titres associés : </span>
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
 <span class="label">Note sur la responsabilité : </span>
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
 <span class="label">Note relative à la ressource : </span>
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
 <span class="label">Note sur l'exemplaire : </span>
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
 <span class="label">Note sur la provenance : </span>
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
 <span class="label">Note sur les bibliographies et les index : </span>
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
 <span class="label">Note sur les  index, extrait, citations publiés séparément : </span>
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
 <span class="label">Note sur le générique : </span>
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
 <span class="label">Note sur les interprètes : </span>
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
 <span class="label">Note sur l’original reproduit : </span>
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
 <span class="label">Note sur la reproduction : </span>
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
 <span class="label">Note de contenu : </span>
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
 <span class="label">Périodicité : </span>
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
 <span class="label">Note de thèse : </span>
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
 <span class="label">Type de ressources électronique : </span>
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
 <span class="label">Note de thèses et écrits académiques : </span>
 <xsl:for-each select="marc:datafield[@tag=337]">
<xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> . </xsl:text></xsl:when><xsl:otherwise><xsl:text> - </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>
</p>


<xsl:if test="marc:datafield[@tag=330]">
<span class="results_summary">
<span class="label">Résumé : </span>
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

<!--<xsl:for-each select="marc:datafield[@tag=359]">
 <xsl:for-each select="node()">
<dd><xsl:value-of select="."/></dd>
</xsl:for-each> </xsl:for-each>-->

<xsl:if test="marc:datafield[@tag=359]">
<xsl:for-each select="marc:datafield[@tag=359]">
<xsl:for-each select="marc:subfield">
<xsl:choose>
 <xsl:when test="@code='b'"><dt class="col-sm-4"><xsl:value-of select="text()"/></dt></xsl:when>
 <xsl:when test="@code='c'"><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></xsl:when>
 <xsl:when test="@code='d'"><ul><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></ul></xsl:when>
 <xsl:when test="@code='e'"><ul><ul><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></ul></ul></xsl:when>
 <xsl:when test="@code='f'"><ul><ul><dd class="col-sm-4"> <xsl:value-of select="text()"/></dd></ul></ul></xsl:when>
 <xsl:when test="@code='g'"><ul><ul><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></ul></ul></xsl:when>
 <xsl:when test="@code='h'"><ul><ul><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></ul></ul></xsl:when>
 <xsl:when test="@code='i'"><ul><ul><dd class="col-sm-4"><xsl:value-of select="text()"/></dd></ul></ul></xsl:when>
 <xsl:when test="@code='p'"><span id="page" class="col-sm-2" style="position:absolute;margin-left:600px;"> <xsl:text>.....</xsl:text><xsl:value-of select="text()"/></span></xsl:when>
</xsl:choose>
</xsl:for-each>
</xsl:for-each>
</xsl:if>


</div>



<xsl:if test="marc:datafield[@tag=610]">
<span class="results_summary">
<span class="label">Sujet : </span>
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
<span class="label">Niveau de lecture :</span> 
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
<span class="label">Genre : </span>
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
Contenu :
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
    <dt class="prolabelxslt">État des collections</dt>
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
                  <xsl:text>Cote : </xsl:text>
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
    <dt class="prolabelxslt">État des lacunes</dt>
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
                  <xsl:text>Cote : </xsl:text>
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
<span class="label">Sujet - Nom de personne : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=601]">
<span class="results_summary">
<span class="label">Sujet - Collectivité : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=602]">
<span class="results_summary">
<span class="label">Sujet –  Nom de famille : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=604]">
<span class="results_summary">
<span class="label">Sujet –  Auteur/Titre : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=605]">
<span class="results_summary">
<span class="label">Sujet –  Titre uniforme : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>




<xsl:for-each select="marc:datafield[@tag=606]">
<span class="results_summary">
<span class="label">Sujets - Nom commun : </span>
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
<xsl:if test="marc:subfield[@code='x'][2]!=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='x'][2]!=''"> <xsl:value-of select="marc:subfield[@code='x'][2]"/></xsl:if>
<xsl:if test="marc:subfield[@code='y'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='y']!=''"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:if>
<xsl:if test="marc:subfield[@code='z'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='z']!=''"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:if>
<xsl:if test="marc:subfield[@code='j'] !=''"><xsl:text>+</xsl:text></xsl:if> <xsl:if test="marc:subfield[@code='j']!=''"><xsl:value-of select="marc:subfield[@code='j']"/></xsl:if>
</xsl:attribute>
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=607]">
<span class="results_summary">
<span class="label">Sujet - Nom géographique : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span> 
</xsl:for-each>


<xsl:for-each select="marc:datafield[@tag=608]">
<span class="results_summary">
<span class="label">Sujet - Forme, genre, caractéristiques physiques : </span>
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
<xsl:attribute name="title">Lancer une recherche sur les mots sujet</xsl:attribute>
<i class="fa fa-search"></i>
</xsl:element>
</span>
</xsl:for-each>



 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">615</xsl:with-param>
 <xsl:with-param name="label">Catégorie de sujet</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">616</xsl:with-param>
 <xsl:with-param name="label">Marque commerciale</xsl:with-param>
 </xsl:call-template>


<xsl:if test="marc:datafield[@tag=856]/marc:subfield[@code='u']">
<span class="results_summary">
<span class="label">Ressources en ligne : </span>
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
<span class="label">Genre : </span>
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
