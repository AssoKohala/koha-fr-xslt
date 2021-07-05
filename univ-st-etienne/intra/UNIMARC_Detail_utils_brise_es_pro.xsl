<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
	
  <xsl:variable name="ascii"> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable>
  <xsl:variable name="latin1">&#160;&#161;&#162;&#163;&#164;&#165;&#166;&#167;&#168;&#169;&#170;&#171;&#172;&#173;&#174;&#175;&#176;&#177;&#178;&#179;&#180;&#181;&#182;&#183;&#184;&#185;&#186;&#187;&#188;&#189;&#190;&#191;&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#215;&#216;&#217;&#218;&#219;&#220;&#221;&#222;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#240;&#241;&#242;&#243;&#244;&#245;&#246;&#247;&#248;&#249;&#250;&#251;&#252;&#253;&#254;&#255;</xsl:variable>
  <!-- Characters that usually don't need to be escaped -->
  <xsl:variable name="safe">!'()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~</xsl:variable>
  <xsl:variable name="hex" >0123456789ABCDEF</xsl:variable>
  <xsl:template name="url-encode">
    <xsl:param name="str"/>
    <xsl:if test="$str">
      <xsl:variable name="first-char" select="substring($str,1,1)"/>
      <xsl:choose>
        <xsl:when test="contains($safe,$first-char)">
          <xsl:value-of select="$first-char"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="codepoint">
            <xsl:choose>
              <xsl:when test="contains($ascii,$first-char)">
                <xsl:value-of select="string-length(substring-before($ascii,$first-char)) + 32"/>
              </xsl:when>
              <xsl:when test="contains($latin1,$first-char)">
                <xsl:value-of select="string-length(substring-before($latin1,$first-char)) + 160"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:message terminate="no">Warning: string contains a character that is out of range! Substituting "?".</xsl:message>
                <xsl:text>63</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
        <xsl:variable name="hex-digit1" select="substring($hex,floor($codepoint div 16) + 1,1)"/>
        <xsl:variable name="hex-digit2" select="substring($hex,$codepoint mod 16 + 1,1)"/>
        <xsl:value-of select="concat('%',$hex-digit1,$hex-digit2)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="string-length($str) &gt; 1">
        <xsl:call-template name="url-encode">
          <xsl:with-param name="str" select="substring($str,2)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

<xsl:template name="tag_010"><!-- isbn -->
<!--    <xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='a']">  -->
      <span class="result_detail">
        <span class="label">ISBN : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=010]">
          <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
          <xsl:value-of select="marc:subfield[@code='a']"/>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> ; </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </span></span>
<!--    </xsl:if>  -->
</xsl:template>
 
 <xsl:template name="tag_011"><!-- issn -->
<!-- <xsl:if test="marc:datafield[@tag=011]">  -->
      <span class="result_detail">
        <span class="label">ISSN : </span><span class="valeur">
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
      </span></span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_099"><!-- ccode / type de doc -->
<!--  <xsl:if test="marc:datafield[@tag=099]">  -->
      <span class="result_detail">
        <span class="label">Type doc : </span><span class="valeur">
          <xsl:value-of select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>
      </span></span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_205"><!-- édition -->
<!--    <xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a' or @code='b']"> -->
    <span class="result_detail">
    <span class="label">Edition : </span><span class="valeur">
      <xsl:for-each select="marc:datafield[@tag=205]">
      <xsl:value-of select="marc:subfield[@code='a']"/>
        <xsl:if test="marc:subfield[@code='b']">
         <xsl:for-each select="marc:subfield[@code='b']">
         <xsl:text>, </xsl:text><xsl:value-of select="."/>
         </xsl:for-each>
       </xsl:if>
         <xsl:if test ="position() = last()"><xsl:text> </xsl:text></xsl:if>
      </xsl:for-each>
    </span></span>
<!--    </xsl:if> -->
</xsl:template>

<xsl:template name="tag_210"><!-- éditeur -->
<!--    <xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='c' or @code='d']">  -->
      <span class="result_detail">
      <span class="label">Editeur : </span><span class="valeur">
      <xsl:for-each select="marc:datafield[@tag=210]">
        <xsl:if test="marc:subfield[@code='a']">
      <xsl:value-of select="marc:subfield[@code='a']"/><xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:for-each select="marc:subfield[@code='c']">
        <xsl:value-of select="."/>
         <xsl:if test="position() != last()"><xsl:text> : </xsl:text></xsl:if>
        </xsl:for-each>
        
      <xsl:if test="marc:subfield[@code='d']">
        <xsl:if test="marc:subfield[@code='c']">, </xsl:if>
        <xsl:value-of select="marc:subfield[@code='d']"/>
      </xsl:if>
      <xsl:if test="marc:subfield[@code='h']"> <!-- depuis mi avril 2017 -->
        <xsl:if test="marc:subfield[@code='c']">, </xsl:if>
        <xsl:value-of select="marc:subfield[@code='h']"/>
      </xsl:if>
      <xsl:if test="position() != last()"><xsl:text> - </xsl:text></xsl:if>
     
      </xsl:for-each>
      <xsl:text>. </xsl:text>
      </span></span>
<!--  </xsl:if> -->
  </xsl:template>

