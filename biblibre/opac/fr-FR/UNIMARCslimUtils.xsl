<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">

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
 <xsl:value-of select="substring($str,1,string-length($str)-string-length($delimeter))"/>
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
 <span class="results_summary">
 <span class="label">
 <xsl:value-of select="$label"/>: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='a'">
 <xsl:variable name="title" select="."/>
 <xsl:variable name="ntitle"
 select="translate($title, '&#x0088;&#x0089;&#x0098;&#x009C;','')"/>
 <xsl:value-of select="$ntitle" />
 </xsl:when>
 <xsl:when test="@code='b'">
 <xsl:text>[</xsl:text>
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
 <xsl:if test="position()>1">
 <xsl:text>, </xsl:text>
 </xsl:if>
 <xsl:value-of select="."/>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 <xsl:if test="not (position() = last())">
 <xsl:text> • </xsl:text>
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
 <span class="label">
 <xsl:value-of select="$label"/>: </span>
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <xsl:call-template name="addClassRtl" />
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

 <xsl:template name="tag_210">
<xsl:for-each select="marc:datafield[@tag=210]">
<span class="results_summary">
<span class="label">Publication : </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a'][1]"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][1]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][1]"/>
</xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='a'][2]"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][2]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][2]"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='a'][3]">
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='a'][3]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='c'][3]">
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][3]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][3]"/>
</xsl:element>
</xsl:if>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="text()"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text> : </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'][2])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="text()"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>


<xsl:when test="(marc:subfield[@code='c'])">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='h']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='g'])">
<xsl:value-of select="marc:subfield[@code='g']"/>
<xsl:if test="marc:subfield[@code='h']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='h'])">
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:when>



</xsl:choose>
</span>
</xsl:for-each>
 </xsl:template>


 <xsl:template name="tag_214">
<xsl:for-each select="marc:datafield[@tag=214]">
<span class="results_summary">
<span class="label">Publication : </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a'][1]"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][1]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][1]"/>
</xsl:element>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='a'][2]"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][2]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][2]"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='a'][3]">
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='a'][3]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='c'][3]">
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c'][3]"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c'][3]"/>
</xsl:element>
</xsl:if>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="text()"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text> : </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'][2])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text></xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='c'][2]) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='c']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="text()"/>
</xsl:attribute>
<xsl:value-of select="text()"/>
</xsl:element>
<xsl:if test="position()!=last()">
<xsl:text> : </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'][2]) and (marc:subfield[@code='d'])">
<xsl:for-each select="marc:subfield[@code='a']">
<xsl:value-of select="text()"/>
<xsl:if test="position()!=last()">
<xsl:text> ; </xsl:text>
</xsl:if>
<xsl:if test="position()=last()">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text>, </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='a'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='c'])">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Publisher&amp;q=
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:attribute>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:element>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:if test="marc:subfield[@code='e']">
<xsl:text> (</xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:text>)</xsl:text>
</xsl:if>
</xsl:when>

<xsl:when test="(marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:if test="marc:subfield[@code='g']">
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='g']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='h']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='g'])">
<xsl:value-of select="marc:subfield[@code='g']"/>
<xsl:if test="marc:subfield[@code='h']">
<xsl:text> , </xsl:text>
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:if>
</xsl:when>
<xsl:when test="(marc:subfield[@code='h'])">
<xsl:value-of select="marc:subfield[@code='h']"/>
</xsl:when>
</xsl:choose>
</span>
</xsl:for-each>
 </xsl:template>

<!--210$s et $r Colophon et adresse transcrite-->
<xsl:template name="tag_210_s">
<xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='s']">
<span class="results_summary">
<span class="label">Colophon : </span>
<xsl:for-each select="marc:datafield[@tag=210]">
<xsl:value-of select="marc:subfield[@code='s']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>
</xsl:template>

<xsl:template name="tag_210_r">
<xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='r']">
<span class="results_summary">
<span class="label">Adresse transcrite : </span>
<xsl:for-each select="marc:datafield[@tag=210]">
<xsl:value-of select="marc:subfield[@code='r']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>
</xsl:template>

