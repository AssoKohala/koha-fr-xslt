<?xml version='1.0'?>

<!DOCTYPE stylesheet>

<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="marc items str">

 <xsl:template name="datafield">
 <xsl:param name="tag"/>
 <xsl:param name="ind1"><xsl:text> </xsl:text></xsl:param>
 <xsl:param name="ind2"><xsl:text> </xsl:text></xsl:param>
 <xsl:param name="subfields"/>
 <xsl:element name="datafield">
 <xsl:attribute name="tag">
 <xsl:value-of select="$tag"/>
 </xsl:attribute>
 <xsl:attribute name="ind1">
 <xsl:value-of select="$ind1"/>
 </xsl:attribute>
 <xsl:attribute name="ind2">
 <xsl:value-of select="$ind2"/>
 </xsl:attribute>
 <xsl:copy-of select="$subfields"/>
 </xsl:element>
 </xsl:template>

 <xsl:template name="subfieldSelect">
 <xsl:param name="codes"/>
 <xsl:param name="delimeter"><xsl:text> </xsl:text></xsl:param>
 <xsl:param name="subdivCodes"/>
 <xsl:param name="subdivDelimiter"/>
 <xsl:param name="urlencode"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($codes, @code)">
 <xsl:if test="contains($subdivCodes, @code)">
 <xsl:value-of select="$subdivDelimiter"/>
 </xsl:if>
 <xsl:value-of select="text()"/><xsl:value-of select="$delimeter"/>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$urlencode=1">
 <xsl:value-of select="str:encode-uri(substring($str,1,string-length($str)-string-length($delimeter)), true())"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="substring($str,1,string-length($str)-string-length($delimeter))"/>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:template>

 <xsl:template name="buildSpaces">
 <xsl:param name="spaces"/>
 <xsl:param name="char"><xsl:text> </xsl:text></xsl:param>
 <xsl:if test="$spaces>0">
 <xsl:value-of select="$char"/>
 <xsl:call-template name="buildSpaces">
 <xsl:with-param name="spaces" select="$spaces - 1"/>
 <xsl:with-param name="char" select="$char"/>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="buildBiblioDefaultViewURL">
 <xsl:param name="BiblioDefaultView"/>
 <xsl:choose>
 <xsl:when test="$BiblioDefaultView='normal'">
 <xsl:text>/cgi-bin/koha/opac-detail.pl?biblionumber=</xsl:text>
 </xsl:when>
 <xsl:when test="$BiblioDefaultView='isbd'">
 <xsl:text>/cgi-bin/koha/opac-ISBDdetail.pl?biblionumber=</xsl:text>
 </xsl:when>
 <xsl:when test="$BiblioDefaultView='marc'">
 <xsl:text>/cgi-bin/koha/opac-MARCdetail.pl?biblionumber=</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>/cgi-bin/koha/opac-detail.pl?biblionumber=</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:template>


 <xsl:template name="chopPunctuation">
 <xsl:param name="chopString"/>
 <xsl:variable name="length" select="string-length($chopString)"/>
 <xsl:choose>
 <xsl:when test="$length=0"/>
 <xsl:when test="contains('.:,;/ ', substring($chopString,$length,1))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="substring($chopString,1,$length - 1)"/>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="not($chopString)"/>
 <xsl:otherwise><xsl:value-of select="$chopString"/></xsl:otherwise>
 </xsl:choose>
 <xsl:text> </xsl:text>
 </xsl:template>

 <xsl:template name="addClassRtl">
 <xsl:variable name="lang" select="marc:subfield[@code='7']" />
 <xsl:if test="$lang = 'ha' or $lang = 'Hebrew' or $lang = 'fa' or $lang = 'Arabe'">
 <xsl:attribute name="class">rtl</xsl:attribute>
 </xsl:if>
 </xsl:template>

 <xsl:template name="tag_title">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary {$spanclass}">
 <xsl:call-template name="addClassRtl" />
 <span class="label">
 <xsl:value-of select="$label"/>
 <xsl:text>: </xsl:text>
 </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:if test="not (position() = 1)"><xsl:text> • </xsl:text></xsl:if>
 <xsl:value-of select="marc:subfield[@code='a']" />
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:text> </xsl:text>
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
 <xsl:if test="marc:subfield[@code='z']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='z']"/>
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

 <xsl:template name="tag_comma">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary {$spanclass}">
 <xsl:call-template name="addClassRtl" />
 <span class="label">
 <xsl:value-of select="$label"/>: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="position()>1">
 <xsl:text>, </xsl:text>
 </xsl:if>
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:if test="not (position() = last())">
 <xsl:text> • </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

 <!-- Template 210-214 - Publication dans résultats de recherches-->
 <xsl:template name="tag_210-214">
 <xsl:if test="marc:datafield[@tag=210 or @tag=214]">