<xsl:template name="tag_215"><!-- description -->
    <xsl:for-each select="marc:datafield[@tag=215]">
  	  <span class="result_detail">
        <span class="label">Description : </span><span class="valeur"> 
        <xsl:if test="marc:subfield[@code='a']">
          <xsl:value-of select="marc:subfield[@code='a']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='c']"> :
          <xsl:value-of select="marc:subfield[@code='c']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='d']"> ;
          <xsl:value-of select="marc:subfield[@code='d']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='e']"> +
          <xsl:value-of select="marc:subfield[@code='e']"/>
        </xsl:if>
      </span></span>
    </xsl:for-each>
  </xsl:template>
  
<xsl:template name="tag_225"><!-- collection a revoir pb sur $i -->
<!--  <xsl:if test="marc:datafield[@tag=225]/marc:subfield[@code='a']">  -->
    <span class="result_detail">
    <span class="label">Collection : </span><span class="valeur">
      <xsl:for-each select="marc:datafield[@tag=225]">
      <xsl:text>(</xsl:text>
      <xsl:value-of select="marc:subfield[@code='a']"/>
        <xsl:if test="marc:subfield[@code='h']">
        <xsl:text>. </xsl:text><xsl:value-of select="marc:subfield[@code='h']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='i']">
         <xsl:choose>
         <xsl:when test="marc:subfield[@code='h']">
         <xsl:text>, </xsl:text>
         </xsl:when>
         <xsl:otherwise>
         <xsl:text>. </xsl:text>
         </xsl:otherwise>
         </xsl:choose>
        <xsl:value-of select="marc:subfield[@code='i']"/><!-- probleme $i repetable !! -->
        </xsl:if>
       <xsl:if test="marc:subfield[@code='v']">
        <xsl:text> ; </xsl:text>
        <xsl:value-of select="marc:subfield[@code='v']"/>
       </xsl:if>  
       <xsl:if test="marc:subfield[@code='x']">
        <xsl:text>, issn </xsl:text>
        <xsl:value-of select="marc:subfield[@code='x']"/>
       </xsl:if>
       <xsl:text>)</xsl:text>
       <xsl:if test="position() = last()"><xsl:text>. </xsl:text></xsl:if>
      </xsl:for-each>
      </span></span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_300"><!-- note gene -->
<!--   <xsl:if test="marc:datafield[@tag=300]">   -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=300]">
          <xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> </xsl:text>
          <xsl:if test="marc:datafield[@tag=300]/marc:subfield[@code='u']">
          <a><xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute><xsl:value-of select="marc:subfield[@code='u']"/></a>
          </xsl:if>
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
      </span>
<!--     </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_302"><!-- note lang -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=302]">
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
      </span>
</xsl:template>

<xsl:template name="tag_303"><!-- note gene desc bibliogr -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=303]">
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
      </span>
</xsl:template>

<xsl:template name="tag_304"><!-- note mention resp -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=304]">
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
      </span>
</xsl:template>

<xsl:template name="tag_305"><!-- note edition -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=305]">
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
      </span>
</xsl:template>

<xsl:template name="tag_306"><!-- note publication -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=306]">
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
      </span>
</xsl:template>

<xsl:template name="tag_307"><!-- note desc mat -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=307]">
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
      </span>
</xsl:template>

<xsl:template name="tag_308"><!-- note collection -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=308]">
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
      </span>
</xsl:template>

<xsl:template name="tag_312"><!-- note titres associes -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=312]">
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
      </span>
</xsl:template>

<xsl:template name="tag_314"><!-- note responsabilite -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=314]">
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
      </span>
</xsl:template>

<xsl:template name="tag_316"><!-- note CJB -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=316]">
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
      </span>
</xsl:template>

<xsl:template name="tag_990"><!-- notes locales CJB -->
    <span class="result_detail">
      <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=990]">
          <xsl:value-of select="marc:subfield[@code='a']"/>
            <xsl:if test="marc:subfield[@code='u']"><!-- test sur existence d'une url -->
              <xsl:if test="marc:subfield[@code='2']"><!-- texte clicable -->
                <span class="">
                 <a>
                   <xsl:attribute name="href">
                     <xsl:value-of select="marc:subfield[@code='u']"/>
                   </xsl:attribute>
                   <xsl:attribute name="target">_blank</xsl:attribute>
                   <xsl:value-of select="marc:subfield[@code='2']"/>
                   <xsl:choose>
                     <xsl:when test="marc:subfield[@code='q']"> <!-- format -->
                       &#xA0;-&#xA0;<xsl:value-of select="marc:subfield[@code='q']"/>
                     </xsl:when>
                   </xsl:choose>
                 </a>
                </span>
              </xsl:if>
            </xsl:if>
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
    </span>
</xsl:template>

 <xsl:template name="tag_320"><!-- bibliographie -->
<!--    <xsl:if test="marc:datafield[@tag=320]">  -->
      <span class="result_detail">
        <span class="label">Bibliographie : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=320]">
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
      </span></span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_322"><!-- note generique film -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=322]">
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
      </span>
</xsl:template>

<xsl:template name="tag_323"><!-- note interprete film -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=323]">
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
      </span>
</xsl:template>

<xsl:template name="tag_324"><!-- note sur original reprod -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
          <xsl:value-of select="marc:datafield[@tag=324]/marc:subfield[@code='a']"/>
        <xsl:text>.</xsl:text>
      </span>
      </span>
</xsl:template>