<!--TB-214$s et $r Colophon et adresse transcrite-->
<xsl:template name="tag_214_s">
<xsl:if test="marc:datafield[@tag=214]/marc:subfield[@code='s']">
<span class="results_summary">
<span class="label">Colophon : </span>
<xsl:for-each select="marc:datafield[@tag=214]">
<xsl:value-of select="marc:subfield[@code='s']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>
</xsl:template>

<xsl:template name="tag_214_r">
<xsl:if test="marc:datafield[@tag=214]/marc:subfield[@code='r']">
<span class="results_summary">
<span class="label">Adresse transcrite : </span>
<xsl:for-each select="marc:datafield[@tag=210]">
<xsl:value-of select="marc:subfield[@code='r']"/>
<xsl:choose>
<xsl:when test="position()=last()">
<xsl:text>.</xsl:text>
</xsl:when>
<xsl:otherwise><xsl:text>, </xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span>
</xsl:if>
</xsl:template>






 <xsl:template name="tag_215">
 <xsl:for-each select="marc:datafield[@tag=215]">
 <span class="results_summary">
 <span class="label">Description : </span>
<xsl:choose>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d']) and (marc:subfield[@code='e'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='e']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='d']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='e']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
<xsl:text> + </xsl:text>
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='c'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:when>
<xsl:when test="(marc:subfield[@code='a']) and (marc:subfield[@code='d'])">
<xsl:value-of select="marc:subfield[@code='a']"/>
<xsl:text> ; </xsl:text>
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

<!--Titre de serie - autorité 461-->
<xsl:template name="tag_461">
<xsl:for-each select="marc:datafield[@tag=461]">
<span class="results_summary">
<span class="label">Titre de série  : </span>
<xsl:call-template name="addClassRtl" />
<xsl:choose>
<xsl:when test="marc:subfield[@code='9']">
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code='9']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
<xsl:otherwise>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=index-title-serie,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="marc:subfield[@code='e']"> :
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='f']"> /
<xsl:value-of select="marc:subfield[@code='f']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='d']"> ,
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='p']"> ,
<xsl:value-of select="marc:subfield[@code='p']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='v']">,
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:if>
</span>
</xsl:for-each>
</xsl:template>


<!--Titre de serie non autorité 461-->
<xsl:template name="tag_461bis">
<xsl:variable name="type_doc" select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>
<xsl:for-each select="marc:datafield[@tag=461]">
<xsl:call-template name="addClassRtl" />
<xsl:choose>
<!--si notice d'article-->
<xsl:when test="contains($type_doc,'Article') and marc:subfield[@code='9']">
<li style="list-style-type: none;">
<strong>Titre du périodique : </strong>
<xsl:if test="marc:subfield[@code='a']">
<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> , </xsl:text>
</xsl:if>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=sn&amp;q=<xsl:value-of select="marc:subfield[@code='9']
"/>
</xsl:attribute> <xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=index-title-serie,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute> - Voir les autres articles</xsl:element>
</li>
</xsl:when>
<!--sinon-->
<xsl:otherwise>
<li style="list-style-type: none;">
<strong>Titre de la série : </strong>
<xsl:if test="marc:subfield[@code='a']">
<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> , </xsl:text>
</xsl:if>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=index-title-serie,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute> <xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</li>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='e']"> :
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='e']"/>
</xsl:if>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='f']"> /
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='f']"/>
</xsl:if>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='d']"> ,
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='d']"/>
</xsl:if>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='p']"> ,
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='p']"/>
</xsl:if>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='v']">,
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='v']"/>
</xsl:if>
<xsl:if test="marc:datafield[@tag=461]/marc:subfield[@code='w']"> -
<xsl:value-of select="marc:datafield[@tag=461]/marc:subfield[@code='w']"/>
</xsl:if>
</xsl:for-each>	
</xsl:template>