<span class="results_summary publication">
 <span class="label">Publication: </span>

 <xsl:for-each select="marc:datafield[@tag=210 or @tag=214]">
 <xsl:if test="not (position() = 1)"><br/></xsl:if>
 <span class="valeur">
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='a'">
 <xsl:value-of select="."/>
 <xsl:if test="position() != last()"><xsl:text>: </xsl:text></xsl:if>
 </xsl:when>    
 <xsl:when test="@code='b'">
 <xsl:value-of select="."/>
 <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when> 
 <xsl:when test="@code='c' or @code='g'">
 <a>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?idx=pb&amp;q=<xsl:value-of select="."/>
 </xsl:attribute>
 <xsl:attribute name="title"> Search for publisher "<xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:attribute>
 <xsl:value-of select="."/>
 </a>
 <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='d'">
 <xsl:value-of select="."/>
 <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

<!-- Template 210 - Publication -->
 <xsl:template name="tag_210">
 <span class="results_summary publication">
 <span class="label">Publication: </span>
 <xsl:for-each select="marc:datafield[@tag=210]">
 <span>
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='a'">
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())"><xsl:text>: </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='b'">
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='c' or @code='g'">
 <a>
 <xsl:attribute name="href">/opac-search.pl?idx=pb&amp;q=<xsl:value-of select="."/>
 </xsl:attribute>
 <xsl:attribute name="title"> Search for publisher "<xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:attribute>
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </a>
 </xsl:when>
 <xsl:when test="@code='d'">
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='6'"/>
 <xsl:when test="@code='7'"/>
 <xsl:otherwise>
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 <xsl:if test="not (position() = last())"><br/></xsl:if>
 </span>
 </xsl:for-each>
 </span>
 </xsl:template>

<!-- Template 214 - Publication -->
 <xsl:template name="tag_214">
 <xsl:for-each select="marc:datafield[@tag=214]">
 <xsl:sort select="@ind2" data-type="number" />
 <span class="results_summary publication">
 <span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=1">Production :
 </xsl:when>
 <xsl:when test="@ind2=2">Distribution: 
 </xsl:when>
 <xsl:when test="@ind2=3">Manufacture: 
 </xsl:when>
 <xsl:when test="@ind2=4">
 <xsl:choose>
 <xsl:when test="substring(marc:subfield[@code='d'],1,1)='C'">Copyright date: 
 </xsl:when>
 <xsl:when test="substring(marc:subfield[@code='d'],1,1)='P'">Protection date: 
 </xsl:when>
 <xsl:otherwise>Copyright date/ protection date: 
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 <xsl:otherwise>Publication: 
 </xsl:otherwise>
 </xsl:choose>
 </span>
 <span>
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='a'">
 <xsl:value-of select="."/>
 <xsl:if test="position() != last()"><xsl:text>: </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='b'">
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
 </xsl:when>
 <xsl:when test="@code='c'">
  <a>
 <xsl:attribute name="href">/opac-search.pl?idx=pb&amp;q=<xsl:value-of select="."/>
 </xsl:attribute>
 <xsl:attribute name="title"> Search for publisher "<xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:attribute>
 <xsl:value-of select="."/>
 </a>
 </xsl:when>
 <xsl:when test="@code='d'">
 <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
 <xsl:choose>
 <xsl:when test="substring(.,1,1)='C'">
 <xsl:value-of select="substring(.,2)"/>
 </xsl:when>
 <xsl:when test="substring(.,1,1)='P'">
 <xsl:value-of select="substring(.,2)"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="."/>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </span>
 </xsl:for-each>
 </xsl:template>

