<?xml version='1.0'?>

<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>

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
	


	<!-- Mapping RCR -->
	<xsl:template name="RCR">
		<xsl:param name="code"/>
		<xsl:choose>
			<!-- Définir ici l'équivalence des RCRs <=> nom de la bibliothèque -->
			<xsl:when test="$code='352382101'">Bibliothèque Centrale Universitaire </xsl:when>
			<xsl:when test="$code='352382101'">Bibliothèque Centrale Universitaire </xsl:when>
			<xsl:when test="$code='352382221'">Bibliothèque d'Anglais </xsl:when>
			<xsl:when test="$code='352382237'">Bibliothèque d'APS </xsl:when>
			<xsl:when test="$code='352382238'">Bibliothèque d'ALC </xsl:when>
			<xsl:when test="$code='352382233'">Bibliothèque Centrale Universitaire </xsl:when>
			<xsl:when test="$code='352382139'">Médiathèque </xsl:when>
			<xsl:when test="$code='352382136'">Bibliothèque de Musique </xsl:when>
			<xsl:when test="$code='352382212'">Bibliothèque de Sciences Humaines </xsl:when>
			<xsl:when test="$code='352382213'">Bibliothèque de Sciences Sociales </xsl:when>
			<xsl:when test="$code='222782101'">Bibliothèque Campus Mazier (Saint-Brieuc) </xsl:when>
			<xsl:when test="$code='222772103'">Bibliothèque Campus Mazier (Saint-Brieuc) </xsl:when>
			<xsl:when test="$code='352385136'">Bibliothèque F. Lebrun </xsl:when>
			<xsl:when test="$code='352389902'">Bibliothèque en ligne </xsl:when>
			<xsl:otherwise><xsl:value-of select="$code"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="string-replace-all">
	  <xsl:param name="text"/>
	  <xsl:param name="replace"/>
	  <xsl:param name="by"/>
	  <xsl:choose>
	    <xsl:when test="contains($text,$replace)">
	      <xsl:value-of select="substring-before($text,$replace)"/>
	      <xsl:value-of select="$by"/>
	      <xsl:call-template name="string-replace-all">
	        <xsl:with-param name="text" select="substring-after($text,$replace)"/>
	        <xsl:with-param name="replace" select="$replace"/>
	        <xsl:with-param name="by" select="$by"/>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$text"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>

	<xsl:template name="tag_title">
		<xsl:param name="tag"/>
		<xsl:param name="label"/>
		<xsl:if test="marc:datafield[@tag=$tag]">
			<tr valign="top">
				<th><xsl:value-of select="$label"/> : </th><td>
				<xsl:for-each select="marc:datafield[@tag=$tag]">
					<xsl:value-of select="marc:subfield[@code='a']"/>
					<xsl:if test="marc:subfield[@code='d']">
						<xsl:text>&#160;: </xsl:text>
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
					<xsl:if test="marc:subfield[@code='t']">
						<xsl:text></xsl:text>
						<xsl:value-of select="marc:subfield[@code='t']"/>
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
			</td></tr>
		</xsl:if>
	</xsl:template>


	<xsl:template name="tag_410">
		<xsl:param name="tag"/>
		<xsl:param name="label"/>
		<xsl:if test="marc:datafield[@tag=410]">
			<tr valign="top">
				<th>Collection : </th><td>
				<xsl:for-each select="marc:datafield[@tag=410]">
					<div class="subjectLine">
						<xsl:if test="marc:subfield[@code='t']">
							<a>
								<!--<xsl:choose>
								<xsl:when test="marc:subfield[@code=0]">
								<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=se,phr&amp;q=<xsl:value-of select="marc:subfield[@code=0]"/></xsl:attribute>
								<xsl:attribute name="title">Voir d'autres documents de la même collection</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>-->
									<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=se,phr&amp;q=<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute>
									<xsl:attribute name="title">Voir d'autres documents de la même collection</xsl:attribute>
									<!--</xsl:otherwise>
									</xsl:choose>-->
									<xsl:value-of select="marc:subfield[@code='t']"/>
								</a>
							</xsl:if>
							<xsl:if test="marc:subfield[@code='v']">
								<xsl:for-each select="marc:subfield[@code='v']">
									<xsl:text>,&#160; n°</xsl:text>
									<xsl:value-of select="."/>
								</xsl:for-each>
							</xsl:if>
						</div>
					</xsl:for-each>
				</td></tr>
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
					<xsl:otherwise><xsl:text/></xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:template>

		<xsl:template name="tag_01x">
			<xsl:param name="tag"/>
			<xsl:param name="label"/>
			<xsl:if test="marc:datafield[@tag=$tag]/marc:subfield[@code='a']">
				<tr valign="top">
					<th><xsl:value-of select="$label"/> : </th><td>
					<xsl:for-each select="marc:datafield[@tag=$tag]">
						<xsl:call-template name="addClassRtl"/>
						<xsl:for-each select="marc:subfield[@code='a']">
							<xsl:value-of select="."/>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> ; </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</td></tr>
			</xsl:if>
		</xsl:template>

		<xsl:template name="tag_010">
			<xsl:param name="tag"/>
			<xsl:param name="label"/>
			<xsl:if test="marc:datafield[@tag=$tag]/marc:subfield[@code='a']">
				<tr valign="top">
					<th><xsl:value-of select="$label"/> : </th><td>
					<xsl:for-each select="marc:datafield[@tag=$tag]">
						<xsl:call-template name="addClassRtl"/>
						<xsl:for-each select="marc:subfield[@code='a']">
							<div class="ISBN"><xsl:value-of select="."/></div>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> ; </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</td></tr>
			</xsl:if>
		</xsl:template>

		<xsl:template name="tag_011">
			<xsl:param name="tag"/>
			<xsl:param name="label"/>
			<xsl:if test="marc:datafield[@tag=$tag]/marc:subfield[@code='a']">
				<tr valign="top">
					<th><xsl:value-of select="$label"/> : </th><td>
					<xsl:for-each select="marc:datafield[@tag=$tag]">
						<xsl:call-template name="addClassRtl"/>
						<xsl:for-each select="marc:subfield[@code='a']">
							<div class="ISSN"><xsl:value-of select="."/></div>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> ; </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</td></tr>
			</xsl:if>
		</xsl:template>

		<xsl:template name="tag_011_results">
			<xsl:param name="tag"/>
			<xsl:param name="label"/>
			<span class="results_summary">
				<span class="label">ISSN : </span>
				<xsl:if test="marc:datafield[@tag=$tag]/marc:subfield[@code='a']">
					<xsl:for-each select="marc:datafield[@tag=$tag]">
						<xsl:call-template name="addClassRtl"/>
						<xsl:for-each select="marc:subfield[@code='a']">
							<span class="ISSN"><xsl:value-of select="."/></span>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> ; </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
			</span>
		</xsl:template>




		<xsl:template name="tag_101">
			<xsl:if test="marc:datafield[@tag=101]">
				<tr valign="top">
					<th>Langue<xsl:if test="count(marc:datafield[starts-with(@tag,'101')])&#62;1">s</xsl:if>: </th><td>
					<xsl:for-each select="marc:datafield[@tag=101]">
						<xsl:for-each select="marc:subfield">
							<xsl:choose>
								<xsl:when test="@code='b'">de la trad. intermédiaire, </xsl:when>
								<xsl:when test="@code='c'">de l'œuvre originale, </xsl:when>
								<xsl:when test="@code='d'">du résumé, </xsl:when>
								<xsl:when test="@code='e'">de la table des matières, </xsl:when>
								<xsl:when test="@code='f'">de la page de titre, </xsl:when>
								<xsl:when test="@code='g'">du titre propre, </xsl:when>
								<xsl:when test="@code='h'">d'un livret, </xsl:when>
								<xsl:when test="@code='i'">des textes d'accompagnement, </xsl:when>
								<xsl:when test="@code='j'">des sous-titres, </xsl:when>
							</xsl:choose>
							<xsl:value-of select="text()"/>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> ; </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</td></tr>
			</xsl:if>
		</xsl:template>





		<!-- 102 PAYS DE PUBLICATION -->
		<xsl:template name="tag_102">
			<xsl:if test="marc:datafield[@tag=102]">
				<tr valign="top">
					<th>Pays de publication : </th><td>
					<xsl:for-each select="marc:datafield[@tag=102]">
						<xsl:for-each select="marc:subfield">
							<xsl:value-of select="text()"/>
							<xsl:choose>
								<xsl:when test="position()=last()">
									<xsl:text></xsl:text>
								</xsl:when>
								<xsl:otherwise><xsl:text>, </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:for-each>
			</td></tr>
		</xsl:if>
	</xsl:template>



	<xsl:template name="tag_subject">
		<xsl:param name="tag" />
		<xsl:param name="label" />
		<xsl:if test="marc:datafield[@tag=$tag]">
			<tr valign="top">
				<th><xsl:value-of select="$label"/>: </th><td>
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
									<xsl:with-param name="codes">abcdjptvxyz</xsl:with-param>
									<xsl:with-param name="subdivCodes">jptxyz</xsl:with-param>
									<xsl:with-param name="subdivDelimiter"> -- </xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</a>
					<xsl:if test="not (position()=last())">
						<xsl:text> | </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td></tr>
		</xsl:if>
	</xsl:template>


	<xsl:template name="tag_genre">
		<xsl:if test="marc:datafield[@tag=608]">
			<tr valign="top">
				<th>Genre : </th><td>
				<xsl:apply-templates select="marc:datafield[@tag=608]" />
			</td>
		</tr>
	</xsl:if>