<!--Titre dépouillé 463-->
<xsl:template name="tag_463">
<xsl:for-each select="marc:datafield[@tag=463][1]">
<span class="results_summary">
<span class="label">Titre dépouillé : </span>
<xsl:call-template name="addClassRtl" />
<xsl:if test="marc:subfield[@code='a']">
<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text>. </xsl:text>
</xsl:if>
<xsl:choose>
<xsl:when test="marc:subfield[@code='9']">
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Local-number,phr&amp;q=<xsl:value-of select="marc:subfield[@code='9']"/>
</xsl:attribute> <xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
<xsl:otherwise>
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=index-title-article,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:attribute> <xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="marc:subfield[@code='e']"> :
<xsl:value-of select="marc:subfield[@code='e']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='f']"> /
<xsl:value-of select="marc:subfield[@code='f']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='d']"> ,
<xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='p']"> ,
<xsl:value-of select="marc:subfield[@code='p']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='v']">,
<xsl:value-of select="marc:subfield[@code='v']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='w']"> -
<xsl:value-of select="marc:subfield[@code='w']"/>
</xsl:if>
</span>
</xsl:for-each>
</xsl:template>

<!--Public 995q-->
<xsl:template name="public">
<xsl:if test="marc:datafield[@tag=995]/marc:subfield[@code='q']">
<span class="results_summary">
<span class="label">Public :</span>
<xsl:for-each select="marc:datafield[@tag=995]/marc:subfield[@code='q']">
<xsl:if test="position() = 1">
<xsl:value-of select="." />
</xsl:if></xsl:for-each>
</span> 
</xsl:if>
</xsl:template>

<!--Fonds 995h-->
<xsl:template name="fonds">
<xsl:if test="marc:datafield[@tag=995]/marc:subfield[@code='h']">
<span class="results_summary">
<span class="label">Fonds : </span>
<xsl:for-each select="marc:datafield[@tag=995]/marc:subfield[@code='h']">
<xsl:if test="position() = 1">
<xsl:value-of select="." />
</xsl:if></xsl:for-each>
</span>
</xsl:if>
</xsl:template>

<!--Nouveauté 995$B-->
<xsl:template name="nouveaute">
<xsl:if test="marc:datafield[@tag=995]/marc:subfield[@code='B']">
<xsl:for-each select="marc:datafield[@tag=995]/marc:subfield[@code='B']">
<xsl:if test="position() = 1">
<xsl:element name="img">
<xsl:attribute name="size">14px</xsl:attribute>
<xsl:attribute name="src">/public/images/nouveau.png</xsl:attribute><xsl:attribute name="title">Nouveauté</xsl:attribute></xsl:element>
</xsl:if></xsl:for-each>
</xsl:if>
</xsl:template>

<xsl:template name="tag_462_ppn">
<xsl:variable name="ppn" select="marc:controlfield[@tag=009]"/>
<xsl:for-each select="marc:controlfield[@tag=009]">
<span class="results_summary">
<span class="label">Liste des unités dépouillées : </span>

<xsl:call-template name="addClassRtl" />
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=kw,phr&amp;q=<xsl:value-of select="$ppn"/>
</xsl:attribute>Voir titres</xsl:element>
</span>
</xsl:for-each>
</xsl:template>

<xsl:template name="tag_462">
<xsl:for-each select="marc:datafield[@tag=090][1]">
<span class="results_summary">
<span class="label">Liste des unités dépouillées : </span>
<xsl:call-template name="addClassRtl" />
<xsl:if test="marc:subfield[@code='a']">
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=index-lien-desc,phr&amp;q=<xsl:value-of select="marc:subfield[@code='a'][1]"/>
</xsl:attribute>Voir titres</xsl:element>
</xsl:if>
</span>
</xsl:for-each>
</xsl:template>