<xsl:template name="tag_325"><!-- note sur reprod -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=325]">
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
      </span>
</xsl:template>

<xsl:template name="tag_326"><!-- note periodicites -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=326]">
          <xsl:value-of select="marc:subfield[@code='a']"/>,
          <xsl:value-of select="marc:subfield[@code='b']"/>
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
      </span>
</xsl:template>

<xsl:template name="tag_327"><!-- note contenu -->
      <span class="result_detail">
        <span class="label">Note de contenu : </span><span class="valeur">
      <xsl:for-each select="marc:datafield[@tag=327]">
       <xsl:for-each select="marc:subfield[@code='a']"> <!-- pb si autre sous-champ, mais que a au 22-10-2012  -->
        <xsl:value-of select="."/>
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
      </span>
</xsl:template>

<xsl:template name="tag_328"><!-- thèses -->
<!--  <xsl:if test="marc:datafield[@tag=328]">  -->
      <span class="result_detail">
        <span class="label">Thèses : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=328]">
         <xsl:if test="marc:subfield[@code='z']"><xsl:value-of select="marc:subfield[@code='z']"/>&#160;:&#160;</xsl:if>
         <xsl:if test="marc:subfield[@code='a']"><xsl:value-of select="marc:subfield[@code='a']"/></xsl:if>
         <xsl:if test="marc:subfield[@code='b']"> <xsl:if test="marc:subfield[@code='a']"><xsl:text>&#160;:&#160;</xsl:text></xsl:if><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if>
         <xsl:if test="marc:subfield[@code='c']"><xsl:text>&#160;:&#160;</xsl:text><xsl:value-of select="marc:subfield[@code='c']"/></xsl:if>
         <xsl:if test="marc:subfield[@code='d']"><xsl:text>&#160;:&#160;</xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></xsl:if>
         <xsl:if test="marc:subfield[@code='e']"><xsl:text>,&#160;</xsl:text><xsl:value-of select="marc:subfield[@code='e']"/></xsl:if>
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
     </span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_330"><!-- résumé -->
<!--   <xsl:if test="marc:datafield[@tag=330]">  -->
      <span class="result_detail">
        <span class="label">Résumé : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=330]">
          <xsl:value-of select="marc:subfield[@code='a']"/>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>.</xsl:text><br /><br />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </span>
      </span>
<!--    </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_336"><!-- note sur reprod -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=336]">
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
      </span>
</xsl:template>

<xsl:template name="tag_337"><!-- note periodicites -->
      <span class="result_detail">
        <span class="label">Notes : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=337]">
          <xsl:value-of select="marc:subfield[@code='a']"/>,
          <xsl:value-of select="marc:subfield[@code='b']"/>
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
      </span>
</xsl:template>

<xsl:template name="tag_359"><!-- sommaire 359 -->
      <span class="result_detail">
        <span class="label">Table des matières : </span><span class="valeur">
        <a><xsl:attribute name="name">notes</xsl:attribute><xsl:attribute name="href">#descriptions</xsl:attribute><xsl:attribute name="role">presentation</xsl:attribute><xsl:attribute name="class">ui-tabs-anchor</xsl:attribute>Voir</a>
      </span>
     </span>
     <span class="n359" style="display:none;" >
        <xsl:for-each select="marc:datafield[@tag=359]">
         <xsl:for-each select="marc:subfield">
          <xsl:choose>
            <xsl:when test="@code='p'">
                <span class="n359p"><xsl:value-of select="." /></span>
            </xsl:when>
            <xsl:when test="@code='b'">
                <span class="n359b"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='c'">
                <span class="n359c"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='d'">
                <span class="n359d"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='e'">
                <span class="n359e"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='f'">
                <span class="n359f"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='g'">
                <span class="n359g"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='h'">
                <span class="n359h"><xsl:value-of select="." /><br /></span>
            </xsl:when>
            <xsl:when test="@code='i'">
                <span class="n359i"><xsl:value-of select="." /><br /></span>
            </xsl:when>
          </xsl:choose>
         </xsl:for-each>
       </xsl:for-each>
     </span>
</xsl:template>

<xsl:template name="tag_463"><!-- titre revue pour les articles -->
<xsl:variable name="support" select="marc:datafield[@tag=099]/marc:subfield[@code='t']" />
    <xsl:if test="$support = 'Article'">
      <span class="result_detail">
        <span class="label">Article dans : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=463]">
        <a><xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q="<xsl:value-of select="marc:subfield[@code='t']"/>"&amp;limit=typedoc%3A"REVUE"</xsl:attribute><xsl:value-of select="marc:subfield[@code='t']"/></a>&#xA0;
        <xsl:value-of select="marc:subfield[@code='v']"/>
        </xsl:for-each>
        </span>
      </span>
    </xsl:if>
    <xsl:if test="$support != 'Article'">
      <span class="result_detail">
        <span class="label">Comprend : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=463]">
        <xsl:value-of select="marc:subfield[@code='t']"/>
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
      </span>
    </xsl:if>
</xsl:template>
 