<!-- Template 215 - Description -->
 <xsl:template name="tag_215">
 <xsl:for-each select="marc:datafield[@tag=215]">
 <span class="results_summary description">
 <span class="label">Description: </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d']) and (marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>: </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text>; </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>: </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text>; </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='e']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>: </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='e']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>: </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>: </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>; </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
</xsl:choose>
</span>
 </xsl:for-each>
 </xsl:template>

<!-- Template 45x - Traductions -->
 <xsl:template name="tag_45x">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary {$spanclass}">
 <span class="label"><xsl:value-of select="$label" />: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <span>
 <xsl:call-template name="addClassRtl" />
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']">:
 <xsl:value-of select="marc:subfield[@code='e']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']"> /
 <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='v']">,
 <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </span>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

<!-- Template 455-456 - Reproductions de thèse -->
 <xsl:template name="thesisrepro">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary thesisrepro">
 <span class="label"><xsl:value-of select="$label" />: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='0']">
 <xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/catalogue/search.pl?idx=kw,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
 </xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
 </xsl:when>
 <xsl:otherwise>
 <xsl:element name="a"><xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?search.pl?phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='o']">
 <xsl:text>: </xsl:text>
 <xsl:value-of select="marc:subfield[@code='o']" />
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']">
 <xsl:text> / </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']" />
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>. </xsl:text>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='c']='[S.l.]'">[Unknown publication place]</xsl:when>
 <xsl:otherwise><xsl:value-of select="marc:subfield[@code='c']" /></xsl:otherwise>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='n']">
 <xsl:text>: </xsl:text>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='n']='[s.n.]'">[Unknown publisher]</xsl:when>
 <xsl:otherwise><xsl:value-of select="marc:subfield[@code='n']" /></xsl:otherwise>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']" />
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

<!-- Template 46x - Notices liées -->
 <xsl:template name="tag_46x">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary {$spanclass}">
 <span class="label"><xsl:value-of select="$label" />: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <span>
 <xsl:call-template name="addClassRtl" />
 <xsl:choose>
 <!-- Problème sur les 46x$9 identifié : rebond vers la mauvaise notice - Recherche désactivée le temps de corriger l'alignement des données
 <xsl:when test="marc:subfield[@code='9']">
 <xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Local-number,phr&amp;q=<xsl:value-of select="marc:subfield[@code='9']"/></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
 </xsl:when>
 -->
 <xsl:when test="marc:subfield[@code='0']">
 <xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=kw,phr&amp;q=<xsl:value-of select="marc:subfield[@code='0']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
<xsl:otherwise>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:otherwise>
</xsl:choose>
 <xsl:if test="marc:subfield[@code='e']">:
 <xsl:value-of select="marc:subfield[@code='e']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']"> /
 <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='v']">,
 <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 <xsl:if test="not (position() = last())"><xsl:text> • </xsl:text></xsl:if>
 </span>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

 <xsl:template name="tag_onesubject">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="@code='9'">
 <xsl:variable name="start" select="position()"/>
 <xsl:variable name="ends">
 <xsl:for-each select="../marc:subfield[position() &gt; $start]">
 <xsl:if test="@code=9">
 <xsl:variable name="end" select="position() + $start"/>
 <xsl:value-of select="$end"/>
 <xsl:text>,</xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:variable name="end">
 <xsl:choose>
 <xsl:when test="string-length($ends) > 0">
 <xsl:value-of select="substring-before($ends,',')"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>1000</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="display">
 <xsl:for-each select="../marc:subfield[position() &gt; $start and position() &lt; $end and @code!=2 and @code!=3]">
 <xsl:value-of select="."/>
 <xsl:if test="not(position()=last())">
 <xsl:text>, </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <a>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=an:</xsl:text>
 <xsl:value-of select="str:encode-uri(., true())"/>
 </xsl:attribute>
 <xsl:choose>
 <xsl:when test="string-length($display) &gt; 0">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="$display"/>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="."/>
 </xsl:otherwise>
 </xsl:choose>
 </a>
 <xsl:variable name="ncommas"
                 select="string-length($ends) - string-length(translate($ends, ',', ''))" />
 <xsl:if test="$ncommas &gt; 1">
 <xsl:text> -- </xsl:text>
 </xsl:if>
 </xsl:if>
 </xsl:for-each>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='a']">
 <a>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=su:</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='a'], true())"/>
 </xsl:attribute>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdfijkmnptvxyz</xsl:with-param>
 <xsl:with-param name="subdivCodes">ijknpxyz</xsl:with-param>
 <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 </xsl:when>
 <xsl:otherwise/>
 </xsl:choose>
 <xsl:if test="not(position()=last())">
 <xsl:text> | </xsl:text>
 </xsl:if>
 </xsl:template>

 <xsl:template name="tag_subject">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary subjects {$spanclass}">
 <span class="label">
 <xsl:value-of select="$label"/>
 <xsl:text>: </xsl:text>
 </span>
 <span class="value">
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:call-template name="tag_onesubject">
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </span>
 </xsl:if>
 </xsl:template>