<xsl:template name="tag_4xx">
<xsl:param name="tag" />
<xsl:param name="label" />
<xsl:if test="marc:datafield[@tag=$tag]">
<span class="results_summary">
<span class="label"><xsl:value-of select="$label" /> : </span>
<xsl:for-each select="marc:datafield[@tag=$tag]">
<xsl:call-template name="addClassRtl" />
<xsl:choose>
<xsl:when test="marc:subfield[@code='9']">
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=Local-number,phr&amp;q=<xsl:value-of select="marc:subfield[@code='9']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
<xsl:when test="marc:subfield[@code='0']">
<xsl:element name="a"><xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=kw,phr&amp;q=<xsl:value-of select="marc:subfield[@code='0']"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></xsl:element>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="marc:subfield[@code='t']"/>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="marc:subfield[@code='c']"> : <xsl:value-of select="marc:subfield[@code='c']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='d']"> ; <xsl:value-of select="marc:subfield[@code='d']"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='e'][1]"> - <xsl:value-of select="marc:subfield[@code='e'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='f'][1]"> - <xsl:value-of select="marc:subfield[@code='f'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='g'][1]"> - <xsl:value-of select="marc:subfield[@code='g'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='h'][1]"> - <xsl:value-of select="marc:subfield[@code='h'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='i'][1]"> - <xsl:value-of select="marc:subfield[@code='i'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='l'][1]"> - <xsl:value-of select="marc:subfield[@code='l'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='v'][1]"> , <xsl:value-of select="marc:subfield[@code='v'][1]"/>
</xsl:if>
<xsl:if test="marc:subfield[@code='x']">,
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=ns&amp;q=<xsl:value-of select="marc:subfield[@code='x'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='x'][1]"/></xsl:element>
</xsl:if>
<xsl:if test="marc:subfield[@code='y']">,
<xsl:element name="a">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?idx=nb&amp;q=<xsl:value-of select="marc:subfield[@code='y'][1]"/>
</xsl:attribute><xsl:value-of select="marc:subfield[@code='y'][1]"/></xsl:element>
</xsl:if>
<xsl:if test="not (position() = last())">
<xsl:text> ; </xsl:text>
</xsl:if>
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
 <xsl:value-of select="."/>
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
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:attribute>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdfijkmnpvxyz</xsl:with-param>
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
 <xsl:text> : </xsl:text>
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


 <xsl:template name="tag_71x">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
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
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b'][2]">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b'][2]"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b'][3]">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b'][3]"/>
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
 <xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:text> ; </xsl:text>
<xsl:value-of select="marc:subfield[@code='f']"/>
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
 <xsl:value-of select="marc:subfield[@code='e']"/>
<xsl:text> ; </xsl:text>
 <xsl:value-of select="marc:subfield[@code='f']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='d']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='d']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
<xsl:when test="marc:subfield[@code='e']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='e']"/>
 <xsl:text> ) </xsl:text>
</xsl:when>
</xsl:choose>
<xsl:if test="marc:subfield[@code='4']">
 <xsl:text> ( </xsl:text>
 <xsl:value-of select="marc:subfield[@code='4']"/>
<xsl:text> ) </xsl:text>
 </xsl:if>
 </a>
 <xsl:if test="not (position() = last())">
 <xsl:text> ; </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </span></span>
 </xsl:if>
 </xsl:template>


 <xsl:template name="tag_7xx">
 <xsl:param name="tag" />
 <xsl:param name="label" />
 <xsl:param name="spanclass" />
 <xsl:if test="marc:datafield[@tag=$tag]">
 <span class="results_summary author {$spanclass}">
 <span class="label">
 <xsl:value-of select="$label" />
 <xsl:text> : </xsl:text>
 </span>
 <span class="value">
 <xsl:for-each select="marc:datafield[@tag=$tag]">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=an:</xsl:text>
 <xsl:value-of select="marc:subfield[@code=9]"/>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">
 <xsl:text>/cgi-bin/koha/opac-search.pl?q=au:</xsl:text>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:text> </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b']"/>
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

<xsl:template name="RCR">
  <xsl:param name="code"/>
  <xsl:choose>
    <xsl:when test="$code='xxxxxxxxx'">Bibliothèque xxxxxxxxx</xsl:when>
    <xsl:when test="$code='yyyyyyyyy'">Bibliothèque yyyyyyyyy</xsl:when>
    <xsl:otherwise><xsl:value-of select="$code"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