<xsl:template name="tag_4xx"><!-- fait partie de / traduit de / contient -->
    <xsl:if test="marc:datafield[@tag=461]">
      <span class="result_detail">
      <span class="label">Partie de : </span><span class="valeur"> 
      <xsl:value-of select="marc:subfield[@code='t']"/>
      <xsl:if test="marc:subfield[@code='v']"><xsl:value-of select="marc:subfield[@code='v']"/></xsl:if>
      </span></span>
    </xsl:if>	
    <xsl:if test="marc:datafield[@tag=454]">
      <span class="result_detail">
      <span class="label">Trad. de : </span><span class="valeur">
      <xsl:value-of select="marc:datafield[@tag=454]"/>
      </span></span>
    </xsl:if>	
    <xsl:for-each select="marc:datafield[@tag=464]">
    	  <span class="result_detail">
        <span class="label">Inclut : </span><span class="valeur">
        <xsl:if test="marc:subfield[@code='t']">
          <xsl:value-of select="marc:subfield[@code='t']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='e']"> :
          <xsl:value-of select="marc:subfield[@code='e']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='f']"> /
          <xsl:value-of select="marc:subfield[@code='f']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='v']">,
          <xsl:value-of select="marc:subfield[@code='v']"/>
        </xsl:if>
      </span></span>
    </xsl:for-each>
</xsl:template>

<xsl:template name="tag_6xx"><!-- sujets regroupes mais sans lc sous triée alpha -->
    <xsl:if test="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
      <span class="result_detail">
        <span class="label">Sujet(s) : </span><span class="valeur">
          <xsl:for-each select="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
           <xsl:sort select="marc:subfield[@code='2']" data-type="text" />
           <xsl:sort select="marc:subfield[@code='a']" data-type="text" />
         <xsl:if test="not(contains(marc:subfield[@code='2'],'lc'))">
         <i>
         <xsl:value-of select="marc:subfield[@code='2']" /><xsl:text> </xsl:text>
         </i>
           <xsl:variable name="sujet"><xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">abcdjptvxyz</xsl:with-param>
                  <xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
                  <xsl:with-param name="subdivDelimiter"> </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
           </xsl:variable>
          <a>
           <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=subject&amp;q=(<xsl:value-of select="translate($sujet,',;()','')" />)&amp;filters=
           </xsl:attribute>
            <xsl:if test="@tag=600 or @tag=601 or @tag=602">
                 <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
                </xsl:if>
            </xsl:if>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">abcdfjptvxyz</xsl:with-param>
                  <xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
                  <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template></a>
          <xsl:choose>
            <xsl:when test="position()=last()"/>
            <xsl:otherwise><br /></xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        </xsl:for-each>
        </span>
      </span>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_6xx_ref20150723"><!-- sujets triée alpha -->
    <xsl:if test="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
      <span class="result_detail">
        <span class="label">Sujet(s) : </span><span class="valeur">
          <xsl:for-each select="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
          <xsl:sort select="marc:subfield[@code='a']" data-type="text" />
           <xsl:variable name="sujet"><xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">abcdjptvxyz</xsl:with-param>
                  <xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
                  <xsl:with-param name="subdivDelimiter"> </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
           </xsl:variable>
          <a>
           <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=subject&amp;q=(<xsl:value-of select="translate($sujet,',;()','')" />)&amp;filters=
           </xsl:attribute>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">abcdjptvxyz</xsl:with-param>
                  <xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
                  <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template></a>
          <xsl:choose>
            <xsl:when test="position()=last()"/>
            <xsl:otherwise><br /></xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        </span>
      </span>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_6xx_old"><!-- sujets triée alpha -->
    <xsl:if test="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
      <span class="result_detail">
        <span class="label">Sujet(s) : </span><span class="valeur">
          <xsl:for-each select="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610 or @tag=616]">
          <xsl:sort select="marc:subfield[@code='a']" data-type="text" />
          <a>
            <xsl:choose>
              <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">abcdjptvxyz</xsl:with-param>
                  <xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
                  <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template></a>
          <xsl:choose>
            <xsl:when test="position()=last()"/>
            <xsl:otherwise><br /></xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        </span>
      </span>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_675"><!-- CDU -->
  <xsl:if test="marc:datafield[@tag=675]">
   <xsl:if test="contains(marc:datafield[@tag=998],'ENISE')">
      <span class="result_detail">
        <span class="label">CDU : </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=675]">
          <xsl:value-of select="marc:subfield[@code='a']"/>
                <xsl:if test="marc:subfield[@code='v']"> <!-- edition -->
                <xsl:text> (</xsl:text>
                <xsl:value-of select="marc:subfield[@code='v']"/>
                <xsl:text>)</xsl:text>
                </xsl:if>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> ; </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </span></span>
     </xsl:if>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_676"><!-- dewey -->
  <xsl:if test="marc:datafield[@tag=676]">
      <span class="result_detail">
        <span class="label">Dewey: </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=676]">
          <xsl:value-of select="marc:subfield[@code='a']"/>

                <xsl:if test="marc:subfield[@code='v']"> <!-- edition -->
                <xsl:text> (</xsl:text>
                <xsl:value-of select="marc:subfield[@code='v']"/>
                <xsl:text>)</xsl:text>
                </xsl:if>

          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>; </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </span></span>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_686"><!-- autre classification -->
  <xsl:if test="marc:datafield[@tag=686]">
      <span class="result_detail">
        <span class="label">Dewey: </span><span class="valeur">
        <xsl:for-each select="marc:datafield[@tag=686]">
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
      </span></span>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_7xx"><!-- auteurs -->
    <xsl:if test="marc:datafield[@tag=700] or marc:datafield[@tag=701] or marc:datafield[@tag=702] or marc:datafield[@tag=710] or marc:datafield[@tag=711] or marc:datafield[@tag=712]">
      <span class="result_detail">
      <span class="label">Auteur(s) : </span><span class="valeur">
      <xsl:for-each select="marc:datafield[@tag=700]">
            <a>
               <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='a']">
                <xsl:value-of select="marc:subfield[@code='a']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='g']">
                <xsl:value-of select="marc:subfield[@code='g']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='b']">,
              <xsl:value-of select="marc:subfield[@code='b']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)
            </xsl:if>
            </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text></xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <br />
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag=700] and marc:datafield[@tag>700]/@tag &lt; 800"><br /></xsl:if>

      <xsl:for-each select="marc:datafield[@tag=701]">
          <a>
             <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
            <xsl:if test="marc:subfield[@code='a']">
              <xsl:value-of select="marc:subfield[@code='a']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='g']">
                <xsl:value-of select="marc:subfield[@code='g']"/>
              </xsl:if>
            <xsl:if test="marc:subfield[@code='b']">,
              <xsl:value-of select="marc:subfield[@code='b']"/>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)
            </xsl:if>
          </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text></xsl:text>
            </xsl:when>
            <xsl:otherwise>
		<br />
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag=701] and marc:datafield[@tag>701]/@tag &lt; 800"><br /></xsl:if>

      <xsl:for-each select="marc:datafield[@tag=702]">
          <a>
            <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
	  <xsl:if test="marc:subfield[@code='a']"><xsl:value-of select="marc:subfield[@code='a']"/></xsl:if>
	  <xsl:if test="marc:subfield[@code='g']"><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
          <xsl:if test="marc:subfield[@code='b']">, <xsl:value-of select="marc:subfield[@code='b']"/></xsl:if>
	  <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)</xsl:if>
	  </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
          <xsl:choose><xsl:when test="position()=last()"><xsl:text/></xsl:when><xsl:otherwise> 