</xsl:template>

<xsl:template match="marc:datafield[@tag=608]">
	<div class="subjectLine sujets">
		<xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='f' or @code='t' or @code='j' or  @code='x' or @code='y' or @code='z']">
			<xsl:if test="position() > 1">
				<xsl:element name="a">
					<xsl:attribute name="class">glu</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=su&amp;q=</xsl:text>
						<xsl:for-each select="preceding-sibling::*[@code='a' or @code='f' or @code='j' or @code='t' or @code='x' or @code='y' or @code='z']">
							<xsl:if test="position() > 1">
								<xsl:text>+</xsl:text>
							</xsl:if>
							<xsl:value-of select="." />
						</xsl:for-each>
						<xsl:text>+</xsl:text>
						<xsl:value-of select="." />
					</xsl:attribute>
					<xsl:text>></xsl:text>
				</xsl:element>
			</xsl:if>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=</xsl:text>
					<xsl:choose>
						<xsl:when test="(preceding-sibling::*[1][@code='3']) and (../*[@code='9'])">
							<xsl:variable name="d9i" select="position()-count(preceding-sibling::*[@code='a' or @code='f' or @code='j' or @code='t' or @code='x' or @code='y' or @code='z'][preceding-sibling::*[1][@code!=3]])" />
							<xsl:text>an&amp;q=</xsl:text>
							<xsl:value-of select="../*[@code='9'][$d9i]" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>su&amp;q=</xsl:text>
							<xsl:value-of select="." />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:for-each>
	</div>
</xsl:template>


<xsl:template name="tag_subjects">
		<xsl:if test="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=610]">
			<tr valign="top">
				<th>Sujets : </th><td>
				<xsl:apply-templates select="marc:datafield[@tag=600]" />
				<xsl:apply-templates select="marc:datafield[@tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=610]" />
			</td>
		</tr>
	</xsl:if>
</xsl:template>