<!-- Template 686$a - Classification géolinguistique -->
<xsl:template name="igeo">
 <xsl:param name="igeocode"/>
 <xsl:choose>
 <xsl:when test="$igeocode='0'">0 (Multidisciplinary General Documentation)</xsl:when>
 <xsl:when test="$igeocode='1'">1 (Balkan, Central and Eastern Europe)</xsl:when>
 <xsl:when test="$igeocode='1XS'">1XS (Slavic area)</xsl:when>
 <xsl:when test="$igeocode='11'">11 (North Europe)</xsl:when>
 <xsl:when test="$igeocode='11FI'">11FI (Finland)</xsl:when>
 <xsl:when test="$igeocode='12'">12 (Baltic countries)</xsl:when>
 <xsl:when test="$igeocode='12EE'">12EE (Estonia)</xsl:when>
 <xsl:when test="$igeocode='12LT'">12LT (Lithuania)</xsl:when>
 <xsl:when test="$igeocode='12LV'">12LV (Latvia)</xsl:when>
 <xsl:when test="$igeocode='13'">13 (Central Europe)</xsl:when>
 <xsl:when test="$igeocode='13XO'">13XO (Sorbian area)</xsl:when>
 <xsl:when test="$igeocode='13CZ'">13CZ (Czech Republic)</xsl:when>
 <xsl:when test="$igeocode='13HU'">13HU (Hungary)</xsl:when>
 <xsl:when test="$igeocode='13PL'">13PL (Poland)</xsl:when>
 <xsl:when test="$igeocode='13SK'">13SK (Slovakia)</xsl:when>
 <xsl:when test="$igeocode='14'">14 (Eastern Europe)</xsl:when>
 <xsl:when test="$igeocode='14BY'">14BY (Belarus)</xsl:when>
 <xsl:when test="$igeocode='14RU'">14RU (Russia)</xsl:when>
 <xsl:when test="$igeocode='14RU1'">14RU1 (Central Russia)</xsl:when>
 <xsl:when test="$igeocode='14RU2'">14RU2 (South Russia)</xsl:when>
 <xsl:when test="$igeocode='14RU3'">14RU3 (Northwest Russia)</xsl:when>
 <xsl:when test="$igeocode='14RU4'">14RU4 (Russian Far East)</xsl:when>
 <xsl:when test="$igeocode='14RU5'">14RU5 (Siberia)</xsl:when>
 <xsl:when test="$igeocode='14RU6'">14RU6 (Urals)</xsl:when>
 <xsl:when test="$igeocode='14RU7'">14RU7 (Volga country)</xsl:when>
 <xsl:when test="$igeocode='14UA'">14UA (Ukraine)</xsl:when>
 <xsl:when test="$igeocode='15'">15 (Southeast Europe)</xsl:when>
 <xsl:when test="$igeocode='15XR'">15XR (Romani area)</xsl:when>
 <xsl:when test="$igeocode='15AL'">15AL (Albania)</xsl:when>
 <xsl:when test="$igeocode='15BG'">15BG (Bulgaria)</xsl:when>
 <xsl:when test="$igeocode='15CY'">15CY (Cyprus)</xsl:when>
 <xsl:when test="$igeocode='15GR'">15GR (Greece)</xsl:when>
 <xsl:when test="$igeocode='15MD'">15MD (Moldova)</xsl:when>
 <xsl:when test="$igeocode='15MT'">15MT (Malta)</xsl:when>
 <xsl:when test="$igeocode='15RO'">15RO (Romania)</xsl:when>
 <xsl:when test="$igeocode='16'">16 (Yugoslavia)</xsl:when>
 <xsl:when test="$igeocode='16XK'">16XK (Kosovo)</xsl:when>
 <xsl:when test="$igeocode='16BA'">16BA (Bosnia and Herzegovina)</xsl:when>
 <xsl:when test="$igeocode='16HR'">16HR (Croatia)</xsl:when>
 <xsl:when test="$igeocode='16ME'">16ME (Montenegro)</xsl:when>
 <xsl:when test="$igeocode='16MK'">16MK (Macedonia)</xsl:when>
 <xsl:when test="$igeocode='16RS'">16RS (Serbia)</xsl:when>
 <xsl:when test="$igeocode='16SI'">16SI (Slovenia)</xsl:when>
 <xsl:when test="$igeocode='2'">2 (Central Asia, Middle East, North Africa)</xsl:when>
 <xsl:when test="$igeocode='21'">21 (Transcaucasia)</xsl:when>
 <xsl:when test="$igeocode='21AM'">21AM (Armenia)</xsl:when>
 <xsl:when test="$igeocode='21AZ'">21AZ (Azerbaijan)</xsl:when>
 <xsl:when test="$igeocode='21GE'">21GE (Georgia)</xsl:when>
 <xsl:when test="$igeocode='22'">22 (Central Asia)</xsl:when>
 <xsl:when test="$igeocode='22AF'">22AF (Afghanistan)</xsl:when>
 <xsl:when test="$igeocode='22KG'">22KG (Kyrgyzstan)</xsl:when>
 <xsl:when test="$igeocode='22KZ'">22KZ (Kazakhstan)</xsl:when>
 <xsl:when test="$igeocode='22TJ'">22TJ (Tajikistan)</xsl:when>
 <xsl:when test="$igeocode='22TM'">22TM (Turkmenistan)</xsl:when>
 <xsl:when test="$igeocode='22UZ'">22UZ (Uzbekistan)</xsl:when>
 <xsl:when test="$igeocode='23'">23 (Middle East)</xsl:when>
 <xsl:when test="$igeocode='23XA'">23XA (Arab area)</xsl:when>
 <xsl:when test="$igeocode='23XH'">23XH (Hebrew area)</xsl:when>
 <xsl:when test="$igeocode='23XK'">23XK (Kurdish area)</xsl:when>
 <xsl:when test="$igeocode='23EG'">23EG (Egypt)</xsl:when>
 <xsl:when test="$igeocode='23IL'">23IL (Israel)</xsl:when>
 <xsl:when test="$igeocode='23IQ'">23IQ (Iraq)</xsl:when>
 <xsl:when test="$igeocode='23IR'">23IR (Iran)</xsl:when>
 <xsl:when test="$igeocode='23JO'">23JO (Jordan)</xsl:when>
 <xsl:when test="$igeocode='23LB'">23LB (Lebanon)</xsl:when>
 <xsl:when test="$igeocode='23PS'">23PS (Palestine)</xsl:when>
 <xsl:when test="$igeocode='23SY'">23SY (Syria)</xsl:when>
 <xsl:when test="$igeocode='23TR'">23TR (Turkey)</xsl:when>
 <xsl:when test="$igeocode='24'">24 (Arabian Peninsula)</xsl:when>
 <xsl:when test="$igeocode='24AE'">24AE (United Arab Emirates)</xsl:when>
 <xsl:when test="$igeocode='24BH'">24BH (Bahrain)</xsl:when>
 <xsl:when test="$igeocode='24KW'">24KW (Kuwait)</xsl:when>
 <xsl:when test="$igeocode='24OM'">24OM (Oman)</xsl:when>
 <xsl:when test="$igeocode='24QA'">24QA (Qatar)</xsl:when>
 <xsl:when test="$igeocode='24SA'">24SA (Saudi Arabia)</xsl:when>
 <xsl:when test="$igeocode='24YE'">24YE (Yemen)</xsl:when>
 <xsl:when test="$igeocode='25'">25 (North Africa)</xsl:when>
 <xsl:when test="$igeocode='25XB'">25XB (Berber area)</xsl:when>
 <xsl:when test="$igeocode='25DZ'">25DZ (Algeria)</xsl:when>
 <xsl:when test="$igeocode='25EH'">25EH (Western Sahara)</xsl:when>
 <xsl:when test="$igeocode='25LY'">25LY (Libya)</xsl:when>
 <xsl:when test="$igeocode='25MA'">25MA (Morocco)</xsl:when>
 <xsl:when test="$igeocode='25TN'">25TN (Tunisia)</xsl:when>
 <xsl:when test="$igeocode='3'">3 (Sub-Saharan Africa)</xsl:when>
 <xsl:when test="$igeocode='31'">31 (West Africa)</xsl:when>
 <xsl:when test="$igeocode='31BF'">31BF (Burkina Faso)</xsl:when>
 <xsl:when test="$igeocode='31BJ'">31BJ (Benin)</xsl:when>
 <xsl:when test="$igeocode='31CI'">31CI (Ivory Coast)</xsl:when>
 <xsl:when test="$igeocode='31CV'">31CV (Cap-Vert)</xsl:when>
 <xsl:when test="$igeocode='31GH'">31GH (Ghana)</xsl:when>
 <xsl:when test="$igeocode='31GM'">31GM (Gambia)</xsl:when>
 <xsl:when test="$igeocode='31GN'">31GN (Guinea)</xsl:when>
 <xsl:when test="$igeocode='31GW'">31GW (Guinea-Bissau)</xsl:when>
 <xsl:when test="$igeocode='31LR'">31LR (Liberia)</xsl:when>
 <xsl:when test="$igeocode='31ML'">31ML (Mali)</xsl:when>
 <xsl:when test="$igeocode='31MR'">31MR (Mauritania)</xsl:when>
 <xsl:when test="$igeocode='31NE'">31NE (Niger)</xsl:when>
 <xsl:when test="$igeocode='31NG'">31NG (Nigeria)</xsl:when>
 <xsl:when test="$igeocode='31SL'">31SL (Sierra Leone)</xsl:when>
 <xsl:when test="$igeocode='31SN'">31SN (Senegal)</xsl:when>
 <xsl:when test="$igeocode='31TG'">31TG (Togo)</xsl:when>
 <xsl:when test="$igeocode='32'">32 (Central Africa)</xsl:when>
 <xsl:when test="$igeocode='32BI'">32BI (Burundi)</xsl:when>
 <xsl:when test="$igeocode='32CD'">32CD (Republic of Congo)</xsl:when>
 <xsl:when test="$igeocode='32CF'">32CF (Central African Republic)</xsl:when>
 <xsl:when test="$igeocode='32CG'">32CG (Congo)</xsl:when>
 <xsl:when test="$igeocode='32CM'">32CM (Cameroon)</xsl:when>
 <xsl:when test="$igeocode='32CQ'">32CQ (Equatorial Guinea)</xsl:when>
 <xsl:when test="$igeocode='32GA'">32GA (Gabon)</xsl:when>
 <xsl:when test="$igeocode='32RW'">32RW (Rwanda)</xsl:when>
 <xsl:when test="$igeocode='32ST'">32ST (São Tomé and Príncipe)</xsl:when>
 <xsl:when test="$igeocode='32TD'">32TD (Chad)</xsl:when>
 <xsl:when test="$igeocode='33'">33 (East Africa)</xsl:when>
 <xsl:when test="$igeocode='33DJ'">33DJ (Djibouti)</xsl:when>
 <xsl:when test="$igeocode='33ER'">33ER (Eritrea)</xsl:when>
 <xsl:when test="$igeocode='33ET'">33ET (Ethiopia)</xsl:when>
 <xsl:when test="$igeocode='33KE'">33KE (Kenya)</xsl:when>
 <xsl:when test="$igeocode='33SD'">33SD (Sudan)</xsl:when>
 <xsl:when test="$igeocode='33SO'">33SO (Somalia)</xsl:when>
 <xsl:when test="$igeocode='33TZ'">33TZ (Tanzania)</xsl:when>
 <xsl:when test="$igeocode='33UG'">33UG (Uganda)</xsl:when>
 <xsl:when test="$igeocode='34'">34 (Africa - Western Indian Ocean)</xsl:when>
 <xsl:when test="$igeocode='34KM'">34KM (Comoros)</xsl:when>
 <xsl:when test="$igeocode='34MG'">34MG (Madagascar)</xsl:when>
 <xsl:when test="$igeocode='34MU'">34MU (Mauritius)</xsl:when>
 <xsl:when test="$igeocode='34RE'">34RE (Réunion)</xsl:when>
 <xsl:when test="$igeocode='34SC'">34SC (Seychelles)</xsl:when>
 <xsl:when test="$igeocode='34YT'">34YT (Mayotte)</xsl:when>
 <xsl:when test="$igeocode='35'">35 (Southern Africa)</xsl:when>
 <xsl:when test="$igeocode='35AO'">35AO (Angola)</xsl:when>
 <xsl:when test="$igeocode='35BW'">35BW (Botswana)</xsl:when>
 <xsl:when test="$igeocode='35LS'">35LS (Lesotho)</xsl:when>
 <xsl:when test="$igeocode='35MW'">35MW (Malawi)</xsl:when>
 <xsl:when test="$igeocode='35MZ'">35MZ (Mozambique)</xsl:when>
 <xsl:when test="$igeocode='35NA'">35NA (Namibia)</xsl:when>
 <xsl:when test="$igeocode='35SZ'">35SZ (Eswatini)</xsl:when>
 <xsl:when test="$igeocode='35ZA'">35ZA (South Africa)</xsl:when>
 <xsl:when test="$igeocode='35ZM'">35ZM (Zambia)</xsl:when>
 <xsl:when test="$igeocode='35ZW'">35ZW (Zimbabwe)</xsl:when>
 <xsl:when test="$igeocode='4'">4 (Asia(s), South Asia, East Asia)</xsl:when>
 <xsl:when test="$igeocode='41'">41 (Upper Asia and South Asia)</xsl:when>
 <xsl:when test="$igeocode='41XT'">41XT (Tibet)</xsl:when>
 <xsl:when test="$igeocode='41BD'">41BD (Bangladeshi)</xsl:when>
 <xsl:when test="$igeocode='41BT'">41BT (Bhutan)</xsl:when>
 <xsl:when test="$igeocode='41IN'">41IN (Indian Union)</xsl:when>
 <xsl:when test="$igeocode='41LK'">41LK (Sri Lanka)</xsl:when>
 <xsl:when test="$igeocode='41MV'">41MV (Maldives)</xsl:when>
 <xsl:when test="$igeocode='41NP'">41NP (Nepal)</xsl:when>
 <xsl:when test="$igeocode='41PK'">41PK (Pakistan)</xsl:when>
 <xsl:when test="$igeocode='42'">42 (South East Asia)</xsl:when>
 <xsl:when test="$igeocode='42BN'">42BN (Brunei)</xsl:when>
 <xsl:when test="$igeocode='42ID'">42ID (Indonesia)</xsl:when>
 <xsl:when test="$igeocode='42KH'">42KH (Cambodia)</xsl:when>
 <xsl:when test="$igeocode='42LA'">42LA (Laos)</xsl:when>
 <xsl:when test="$igeocode='42MM'">42MM (Burma)</xsl:when>
 <xsl:when test="$igeocode='42MY'">42MY (Malaysia)</xsl:when>
 <xsl:when test="$igeocode='42PH'">42PH (Philippines)</xsl:when>
 <xsl:when test="$igeocode='42SG'">42SG (Singapore)</xsl:when>
 <xsl:when test="$igeocode='42TH'">42TH (Thailand)</xsl:when>
 <xsl:when test="$igeocode='42TL'">42TL (East Timor)</xsl:when>
 <xsl:when test="$igeocode='42VN'">42VN (Vietnam)</xsl:when>
 <xsl:when test="$igeocode='43'">43 (East Asia)</xsl:when>
 <xsl:when test="$igeocode='43CN'">43CN (China)</xsl:when>
 <xsl:when test="$igeocode='43JP'">43JP (Japan)</xsl:when>
 <xsl:when test="$igeocode='43XK'">43XK (Korea)</xsl:when>
 <xsl:when test="$igeocode='43KP'">43KP (North Korea)</xsl:when>
 <xsl:when test="$igeocode='43KR'">43KR (South Korea)</xsl:when>
 <xsl:when test="$igeocode='43MN'">43MN (Mongolia)</xsl:when>
 <xsl:when test="$igeocode='43TW'">43TW (Taiwan)</xsl:when>
 <xsl:when test="$igeocode='5'">5 (Oceania)</xsl:when>
 <xsl:when test="$igeocode='50'">50</xsl:when>
 <xsl:when test="$igeocode='50AU'">50AU (Australia)</xsl:when>
 <xsl:when test="$igeocode='50NZ'">50NZ (Nouvelle-Zélande)</xsl:when>
 <xsl:when test="$igeocode='51'">51 (Melanesia)</xsl:when>
 <xsl:when test="$igeocode='51NC'">51NC (New Caledonia)</xsl:when>
 <xsl:when test="$igeocode='51PG'">51PG (Papua N.G.)</xsl:when>
 <xsl:when test="$igeocode='51VU'">51VU (Vanuatu)</xsl:when>
 <xsl:when test="$igeocode='52'">52 (Micronesia)</xsl:when>
 <xsl:when test="$igeocode='53'">53 (Polynesia)</xsl:when>
 <xsl:when test="$igeocode='53PF'">53PF (French Polynesia)</xsl:when>
 <xsl:when test="$igeocode='6'">6 (America and Greenland)</xsl:when>
 <xsl:when test="$igeocode='61'">61 (North American Arctic)</xsl:when>
 <xsl:when test="$igeocode='61CA'">61CA (Canadian Arctic)</xsl:when>
 <xsl:when test="$igeocode='61GL'">61GL (Greenland)</xsl:when>
 <xsl:when test="$igeocode='61US'">61US (Alaska (United States))</xsl:when>
 <xsl:when test="$igeocode='62'">62 (Mesoamerica and South America)</xsl:when>
 <xsl:otherwise><xsl:value-of select="$igeocode"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

 <!-- Template 686$c - Classification thématique -->