<br /></xsl:otherwise></xsl:choose>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag=702] and marc:datafield[@tag>702]/@tag &lt; 800"><br /></xsl:if>

      <xsl:for-each select="marc:datafield[@tag=710]">
            <a>
              <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='a']">
                <xsl:value-of select="marc:subfield[@code='a']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='g']">
                <xsl:value-of select="marc:subfield[@code='g']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='b']">,
              <xsl:value-of select="marc:subfield[@code='b']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='c']"> (<xsl:value-of select="marc:subfield[@code='c']"/>)
            </xsl:if>
              <xsl:if test="marc:subfield[@code='d']">,
              <xsl:value-of select="marc:subfield[@code='d']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='e']">,
              <xsl:value-of select="marc:subfield[@code='e']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)
            </xsl:if>
            </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag=710] and marc:datafield[@tag>710]/@tag &lt; 800"><br /></xsl:if>

      <xsl:for-each select="marc:datafield[@tag=711]">
            <a>
            <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
            <xsl:if test="marc:subfield[@code='a']">
              <xsl:value-of select="marc:subfield[@code='a']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='g']">
                <xsl:value-of select="marc:subfield[@code='g']"/>
              </xsl:if>
            <xsl:if test="marc:subfield[@code='b']">,
              <xsl:value-of select="marc:subfield[@code='b']"/>
            </xsl:if>
              <xsl:if test="marc:subfield[@code='c']"> (<xsl:value-of select="marc:subfield[@code='c']"/>)
            </xsl:if>
            <xsl:if test="marc:subfield[@code='d']">,
              <xsl:value-of select="marc:subfield[@code='d']"/>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='e']">,
              <xsl:value-of select="marc:subfield[@code='e']"/>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)
            </xsl:if>
            </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text/>
              </xsl:when>
              <xsl:otherwise>
                <br />
              </xsl:otherwise>
            </xsl:choose>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag=711] and marc:datafield[@tag>711]/@tag &lt; 800"><br /></xsl:if>

      <xsl:for-each select="marc:datafield[@tag=712]">
            <a>
                  <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="marc:subfield[@code='g']"/><xsl:if test="marc:subfield[@code='b']"><xsl:text>+</xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:if><xsl:text>&amp;idx=author&amp;filters=</xsl:text></xsl:attribute>
              <xsl:if test="marc:subfield[@code='3']">
                <xsl:attribute name="ppn"><xsl:value-of select="marc:subfield[@code='3']"/></xsl:attribute>
              </xsl:if>
	      <xsl:if test="marc:subfield[@code='a']">
		<xsl:value-of select="marc:subfield[@code='a']"/>
	      </xsl:if>
	      <xsl:if test="marc:subfield[@code='g']">
		<xsl:value-of select="marc:subfield[@code='g']"/>
	      </xsl:if>
              <xsl:if test="marc:subfield[@code='b']">,
                <xsl:value-of select="marc:subfield[@code='b']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='c']"> (<xsl:value-of select="marc:subfield[@code='c']"/>)
            </xsl:if>
              <xsl:if test="marc:subfield[@code='d']">,
                <xsl:value-of select="marc:subfield[@code='d']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='e']">,
                <xsl:value-of select="marc:subfield[@code='e']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='f']"> (<xsl:value-of select="marc:subfield[@code='f']"/>)
              </xsl:if>
	    </a>
            <xsl:if test="marc:subfield[@code='4']">
            <xsl:for-each select="marc:subfield[@code='4']">. <xsl:value-of select="."/></xsl:for-each>
            </xsl:if>
          <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text/>
              </xsl:when>
              <xsl:otherwise>
                <br />
              </xsl:otherwise>
            </xsl:choose>
      </xsl:for-each>

      </span></span>
    </xsl:if>