<xsl:template match="marc:datafield[@tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=610]">
	<div class="subjectLine sujets">
		<xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='f' or @code='t' or @code='j' or  @code='x' or @code='y' or @code='z']">
			<xsl:if test="position() > 1">
				<xsl:element name="a">
					<xsl:attribute name="class">glu</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=su&amp;q=</xsl:text>
						<xsl:for-each select="preceding-sibling::*[@code='a' or @code='f' or @code='j' or @code='t' or @code='x' or @code='y' or @code='z']">
							<xsl:if test="position() > 1">
								<xsl:text>+</xsl:text>
							</xsl:if>
							<xsl:value-of select="." />
						</xsl:for-each>
						<xsl:text>+</xsl:text>
						<xsl:value-of select="." />
					</xsl:attribute>
					<xsl:text>></xsl:text>
				</xsl:element>
			</xsl:if>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=</xsl:text>
					<xsl:choose>
						<xsl:when test="(preceding-sibling::*[1][@code='3']) and (../*[@code='9'])">
							<xsl:variable name="d9i" select="position()-count(preceding-sibling::*[@code='a' or @code='f' or @code='j' or @code='t' or @code='x' or @code='y' or @code='z'][preceding-sibling::*[1][@code!=3]])" />
							<xsl:text>an&amp;q=</xsl:text>
							<xsl:value-of select="../*[@code='9'][$d9i]" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>su&amp;q=</xsl:text>
							<xsl:value-of select="." />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:for-each>
	</div>
</xsl:template>




