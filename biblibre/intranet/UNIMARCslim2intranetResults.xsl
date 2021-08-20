<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
<xsl:import href="UNIMARCslimUtils.xsl"/>
<xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
<xsl:key name="item-by-status" match="items:item" use="items:status"/>
<xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>

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
<xsl:variable name="renvoi" select="marc:datafield[@tag=700]/@ind1"/>
<xsl:variable name="type_doc" select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>

<xsl:if test="marc:datafield[@tag=200]">
<xsl:for-each select="marc:datafield[@tag=200]">
<a>
<xsl:attribute name="href">
<xsl:call-template name="buildBiblioDefaultViewURL">
<xsl:with-param name="IntranetBiblioDefaultView">
<xsl:value-of select="$IntranetBiblioDefaultView"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="$biblionumber"/>
</xsl:attribute>
<xsl:attribute name="class">title</xsl:attribute>
<xsl:variable name="title" select="marc:subfield[@code='a']"/>
<xsl:variable name="ntitle"
select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
<xsl:value-of select="$ntitle" />
</a>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='b']">
<xsl:text> [</xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
<xsl:text>]</xsl:text>
</xsl:if>
<xsl:if test="marc:subfield[@code='h']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='i']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='i']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='f']">
<xsl:text> / </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text> </xsl:text>
</xsl:for-each>
</xsl:if>

<xsl:if test="marc:datafield[@tag=700]">
<xsl:if test="not(contains($renvoi,'z'))">
<span class="results_summary author main_author">
<span class="label">Auteur : </span>
<xsl:for-each select="marc:datafield[@tag=700]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='b']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='f']">
<xsl:text> ( </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
<xsl:text> ) </xsl:text>
</xsl:if>
<xsl:text> </xsl:text>
</xsl:for-each>
</span>
</xsl:if>
</xsl:if>


<xsl:if test="marc:datafield[@tag=710]">
<span class="results_summary author corporate_main_author">
<span class="label">Collectivité Auteur : </span>
<xsl:for-each select="marc:datafield[@tag=710]">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='b']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='b']"/>
</xsl:if>
</xsl:for-each>
</span>
</xsl:if>

<!--Titre de serie - autorité 461-->
<!--<xsl:call-template name="tag_461" />-->

<!--Titre de série - non autorité 461-->
<xsl:call-template name="tag_461bis" />

<!--Titre  dépouillé 463-->
<xsl:call-template name="tag_463" />

<xsl:if test="contains($type_doc,'Revue')">
<xsl:call-template name="tag_462" />
</xsl:if>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">412</xsl:with-param>
<xsl:with-param name="label">Est un extrait ou tiré à part de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">413</xsl:with-param>
<xsl:with-param name="label">A pour extrait ou tiré à part</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">421</xsl:with-param>
<xsl:with-param name="label">A pour supplément</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">423</xsl:with-param>
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

<!--masqué car risque de longues listes de titres en résultats-->
<!--<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">464</xsl:with-param>
<xsl:with-param name="label">Composante</xsl:with-param>
</xsl:call-template>-->

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">470</xsl:with-param>
<xsl:with-param name="label">Document analysé</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">482</xsl:with-param>
<xsl:with-param name="label">Relié à la suite de</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tag_4xx">
<xsl:with-param name="tag">488</xsl:with-param>
<xsl:with-param name="label">Autre type de relation</xsl:with-param>
</xsl:call-template>

<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
  <span class="results_summary typedoc">
    <span class="label">Catégorie de document : </span>
    <xsl:for-each select="marc:datafield[@tag=099]/marc:subfield[@code='t']">
      <xsl:value-of select="."/>
      <xsl:if test="not(position()=last())"><xsl:text> ; </xsl:text></xsl:if>
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

<!--Collection autorité 410-->
<!--<xsl:for-each select="marc:datafield[@tag=410]">
<span class="results_summary">
<span class="label">Collection Autorité : </span>
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


<!--Etat de collection-->
<xsl:if test="marc:datafield[@tag=923]">
    <dt class="prolabelxslt">État des collections</dt>
          <xsl:for-each select="marc:datafield[@tag=923]">
<xsl:if test="marc:subfield[@code='r']">
            <dd>
              <xsl:if test="marc:subfield[@code='b']">
                        <xsl:call-template name="RCR">
                              <xsl:with-param name="code" select="marc:subfield[@code='b']"/>
                        </xsl:call-template>
                  </xsl:if>
                      <xsl:if test="marc:subfield[@code='r']">
                  <xsl:text> </xsl:text>
                  <span class="statutdispo">
                                <xsl:value-of select="marc:subfield[@code='r']"/>
                  </span>
                      </xsl:if>
                <xsl:if test="marc:subfield[@code='a']">
                  <xsl:text> (Cote : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='a']" />
                  <xsl:text>)</xsl:text>
                </xsl:if>

                <xsl:if test="marc:subfield[@code='c']">
                  <xsl:text> Localisation : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='c']" />

                </xsl:if>

              </dd>
</xsl:if>

          </xsl:for-each>
</xsl:if>

<xsl:if test="marc:datafield[@tag=856]/marc:subfield[@code='u']">
  <span class="results_summary online_resources">
    <span class="label">Online resources : </span>
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
<xsl:if test="not(contains($url,'http:')) and not (contains($url,'https:'))">
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


<!--public 995$q-->
<!--
<xsl:call-template name="public" />
-->


<!--Fonds  995h-->
<!--
<xsl:call-template name="fonds" />
-->


</xsl:template>

</xsl:stylesheet>