</xsl:template>



<xsl:template name="tag_780"><!-- ? -->
   <xsl:if test="marc:datafield[@tag=780]">
      <xsl:for-each select="marc:datafield[@tag=780]">
        <span class="result_detail">
          <span class="label">
            <xsl:choose>
              <xsl:when test="@ind2=0">
            Continues:
        </xsl:when>
              <xsl:when test="@ind2=1">
            Continues in part:
        </xsl:when>
              <xsl:when test="@ind2=2">
            Supersedes:
        </xsl:when>
              <xsl:when test="@ind2=3">
            Supersedes in part:
        </xsl:when>
              <xsl:when test="@ind2=4">
            Formed by the union: ... and: ...
        </xsl:when>
              <xsl:when test="@ind2=5">
            Absorbed:
        </xsl:when>
              <xsl:when test="@ind2=6">
            Absorbed in part:
        </xsl:when>
              <xsl:when test="@ind2=7">
            Separated from:
        </xsl:when>
            </xsl:choose>
          </span>
          <xsl:variable name="f780">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">at</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <a>
            <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="translate($f780, '()', '')"/></xsl:attribute>
            <xsl:value-of select="translate($f780, '()', '')"/>
          </a>
        </span>
        <xsl:choose>
          <xsl:when test="@ind1=0">
            <span class="result_detail">
              <xsl:value-of select="marc:subfield[@code='n']"/>
            </span>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

<xsl:template name="tag_785"><!-- ? -->
      <xsl:if test="marc:datafield[@tag=785]">
       <xsl:for-each select="marc:datafield[@tag=785]">
        <span class="result_detail">
          <span class="label">
            <xsl:choose>
              <xsl:when test="@ind2=0">
            Continued by:
        </xsl:when>
              <xsl:when test="@ind2=1">
            Continued in part by:
        </xsl:when>
              <xsl:when test="@ind2=2">
            Superseded by:
        </xsl:when>
              <xsl:when test="@ind2=3">
            Superseded in part by:
        </xsl:when>
              <xsl:when test="@ind2=4">
            Absorbed by:
        </xsl:when>
              <xsl:when test="@ind2=5">
            Absorbed in part by:
        </xsl:when>
              <xsl:when test="@ind2=6">
            Split into .. and ...:
        </xsl:when>
              <xsl:when test="@ind2=7">
            Merged with ... to form ...
        </xsl:when>
              <xsl:when test="@ind2=8">
            Changed back to:
        </xsl:when>
            </xsl:choose>
          </span>
          <xsl:variable name="f785">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">at</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <a>
            <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:value-of select="translate($f785, '()', '')"/></xsl:attribute>
            <xsl:value-of select="translate($f785, '()', '')"/>
          </a>
        </span>
      </xsl:for-each>
    </xsl:if>
</xsl:template>

<xsl:template name="tag_856">
 <!--   <xsl:if test="marc:datafield[@tag=856]"> -->
      <xsl:for-each select="marc:datafield[@tag=856]">
     <xsl:if test="not(starts-with(marc:subfield[@code='u'],'http://www.theses.fr') and substring-after(substring-after(substring-after(substring-after(marc:subfield[@code='u'],'/'),'/'),'/'),'/')='document' )"> <!-- test sur le 856_u pour supprimer l'une des 2 url des theses num qui pointe sur tel  -->
     <xsl:if test="marc:subfield[@code='2']"><!-- test sur le 856_2 qui determine les droits d'acces -->
      <span class="result_detail" name="ressource_en_ligne_avec_reserve">
        <span class="label">Ressource en ligne : </span><span class="valeur">
        <a>
         <xsl:attribute name="href">
          <xsl:value-of select="marc:subfield[@code='u']"/>
         </xsl:attribute>
         <xsl:attribute name="target">_blank</xsl:attribute>
          <xsl:choose>
           <xsl:when test="marc:subfield[@code='z']"> <!-- note -->
            <xsl:attribute name="title"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:attribute>
           </xsl:when>
          </xsl:choose>
           <xsl:value-of select="marc:subfield[@code='2']"/>
          <xsl:choose>
           <xsl:when test="marc:subfield[@code='q']"> <!-- format -->
            &#xA0;-&#xA0;<xsl:value-of select="marc:subfield[@code='q']"/>
           </xsl:when>
          </xsl:choose>
        </a>
      </span></span>
      </xsl:if>
     <xsl:if test="not(marc:subfield[@code='2'])"><!-- test sur le 856_2 qui determine les droits d'acces -->
      <span class="result_detail" name="ressource_en_ligne_sans_reserve">
        <span class="label">Ressource en ligne : </span><span class="valeur">
        <a>
         <xsl:attribute name="href">
          <xsl:value-of select="marc:subfield[@code='u']"/>
         </xsl:attribute>
         <xsl:attribute name="target">_blank</xsl:attribute>
          <xsl:choose>
           <xsl:when test="marc:subfield[@code='z']"> <!-- note -->
            <xsl:attribute name="title"><xsl:value-of select="marc:subfield[@code='z']"/></xsl:attribute>
           </xsl:when>
          </xsl:choose>
         <xsl:choose> <!-- test sur 856_u pour les theses num pour différencier url vers tel ou vers pdf -->
           <xsl:when test="starts-with(marc:subfield[@code='u'],'http://www.theses.fr') and substring-after(substring-after(substring-after(substring-after(marc:subfield[@code='u'],'/'),'/'),'/'),'/')='abes'">
           Accès libre : document pdf
           </xsl:when>
           <xsl:when test="starts-with(marc:subfield[@code='u'],'http://tel.archives-ouvertes.fr')">
           Accès libre via Thèses En Ligne (TEL)
           </xsl:when>
           <xsl:otherwise>Accès libre</xsl:otherwise>
         </xsl:choose>
          <xsl:choose>
           <xsl:when test="marc:subfield[@code='q']"> <!-- format -->
            &#xA0;-&#xA0;<xsl:value-of select="marc:subfield[@code='q']"/>
           </xsl:when>
          </xsl:choose>
        </a>
      </span></span>
      </xsl:if>
      </xsl:if>
      </xsl:for-each>