<xsl:template match="marc:datafield[@tag=600]">
	<div class="subjectLine sujets">
		<xsl:for-each select="marc:subfield[@code='a' or @code='j' or @code='x' or @code='y' or @code='z']">
			<xsl:if test="position() > 1">
				<xsl:element name="a">
					<xsl:attribute name="class">glu</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=su&amp;q=</xsl:text>
						<xsl:for-each select="preceding-sibling::*[@code='a' or @code='j' or @code='x' or @code='y' or @code='z']">
							<xsl:if test="position() > 1">
								<xsl:text>+</xsl:text>
							</xsl:if>
							<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
								<xsl:value-of select="../*[@code='b']"/>
								<xsl:text> </xsl:text>

							</xsl:if>
							<xsl:value-of select="." />
						</xsl:for-each>
						<xsl:text>+</xsl:text>
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
							<xsl:value-of select="../*[@code='b']"/>
							<xsl:text> </xsl:text>

						</xsl:if>
						<xsl:value-of select="." />
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='c'])">
							<xsl:text> </xsl:text>
							<xsl:value-of select="../*[@code='c']"/>
						</xsl:if>
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='f'])">
							<xsl:text> </xsl:text>
							<xsl:value-of select="../*[@code='f']"/>
						</xsl:if>
						<xsl:text> </xsl:text>
					</xsl:attribute>
					<xsl:attribute name="rel">nofollow</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:text>Recherche sur les sujets combinés "</xsl:text>
						<xsl:for-each select="preceding-sibling::*[@code='a' or @code='j' or @code='x' or @code='y' or @code='z']">
							<xsl:if test="position() > 1">
								<xsl:text>", "</xsl:text>
							</xsl:if>
							<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
								<xsl:value-of select="../*[@code='b']"/>
								<xsl:text> </xsl:text>

							</xsl:if>
							<xsl:value-of select="." />
						</xsl:for-each>
						<xsl:text>" et "</xsl:text>
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
							<xsl:value-of select="../*[@code='b']"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:value-of select="." />
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='c'])">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="../*[@code='c']"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='f'])">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="../*[@code='f']"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:text>"</xsl:text>
					</xsl:attribute>
					<xsl:text>></xsl:text>
				</xsl:element>
			</xsl:if>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=</xsl:text>
					<xsl:choose>
						<xsl:when test="(preceding-sibling::*[1][@code='3']) and (../*[@code='9'])">
							<xsl:variable name="d9i" select="position()-count(preceding-sibling::*[@code='a'  or @code='j' or @code='x' or @code='y' or @code='z'][preceding-sibling::*[1][@code!=3]])" />
							<xsl:text>an&amp;q=</xsl:text>
							<xsl:value-of select="../*[@code='9'][$d9i]" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>su&amp;q=</xsl:text>
							<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
								<xsl:value-of select="../*[@code='b']"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:value-of select="." />
							<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='c']) ">
								<xsl:text> </xsl:text>
								<xsl:value-of select="../*[@code='c']"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='f'])">
								<xsl:text> </xsl:text>
								<xsl:value-of select="../*[@code='f']"/>
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="rel">nofollow</xsl:attribute>
				<xsl:attribute name="class">subject</xsl:attribute>
				<xsl:attribute name="title">
					<xsl:text>Recherche sur le sujet "</xsl:text>
					<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
						<xsl:value-of select="../*[@code='b']"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="." />
					<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='c'])">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="../*[@code='c']"/>
						<xsl:text>)</xsl:text>
					</xsl:if>
					<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='f'])">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="../*[@code='f']"/>
						<xsl:text>)</xsl:text>
					</xsl:if>
					<xsl:text>"</xsl:text>
				</xsl:attribute>
				<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='b'])">
					<xsl:value-of select="../*[@code='b']"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="." />
				<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='c'])">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="../*[@code='c']"/>
					<xsl:text>)</xsl:text>
				</xsl:if>
				<xsl:if test="(../@tag=600) and (@code='a') and (../*[@code='f'])">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="../*[@code='f']"/>
					<xsl:text>)</xsl:text>
				</xsl:if>
			</xsl:element>
		</xsl:for-each>
	</div>
</xsl:template>




<xsl:template name="tag_6XX">
	<xsl:if test="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604 or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610]">
		<tr valign="top">
			<th>Sujets : </th><td>
			<xsl:for-each select="marc:datafield[@tag=600 or @tag=601 or @tag=602 or @tag=604  or @tag=605 or @tag=606 or @tag=607 or @tag=608 or @tag=610]">
				<div class="subjectLine"><a>
					<xsl:choose>
						<xsl:when test="marc:subfield[@code=9]">
							<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=an,phr&amp;q=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
							<xsl:attribute name="title">Trouver des documents avec le même sujet</xsl:attribute>
							<xsl:choose>
								<xsl:when test="string-length(marc:subfield[@code='a'])&#62;0">
									<xsl:call-template name="chopPunctuation">
										<xsl:with-param name="chopString">
											<xsl:copy-of select="marc:subfield[@code='a']"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>

							</xsl:choose>

						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=su&amp;q=<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
							<xsl:attribute name="title">Trouver des documents avec le même sujet</xsl:attribute>
							<xsl:choose>
								<xsl:when test="string-length(marc:subfield[@code='a'])&#62;0">
									<xsl:call-template name="chopPunctuation">
										<xsl:with-param name="chopString">
											<xsl:copy-of select="marc:subfield[@code='a']"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>

							</xsl:choose>
						</xsl:otherwise>


					</xsl:choose>
					<xsl:call-template name="chopPunctuation">
						<xsl:with-param name="chopString">
							<xsl:call-template name="subfieldSelect">
								<xsl:with-param name="codes">bcdjpvxyz</xsl:with-param>
								<xsl:with-param name="subdivCodes">jpxyz</xsl:with-param>
								<xsl:with-param name="subdivDelimiter"> > </xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</a></div>
			</xsl:for-each>
		</td></tr>
	</xsl:if>
</xsl:template>


<!-- AERES -->
<xsl:template name="tag_619">
	<xsl:for-each select="marc:datafield[@tag=619]/marc:subfield[@code='a']">
		<tr valign="top">
			<th>Classement AERES&#160;: </th><td>
			<xsl:if test="marc:datafield[@tag=619]/marc:subfield[@code='a']">
				<xsl:value-of select="marc:datafield[@tag=619]/marc:subfield[@code='a']"/>
			</xsl:if>
		</td></tr>
	</xsl:for-each>
</xsl:template>



<xsl:template name="tag_205">
	<xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a']">
		<xsl:for-each select="marc:datafield[@tag=205]">
			<span class="results_summary">
				<span class="label">Édition : </span>
				<xsl:if test="marc:subfield[@code='a']">
					<xsl:value-of select="marc:subfield[@code='a']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='b']">
					<xsl:if test="marc:subfield[@code='a']">
						<xsl:text>&#160;</xsl:text>
					</xsl:if>
					<xsl:value-of select="marc:subfield[@code='b']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='f']">
					<xsl:if test="marc:subfield[@code='a']">
						<xsl:text> / </xsl:text>
					</xsl:if>
					<xsl:value-of select="marc:subfield[@code='f']"/>
				</xsl:if>
			</span>
		</xsl:for-each>
	</xsl:if>
</xsl:template>

<xsl:template name="tag_205_details">
	<xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a']">
		<xsl:for-each select="marc:datafield[@tag=205]">
			<tr valign="top">
				<th>Édition&#160;: </th><td>
				<xsl:if test="marc:subfield[@code='a']">
					<xsl:value-of select="marc:subfield[@code='a']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='b']">
					<xsl:if test="marc:subfield[@code='a']">
						<xsl:text>&#160;</xsl:text>
					</xsl:if>
					<xsl:value-of select="marc:subfield[@code='b']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='f']">
					<xsl:if test="marc:subfield[@code='a']">
						<xsl:text> / </xsl:text>
					</xsl:if>
					<xsl:value-of select="marc:subfield[@code='f']"/>
				</xsl:if>
			</td></tr>
		</xsl:for-each>
	</xsl:if>
</xsl:template>

<!-- <xsl:template name="tag_210">
	<xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='c'] or marc:datafield[@tag=210]/marc:subfield[@code='a']">

		<tr valign="top">
			<th>Éditeur<xsl:if test="count(marc:datafield[starts-with(@tag,'210')])&#62;1">s</xsl:if>&#160;: </th><td>
			<xsl:for-each select="marc:datafield[@tag=210]">
				<div id="subjectline"><xsl:value-of select="marc:subfield[@code='a']"/>
				<xsl:if test="marc:subfield[@code='c']">
					<xsl:if test="marc:subfield[@code='a']">&#160;: </xsl:if>
					<xsl:element name="a">
						<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=pb&amp;q=<xsl:value-of select="marc:subfield[@code='c']"/></xsl:attribute>
						<xsl:value-of select="marc:subfield[@code='c']"/>
					</xsl:element>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$datepubli">
						<xsl:if test="marc:subfield[@code='a' or @code='c']">, </xsl:if>
						<xsl:value-of select="$datepubli"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="marc:subfield[@code='d']">
							<xsl:if test="marc:subfield[@code='a' or @code='c']">, </xsl:if>
							<xsl:value-of select="marc:subfield[@code='d']"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:for-each>
	</td>
</tr>
</xsl:if>
</xsl:template> -->

<!-- <xsl:variable name="unimarc100" select="marc:datafield[@tag=100]/marc:subfield[@code='a']"/>
<xsl:variable name="datepubli" select="substring($unimarc100,10,4)"/> -->
<xsl:template name="tag_210_214">
	<tr valign="top">
		<th>Éditeur<xsl:if test="count(marc:datafield[starts-with(@tag,'210')] | marc:datafield[starts-with(@tag,'214')])&#62;1">s</xsl:if>&#160;: </th>
		<td>
		<xsl:for-each select="marc:datafield[@tag=210] | marc:datafield[starts-with(@tag,'214')]">
			<div>
				<xsl:call-template name="addClassRtl" />
				<xsl:for-each select="marc:subfield">
          <xsl:choose>
            <xsl:when test="@code='6' or @code='7'">
              <xsl:text></xsl:text>
            </xsl:when>
						<xsl:when test="@code='c'">
							<xsl:if test="position()>1">
								<xsl:text> : </xsl:text>
							</xsl:if>
							<xsl:element name="a">
								<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=pb&amp;q=<xsl:value-of select="."/></xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:when>
            <xsl:when test="@code='d'">
                <xsl:choose>
                    <xsl:when test="../@tag=214 and ../@ind2=4">
                        <xsl:choose>
                            <xsl:when test="substring(.,1,1)='C'">
                                <xsl:text>Copyright</xsl:text>
                                <xsl:value-of select="substring(.,2)"/>
                            </xsl:when>
                            <xsl:when test="substring(.,1,1)='P'">
                                <xsl:text>Protection</xsl:text>
                                <xsl:value-of select="substring(.,2)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="(preceding-sibling::*[@code='a'] or preceding-sibling::*[@code='c'])">
                            <xsl:text>,&#160;</xsl:text>
                        </xsl:if>   
                            <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@code='e'">
              <xsl:if test="position()>1">
                <xsl:text>&#160;(</xsl:text>
              </xsl:if>
                <xsl:value-of select="."/>
                <xsl:if test="not(following-sibling::*[@code='g'])">
                  <xsl:text>)&#160;</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@code='g'">
              <xsl:if test="preceding-sibling::*[@code='e']">
              <xsl:if test="position()>1">
                <xsl:text> : </xsl:text>
              </xsl:if>
                <xsl:value-of select="."/>
                <xsl:text>)&#160;</xsl:text>
              </xsl:if>
              <xsl:if test="not(preceding-sibling::*[@code='e'])">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>) </xsl:text>
              </xsl:if>
            </xsl:when>
          <xsl:when test="@code='a'">
              <xsl:if test="preceding-sibling::*[@code='a']">
                <xsl:text> ; </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:when>
						<xsl:otherwise>
							<xsl:if test="position()>1">
							</xsl:if>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</div>
		</xsl:for-each>
	</td>
</tr>
</xsl:template>

<xsl:template name="tag_210_214_r">
	<li>
		<xsl:for-each select="marc:datafield[@tag=210] | marc:datafield[@tag=214]">
			<span>
				<xsl:call-template name="addClassRtl" />
				<xsl:for-each select="marc:subfield">
					<xsl:choose>
            <xsl:when test="@code='6' or @code='7' or @code='e' or @code='g'">
              <xsl:text></xsl:text>
            </xsl:when>
						<xsl:when test="@code='c'">
							<xsl:if test="position()>1">
								<xsl:text> : </xsl:text>
							</xsl:if>
							<xsl:element name="a">
								<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?idx=pb&amp;q=<xsl:value-of select="."/></xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:when>
            <xsl:when test="@code='d'">
              <xsl:text>,&#160;</xsl:text>
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="@code='a'">
                <xsl:if test="preceding-sibling::*[@code='a']">
                    <xsl:text> ; </xsl:text>
                </xsl:if>
                <xsl:value-of select="."/>
            </xsl:when>
						<xsl:otherwise>
							<xsl:if test="position()>1">
							</xsl:if>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:if test="not (position() = last())">
					<xsl:text> • </xsl:text>
				</xsl:if>
			</span>
		</xsl:for-each>
</li>
</xsl:template>


<xsl:template name="tag_215_r">
 <xsl:for-each select="marc:datafield[@tag=215]">
 <li>

 <xsl:if test="marc:subfield[@code='a']">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']"> : <xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']"> ; <xsl:value-of select="marc:subfield[@code='d']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']"> 
	 <xsl:for-each select="marc:subfield[@code='e']">
				<xsl:text> +  </xsl:text>
				<xsl:value-of select="."/>			
	</xsl:for-each>
 </xsl:if>
 </li>
 </xsl:for-each>
 </xsl:template>



<xsl:template name="tag_215">
	<xsl:for-each select="marc:datafield[@tag=215]">
		<tr valign="top">
			<th>Description : </th><td>
			<xsl:if test="marc:subfield[@code='a']">
				<xsl:value-of select="marc:subfield[@code='a']"/>
			</xsl:if>
			<xsl:if test="marc:subfield[@code='c']">&#160;: <xsl:value-of select="marc:subfield[@code='c']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='d']"> ; <xsl:value-of select="marc:subfield[@code='d']"/>
	</xsl:if>
   <xsl:if test="marc:subfield[@code='e']"> 
	 <xsl:for-each select="marc:subfield[@code='e']">
				<xsl:text> +  </xsl:text>
				<xsl:value-of select="."/>			
	</xsl:for-each>
 </xsl:if>
</td>
</tr>
</xsl:for-each>
</xsl:template>


<xsl:template name="tag_3xx">
	<xsl:param name="tag"/>
	<xsl:param name="label"/>
	<xsl:if test="marc:datafield[@tag=$tag]/marc:subfield[@code='a']">
		<tr valign="top">
			<th><xsl:value-of select="$label"/> : </th><td>
			<xsl:for-each select="marc:datafield[@tag=$tag]">
				<xsl:call-template name="addClassRtl"/>
				<xsl:for-each select="marc:subfield[@code='a']">

				<xsl:choose>
					<xsl:when test="following-sibling::*[1][@code='u']">
					<div>
						<a>
						 <xsl:attribute name="href">
								<xsl:value-of select="following-sibling::*[1][@code='u']"/>
						 </xsl:attribute>
						 <xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:value-of select="."/>
						</a>
						<xsl:choose>
							<xsl:when test="position()=last()">
								<xsl:text>. </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text></xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					</xsl:when>
					<xsl:otherwise>
					<div>
						<xsl:value-of select="."/>
						<xsl:choose>
							<xsl:when test="position()=last()">
								<xsl:text>. </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text></xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					</xsl:otherwise>
				</xsl:choose>

				</xsl:for-each>
			</xsl:for-each>
		</td></tr>
	</xsl:if>
</xsl:template>



<xsl:template name="tag_328">
	<xsl:if test="marc:datafield[@tag=328]">
		<tr valign="top">
			<th>Thèse ou autre travail universitaire : </th><td>
			<xsl:for-each select="marc:datafield[@tag=328]">
				<xsl:if test="marc:subfield[@code='z']">
					<xsl:value-of select="marc:subfield[@code='z']"/>
					<xsl:text> : </xsl:text>
				</xsl:if>
				<xsl:value-of select="marc:subfield[@code='a']"/>
				<xsl:value-of select="marc:subfield[@code='b']"/>
				<xsl:if test="marc:subfield[@code='c']">
					<xsl:text>&#160;: </xsl:text>
					<xsl:value-of select="marc:subfield[@code='c']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='e']">
					<xsl:text>&#160;: </xsl:text>
					<xsl:value-of select="marc:subfield[@code='e']"/>
				</xsl:if>
				<xsl:if test="marc:subfield[@code='d']">
					<xsl:text>&#160;: </xsl:text>
					<xsl:value-of select="marc:subfield[@code='d']"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="position()=last()">
						<xsl:text>. </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</td></tr>
	</xsl:if>
</xsl:template>

<xsl:template name="tag_328_r">
		<xsl:if test="marc:datafield[@tag=328]">
			 <li>
				<xsl:for-each select="marc:datafield[@tag=328]">
					<xsl:if test="marc:subfield[@code='z']">
						<xsl:value-of select="marc:subfield[@code='z']"/>
						<xsl:text> : </xsl:text>
					</xsl:if>
					<xsl:value-of select="marc:subfield[@code='a']"/>
					<xsl:value-of select="marc:subfield[@code='b']"/>
					<xsl:if test="marc:subfield[@code='c']">
						<xsl:text>&#160;: </xsl:text>
						<xsl:value-of select="marc:subfield[@code='c']"/>
					</xsl:if>
					<xsl:if test="marc:subfield[@code='e']">
						<xsl:text>&#160;: </xsl:text>
						<xsl:value-of select="marc:subfield[@code='e']"/>
					</xsl:if>
					<xsl:if test="marc:subfield[@code='d']">
						<xsl:text>&#160;: </xsl:text>
						<xsl:value-of select="marc:subfield[@code='d']"/>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="position()=last()">
							<xsl:text>. </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</li>
		</xsl:if>
</xsl:template>




<xsl:template name="tag_4xx_r">
 <xsl:for-each select="marc:datafield[@tag=464 or @tag=461]">
 <li>
 <strong>relié avec&#160;: </strong>
 <span>
 <xsl:call-template name="addClassRtl" />
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']"> : <xsl:value-of select="marc:subfield[@code='e']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='f']"> / <xsl:value-of select="marc:subfield[@code='f']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='v']">, <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 </span>
 </li>
 </xsl:for-each>
 </xsl:template>

<xsl:template name="tag_4xx">
	<xsl:if test="marc:datafield[@tag=412]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="412"/>
			<xsl:with-param name="lab">Extrait de&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
	<xsl:if test="marc:datafield[@tag=413]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="413"/>
			<xsl:with-param name="lab">A pour extrait&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=422]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="422"/>
			<xsl:with-param name="lab">Supplément de&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=421]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="421"/>
			<xsl:with-param name="lab">A pour supplément&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=423]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="423"/>
			<xsl:with-param name="lab">Publié avec&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=424]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="424"/>
			<xsl:with-param name="lab">Est mis à jour par&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=425]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="425"/>
			<xsl:with-param name="lab">Met à jour&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=430]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="430"/>
			<xsl:with-param name="lab">Suite de&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=431]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="431"/>
			<xsl:with-param name="lab">Succède après scission à&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=432]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="432"/>
			<xsl:with-param name="lab">Remplace&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=433]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="433"/>
			<xsl:with-param name="lab">Remplace partiellement&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=434]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="434"/>
			<xsl:with-param name="lab">Absorbe&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=435]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="435"/>
			<xsl:with-param name="lab">Absorbe partiellement&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=436]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="436"/>
			<xsl:with-param name="lab">Fusion de&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=437]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="437"/>
			<xsl:with-param name="lab">Suite partielle de&#160;:</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=440]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="440"/>
			<xsl:with-param name="lab">Devient&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=441]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="441"/>
			<xsl:with-param name="lab">Devient partiellement&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=442]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="442"/>
			<xsl:with-param name="lab">Remplacé par&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=443]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="443"/>
			<xsl:with-param name="lab">Remplacé partiellement par&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=444]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="444"/>
			<xsl:with-param name="lab">Absorbé par&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=445]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="445"/>
			<xsl:with-param name="lab">Absorbé partiellement par&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=446]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="446"/>
			<xsl:with-param name="lab">Scindé en&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=447]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="447"/>
			<xsl:with-param name="lab">Fusionne avec&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=448]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="448"/>
			<xsl:with-param name="lab">Redevientt&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=451]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="451"/>
			<xsl:with-param name="lab">Autres éditions sur un même support&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=452]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="452"/>
			<xsl:with-param name="lab">Autres éditions sur un autre support&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=453]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="453"/>
			<xsl:with-param name="lab">Traduit sous le titre&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=454]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="454"/>
			<xsl:with-param name="lab">Est un traduction de&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=455]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="455"/>
			<xsl:with-param name="lab">Reproduction de&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=456]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="456"/>
			<xsl:with-param name="lab">Reproduit comme&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=461]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="461"/>
			<xsl:with-param name="lab">Fait partie de&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=488]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="488"/>
			<xsl:with-param name="lab">Autres oeuvres en liaison&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>


	<xsl:if test="marc:datafield[@tag=462]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="462"/>
			<xsl:with-param name="lab">Sous-ensemble&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="marc:datafield[@tag=463]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="463"/>
			<xsl:with-param name="lab">Comprend&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>

	<xsl:if test="marc:datafield[@tag=464]">
		<xsl:call-template name="table">
			<xsl:with-param name="tag" select="464"/>
			<xsl:with-param name="lab">Contient&#160;: </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="table">
	<xsl:param name="tag"/>
	<xsl:param name="lab"/>
	<tr valign="top">
		<th><xsl:value-of select="$lab"/></th><td>
		<xsl:choose>
			<xsl:when test="count(marc:datafield[@tag=$tag])&#62;1">
				<xsl:for-each select="marc:datafield[@tag=$tag]">
					<div class="subjectLine"><xsl:call-template name="tag_list"/></div>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="count(marc:datafield[@tag=$tag])=1">
				<xsl:for-each select="marc:datafield[@tag=$tag]">
					<div class="subjectLine"><xsl:call-template name="tag_list"/></div>
				</xsl:for-each>
			</xsl:when>

		</xsl:choose>

	</td></tr>
</xsl:template>


<xsl:template name="tag_list">
	<xsl:choose>

		<xsl:when test="count(key('intralinks', marc:subfield[@code='0']))&#62;0">
			<a>
				<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="marc:subfield[@code='x']"/>
			</xsl:attribute>
			<xsl:attribute name="rel">nofollow</xsl:attribute>
			<xsl:attribute name="class">subject</xsl:attribute>
			<xsl:value-of select="marc:subfield[@code='t']"/>
			<xsl:if test="marc:subfield[@code='x']">
				<xsl:text> (ISSN </xsl:text>
				<xsl:value-of select="marc:subfield[@code='x']"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
		</a>
	</xsl:when>
	<xsl:when test="marc:subfield[@code='0']">
			<xsl:element name="a">
					<xsl:attribute name="class">glu</xsl:attribute>
					<xsl:attribute name="href">/r2microws/rebound.php?ppn=<xsl:value-of select="marc:subfield[@code=0]"/></xsl:attribute>
					<xsl:attribute name="title">Ce document est-il disponible dans notre catalogue ou dans une autre bibliothèque ?</xsl:attribute>
					<xsl:attribute name="class">ppn</xsl:attribute>
					<xsl:value-of select="marc:subfield[@code='t']"/>
		<xsl:if test="marc:subfield[@code='b']">
			<xsl:for-each select="marc:subfield[@code='b']">
				<xsl:text> [</xsl:text>
				<xsl:value-of select="."/>
				<xsl:if test="following-sibling::*[1][@code='t']">
					<xsl:text>, [</xsl:text>
					<xsl:value-of select="following-sibling::*[1]"/>
				</xsl:if>
				<xsl:text>] </xsl:text>

			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='o']">
			<xsl:for-each select="marc:subfield[@code='o']">
				<xsl:text>&#160;: </xsl:text>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='e']">
			<xsl:for-each select="marc:subfield[@code='e']">
				<xsl:if test="not(preceding-sibling::*[@code='d'])">
					<xsl:text>. - </xsl:text>
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='h']">
			<xsl:for-each select="marc:subfield[@code='h']">
				<xsl:text>. </xsl:text>
				<xsl:value-of select="."/>
				<xsl:if test="following-sibling::*[1][@code='i']">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="following-sibling::*[1]"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='i']">
			<xsl:for-each select="marc:subfield[@code='i']">
				<xsl:if test="not(preceding-sibling::*[1][@code='h'])">
					<xsl:text>. </xsl:text>
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='l']">
			<xsl:text>&#160;=&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='l']"/>
		</xsl:if>

		<xsl:if test="marc:subfield[@code='f']">
			<xsl:text> / </xsl:text>
			<xsl:value-of select="marc:subfield[@code='f']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='g']">
			<xsl:text>&#160;;&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='g']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='n']">
			<xsl:for-each select="marc:subfield[@code='n']">
			<xsl:text>.&#160;</xsl:text>
				<xsl:if test="not(preceding-sibling::*[@code='c'])">
					<xsl:for-each select="following-sibling::*[@code='c']">
						<xsl:if test="preceding-sibling::*[@code='n']">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="preceding-sibling::*[@code='c']">
					<xsl:for-each select="preceding-sibling::*[@code='c']">
						<xsl:value-of select="."/>
						<xsl:text>&#160;:&#160;</xsl:text>
					</xsl:for-each>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:subfield[@code='d']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='d']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='p']">
			<xsl:text>&#160;(</xsl:text>
			<xsl:value-of select="marc:subfield[@code='p']"/>
			<xsl:text>).</xsl:text>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='v']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='v']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='y']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='y']"/>
		</xsl:if>	
	</xsl:element>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="marc:subfield[@code='t']"/>
		<xsl:if test="marc:subfield[@code='b']">
			<xsl:for-each select="marc:subfield[@code='b']">
				<xsl:text> [</xsl:text>
				<xsl:value-of select="."/>
				<xsl:if test="following-sibling::*[1][@code='t']">
					<xsl:text>, [</xsl:text>
					<xsl:value-of select="following-sibling::*[1]"/>
				</xsl:if>
				<xsl:text>] </xsl:text>

			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='o']">
			<xsl:for-each select="marc:subfield[@code='o']">
				<xsl:text>&#160;: </xsl:text>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='e']">
			<xsl:for-each select="marc:subfield[@code='e']">
				<xsl:if test="not(preceding-sibling::*[@code='d'])">
					<xsl:text>. - </xsl:text>
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='h']">
			<xsl:for-each select="marc:subfield[@code='h']">
				<xsl:text>. </xsl:text>
				<xsl:value-of select="."/>
				<xsl:if test="following-sibling::*[1][@code='i']">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="following-sibling::*[1]"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='i']">
			<xsl:for-each select="marc:subfield[@code='i']">
				<xsl:if test="not(preceding-sibling::*[1][@code='h'])">
					<xsl:text>. </xsl:text>
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='l']">
			<xsl:text>&#160;=&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='l']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='f']">
			<xsl:text> / </xsl:text>
			<xsl:value-of select="marc:subfield[@code='f']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='g']">
			<xsl:text>&#160;;&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='g']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='n']">
			<xsl:for-each select="marc:subfield[@code='n']">
			<xsl:text>.&#160;</xsl:text>
				<xsl:if test="not(preceding-sibling::*[@code='c'])">
					<xsl:for-each select="following-sibling::*[@code='c']">
						<xsl:if test="preceding-sibling::*[@code='n']">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="preceding-sibling::*[@code='c']">
					<xsl:for-each select="preceding-sibling::*[@code='c']">
						<xsl:value-of select="."/>
						<xsl:text>&#160;:&#160;</xsl:text>
					</xsl:for-each>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:subfield[@code='d']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='d']"/>
		</xsl:if>


		<xsl:if test="marc:subfield[@code='p']">
			<xsl:text>&#160;(</xsl:text>
			<xsl:value-of select="marc:subfield[@code='p']"/>
			<xsl:text>).</xsl:text>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='v']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='v']"/>
		</xsl:if>
		<xsl:if test="marc:subfield[@code='y']">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="marc:subfield[@code='y']"/>
		</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="subfieldSelect">
	<xsl:param name="codes"/>
	<xsl:param name="delimeter"><xsl:text></xsl:text></xsl:param>
	<xsl:param name="subdivCodes"/>
	<xsl:param name="subdivDelimiter"/>
	<xsl:param name="prefix"/>
	<xsl:param name="suffix"/>
	<xsl:variable name="str">
		<xsl:for-each select="marc:subfield">
			<xsl:if test="contains($codes, @code)">
				<xsl:if test="contains($subdivCodes, @code)">
					<xsl:value-of select="$subdivDelimiter"/>
				</xsl:if>
				<xsl:value-of select="$prefix"/><xsl:value-of select="text()"/><xsl:value-of select="$suffix"/><xsl:value-of select="$delimeter"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:value-of select="substring($str,1,string-length($str)-string-length($delimeter))"/>
</xsl:template>


<xsl:template name="buildSpaces">
	<xsl:param name="spaces"/>
	<xsl:param name="char"><xsl:text> </xsl:text></xsl:param>
	<xsl:if test="$spaces&#62;0">
		<xsl:value-of select="$char"/>
		<xsl:call-template name="buildSpaces">
			<xsl:with-param name="spaces" select="$spaces - 1"/>
			<xsl:with-param name="char" select="$char"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="chopSpecialCharacters">
	<xsl:param name="title"/>
	<xsl:variable name="ntitle" select="translate($title, '슜슛슘슈슉','')"/>
	<xsl:value-of select="$ntitle"/>
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
	<xsl:variable name="lang" select="marc:subfield[@code='7']"/>
	<xsl:if test="$lang = 'ha' or $lang = 'Hebrew' or $lang = 'fa' or $lang = 'Arabe'">
		<xsl:attribute name="class">rtl</xsl:attribute>
	</xsl:if>
</xsl:template>



<xsl:template name="tagprint">
	<xsl:param name="codes"/>
	<xsl:param name="delimeter">
		<xsl:text> </xsl:text>
	</xsl:param>
	<xsl:for-each select="marc:subfield">
		<xsl:if test="contains($codes, @code)">
			<xsl:value-of select="text()"/>
			<xsl:value-of select="$delimeter"/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template name="tagprint-link">
	<xsl:param name="codes"/>
	<xsl:param name="link-codes"/>
	<xsl:param name="link-index"/>
	<xsl:param name="delimeter">
		<xsl:text> </xsl:text>
	</xsl:param>
	<xsl:for-each select="marc:subfield">
		<xsl:if test="contains($codes, @code)">
			<xsl:choose>
				<xsl:when test="contains($link-codes, @code)">
					<a>
						<xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=<xsl:copy-of select="$link-index"/>:<xsl:copy-of select="."/></xsl:attribute>
						<xsl:copy-of select="."/>
					</a>
					<xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="text()"/>
					<xsl:value-of select="$delimeter"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:for-each>
</xsl:template>





 <xsl:template name="tag_7xx">
    <xsl:param name="tag" />
    <xsl:if test="marc:datafield[@tag=$tag]">
        <span class="value">
          <xsl:for-each select="marc:datafield[@tag=$tag]">
            <xsl:call-template name="addClassRtl" />
           <div> 
	   <a>
              <xsl:choose>
                <xsl:when test="marc:subfield[@code=9]">
                  <xsl:attribute name="href">
                    <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=an:</xsl:text>
                    <xsl:value-of select="marc:subfield[@code=9]"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="href">
                      <xsl:text>/cgi-bin/koha/catalogue/search.pl?q=au:</xsl:text>
                      <xsl:value-of select="marc:subfield[@code='a']"/>
                      <xsl:text>%20</xsl:text>
                      <xsl:value-of select="marc:subfield[@code='b']"/>
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
	      <xsl:if test="marc:subfield[@code='4']">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="marc:subfield[@code='4']"/>
              </xsl:if>
            </a>
	   </div>
          </xsl:for-each>
	 </span>
    </xsl:if>
  </xsl:template>



<xsl:template name="tag_7xxx">
	<xsl:param name="tag" />
	<xsl:if test="marc:datafield[@tag=$tag]">

		<span class="value">
			<xsl:for-each select="marc:datafield[@tag=$tag]">
				<div>
					<a>
						<xsl:choose>
							<xsl:when test="marc:subfield[@code=9]">
								<xsl:attribute name="href">
									<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=an,phr&amp;q=</xsl:text>
									<xsl:value-of select="marc:subfield[@code=9]"/>
								</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="href">
									<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=au,phr&amp;q=</xsl:text>
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
					<!-- <xsl:if test="not(position() = last())">
					<span style="padding: 3px;">
					<xsl:text>;</xsl:text>
					</span>
					</xsl:if> -->
				</div>
			</xsl:for-each>
		</span>

	</xsl:if>
</xsl:template>




<xsl:template name="tag_comma">
	<xsl:param name="tag"/>
	<xsl:param name="label"/>
	<xsl:if test="marc:datafield[@tag=$tag]">
		<span class="results_summary">
			<span class="label">
				<xsl:value-of select="$label"/>: </span>
				<xsl:for-each select="marc:datafield[@tag=$tag]">
					<xsl:call-template name="addClassRtl"/>
					<xsl:for-each select="marc:subfield">
						<xsl:if test="position()&#62;1">
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

</xsl:stylesheet>