<xsl:template name="icla">
 <xsl:param name="iclacode"/>
 <xsl:choose>
 <xsl:when test="$iclacode='000'">000 (General)</xsl:when>
 <xsl:when test="$iclacode='100'">100 (Philosophy)</xsl:when>
 <xsl:when test="$iclacode='200'">200 (Religions, Religious sciences)</xsl:when>
 <xsl:when test="$iclacode='300'">300 (Social Sciences)</xsl:when>
 <xsl:when test="$iclacode='400'">400 (Linguistics and languages)</xsl:when>
 <xsl:when test="$iclacode='500'">500 (Sciences)</xsl:when>
 <xsl:when test="$iclacode='600'">600 (Medicine - Technologies)</xsl:when>
 <xsl:when test="$iclacode='700'">700 (Arts and crafts)</xsl:when>
 <xsl:when test="$iclacode='800'">800 (Literature)</xsl:when>
 <xsl:when test="$iclacode='900'">900 (Geography and History)</xsl:when>
 <xsl:otherwise><xsl:value-of select="$iclacode"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

 <!-- Template 7xx - Auteurs -->
 <xsl:template name="tag_7xx">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:variable name="IdRef" select="marc:sysprefs/marc:syspref[@name='IdRef']"/>
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary author {$spanclass}">
 <span class="label">
 <xsl:value-of select="$label" />
 <xsl:text>: </xsl:text>
 </span>
 <span class="value">
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=an:</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code=9], true())"/>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=au:</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='a'], true())"/>
 <xsl:text>%20</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code='b'], true())"/>
 </xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='4' or @code='c' or @code='d' or @code='f' or @code='g' or @code='p']">
 <xsl:choose>
 <xsl:when test="@code='9'">
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="."/>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="not(position() = last())">
 <xsl:text>, </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </a>
 <xsl:if test="$IdRef = '1'">
 <xsl:if test="marc:subfield[@code=3]">
 <xsl:text> </xsl:text>
 <a>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-idref.pl?unimarc3=</xsl:text>
 <xsl:value-of select="str:encode-uri(marc:subfield[@code=3], true())"/>
 </xsl:attribute>
 <xsl:attribute name="title">IdRef</xsl:attribute>
 <xsl:attribute name="rel">gb_page_center[600,500]</xsl:attribute>
 <xsl:text>Idref</xsl:text>
 </a>
 </xsl:if>
 </xsl:if>
 <xsl:if test="not(position() = last())">
 <span style="padding: 3px;">
 <xsl:text>;</xsl:text>
 </span>
 </xsl:if>
 </xsl:for-each>
 </span>
 </span>
 </xsl:if>
 </xsl:template>

</xsl:stylesheet>