<!--    </xsl:if> -->
</xsl:template>

<xsl:template name="tag_930"><!-- collection perio -->
<!--    <xsl:if test="marc:datafield[@tag=930]">  -->
    <span class="result_detail">
     <span class="label">Collection(s) : </span><span class="valeur">
    <xsl:for-each select="marc:datafield[@tag=930]">
     <xsl:if test="position()!=1">
    <br />
     </xsl:if>
    <xsl:if test="marc:subfield[@code='l']">
     <b><xsl:value-of select="marc:subfield[@code='l']"/></b>&#xA0;
    </xsl:if>
    <xsl:if test="marc:subfield[@code='m']">
     <b><xsl:value-of select="marc:subfield[@code='m']"/></b>&#xA0;
    </xsl:if>:&#xA0;
    <xsl:if test="marc:subfield[@code='h']">
     <xsl:value-of select="marc:subfield[@code='h']"/>&#xA0;
    </xsl:if>
    <xsl:if test="marc:subfield[@code='d']">
      ; &#xA0;cote&#xA0;<xsl:value-of select="marc:subfield[@code='d']"/>&#xA0;
    </xsl:if>
    <xsl:if test="marc:subfield[@code='i']">
      ; &#xA0;<xsl:value-of select="marc:subfield[@code='i']"/>
    </xsl:if>
   </xsl:for-each>
    </span></span>
<!--     </xsl:if>  -->
  </xsl:template>

 <xsl:template name="tag_940"><!-- commande -->
    <br /><span class="result_detail" id="tag940">
    <span class="label">Commande : </span><span class="valeur">
    <xsl:for-each select="marc:datafield[@tag=940]">
     <xsl:if test="marc:subfield[@code='k']">
     <xsl:value-of select="marc:subfield[@code='k']"/>
     </xsl:if>
     <xsl:if test="marc:subfield[@code='i']">
     (<xsl:value-of select="marc:subfield[@code='i']"/>)
     </xsl:if>
     <xsl:if test="not (position() = last())">
      <xsl:text> ; </xsl:text>
     </xsl:if>
    </xsl:for-each>
    </span></span>
  </xsl:template>
  
<xsl:template name="tag_992_old"><!-- descripteurs en3s triée alpha capitalisé -->
<xsl:if test="marc:datafield[@tag=992]">
 <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
 <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
 <span class="result_detail">
 <span class="label">Sujet(s) EN3S : </span><span class="valeur">
 <xsl:for-each select="marc:datafield[@tag=992]">
  <xsl:sort select="marc:subfield[@code='a']" data-type="text" />
  <a>
  <xsl:choose>
   <xsl:when test="marc:subfield[@code=9]">
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
   </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="substring(marc:subfield[@code='a'],1,1)"/>
  <xsl:value-of select="translate(substring(marc:subfield[@code='a'],2), $uppercase, $smallcase)"/>
 </a>
 <xsl:choose>
  <xsl:when test="position()=last()"/>
   <xsl:otherwise><br /></xsl:otherwise>
  </xsl:choose>
 </xsl:for-each>
 </span>
 </span>
</xsl:if>
</xsl:template>

<xsl:template name="tag_992"><!-- descripteurs en3s  -->
<!-- <xsl:if test="marc:datafield[@tag=992]">  -->
 <span class="result_detail">
 <span class="label">Sujet(s) EN3S : </span><span class="valeur">
 <xsl:for-each select="marc:datafield[@tag=992]">
 <xsl:sort select="@ind1" data-type="number" />
 <xsl:choose>
  <xsl:when test="@ind1!=1">
   <xsl:text>&#xa0;&#xa0;</xsl:text>
  </xsl:when>
 </xsl:choose> 
    <a>
  <xsl:choose>
   <xsl:when test="marc:subfield[@code=9]">
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
   </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="marc:subfield[@code='a']"/>
  </a>
 <xsl:choose>
  <xsl:when test="position()=last()"/>
   <xsl:otherwise><br /></xsl:otherwise>
  </xsl:choose>
 </xsl:for-each>
 </span>
 </span>
<!-- </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_993"><!-- descripteurs enase triée alpha capitalisé -->
<!-- <xsl:if test="marc:datafield[@tag=993]">  -->
 <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
 <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
 <span class="result_detail">
 <span class="label">Sujet(s) ENSASE : </span><span class="valeur">
 <xsl:for-each select="marc:datafield[@tag=993]">
  <xsl:sort select="marc:subfield[@code='a']" data-type="text" />
  <a>
  <xsl:choose>
   <xsl:when test="marc:subfield[@code=9]">
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
   </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="substring(marc:subfield[@code='a'],1,1)"/>
  <xsl:value-of select="translate(substring(marc:subfield[@code='a'],2), $uppercase, $smallcase)"/>
 </a>
 <xsl:choose>
  <xsl:when test="position()=last()"/>
   <xsl:otherwise><br /></xsl:otherwise>
  </xsl:choose>
 </xsl:for-each>
 </span>
 </span>
<!-- </xsl:if>  -->
</xsl:template>

<xsl:template name="tag_998"><!-- bib -->
<br /><span class="result_detail" id="tag998">
<span class="label">Bibliothèque(s) : </span><span class="valeur">
<xsl:for-each select="marc:datafield[@tag=998]/marc:subfield[@code='a']">
<xsl:value-of select="."/>
<xsl:choose>
<xsl:when test="position()=last()"/><xsl:text />
<xsl:otherwise> ; </xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</span></span>
</xsl:template>

<xsl:template name="RelatorCode">
       <xsl:if test="marc:subfield[@code=4]">
	    <xsl:choose>
	      <xsl:when test="node()='070'"><xsl:text>, coauteur</xsl:text></xsl:when>
	      <xsl:when test="node()='651'"><xsl:text>, directeur de publication</xsl:text></xsl:when>
	      <xsl:when test="node()='730'"><xsl:text>, traducteur</xsl:text></xsl:when>
              <xsl:when test="node()='080'"><xsl:text>, préfacier</xsl:text></xsl:when>
	      <xsl:when test="node()='340'"><xsl:text>, éditeur</xsl:text></xsl:when>
	      <xsl:when test="node()='440'"><xsl:text>, illustrateur</xsl:text></xsl:when>
	      <xsl:when test="node()='557'"><xsl:text>, organisateur</xsl:text></xsl:when>
	      <xsl:when test="node()='727'"><xsl:text>, directeur de thèse</xsl:text></xsl:when>
	      <xsl:when test="node()='295'"><xsl:text>, établissement de soutenance</xsl:text></xsl:when>
	      <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
	    </xsl:choose>
	  </xsl:if>
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

<xsl:template name="chopSpecialCharacters">
        <xsl:param name="title" />
        <xsl:variable name="ntitle"
             select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
        <xsl:value-of select="$ntitle" />
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
    <xsl:if test="marc:datafield[@tag=$tag]">
      <span class="result_detail">
        <span class="label"><xsl:value-of select="$label"/>: </span>
        <xsl:for-each select="marc:datafield[@tag=$tag]">
          <xsl:value-of select="marc:subfield[@code='a']" />
          <xsl:if test="marc:subfield[@code='d']">
            <xsl:text> : </xsl:text>
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


<xsl:template name="tag_subject">
    <xsl:param name="tag" />
    <xsl:param name="label" />
    <xsl:if test="marc:datafield[@tag=$tag]">
      <span class="result_detail">
        <span class="label"><xsl:value-of select="$label"/>: </span>
        <xsl:for-each select="marc:datafield[@tag=$tag]">
          <a>
            <xsl:choose>
              <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                    <xsl:with-param name="codes">abcdjpvxyz</xsl:with-param>
                    <xsl:with-param name="subdivCodes">jpxyz</xsl:with-param>
                    <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </a>
          <xsl:if test="not (position()=last())">
            <xsl:text> | </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </span>
    </xsl:if>
  </xsl:template>


<xsl:template name="tag_7xx_">
    <xsl:param name="tag" />
    <xsl:param name="label" />
    <xsl:if test="marc:datafield[@tag=$tag]">
      <span class="result_detail">
        <span class="label"><xsl:value-of select="$label" />: </span>
        <xsl:for-each select="marc:datafield[@tag=$tag]">
          <span>
            <xsl:call-template name="addClassRtl" />
            <a>
              <xsl:choose>
                <xsl:when test="marc:subfield[@code=9]">
                  <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='b']"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="marc:subfield[@code='a']">
                <xsl:value-of select="marc:subfield[@code='a']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='b']">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="marc:subfield[@code='b']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='c']">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="marc:subfield[@code='c']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='d']">
                <xsl:text> </xsl:text>
                <xsl:value-of select="marc:subfield[@code='d']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='f']">
                <span dir="ltr">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="marc:subfield[@code='f']"/>
                <xsl:text>)</xsl:text>
                </span>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='g']">
                <xsl:text> </xsl:text>
                <xsl:value-of select="marc:subfield[@code='g']"/>
              </xsl:if>
              <xsl:if test="marc:subfield[@code='p']">
                <xsl:text> </xsl:text>
                <xsl:value-of select="marc:subfield[@code='p']"/>
              </xsl:if>
            </a>
          </span>
          <xsl:if test="not (position() = last())">
            <xsl:text> ; </xsl:text>
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
