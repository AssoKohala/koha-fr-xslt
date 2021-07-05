<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet version="1.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:items="http://www.koha-community.org/items" xmlns:intralinks="http://www.koha.org/intralinks" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="marc items">

	<xsl:import href="UNIMARCslimUtils.xsl"/>
	<xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
	<xsl:key name="intralinks" match="intralinks:intralinks" use="intralinks:ppn"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="marc:record">
		<xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='OPACDisplay856uAsImage']"/>
		<xsl:variable name="leader" select="marc:leader"/>
		<xsl:variable name="leader6" select="substring($leader,7,1)"/>
		<xsl:variable name="leader7" select="substring($leader,8,1)"/>
		<xsl:variable name="biblionumber" select="marc:controlfield[@tag=001]"/>
		<xsl:variable name="ppn" select="marc:controlfield[@tag=009]"/>
		<xsl:variable name="isSerial" select="marc:datafield[@tag=099]/marc:subfield[@code='s']"/>
		<xsl:variable name="editorinfos" select="marc:datafield[@tag=306]/marc:subfield[@code='a']"/>
		<xsl:variable name="TMDBid" select="marc:datafield[@tag=19]/marc:subfield[@code='a']"/>
		<xsl:variable name="liens856">
			<xsl:for-each select="marc:datafield[@tag=856]">
				<xsl:value-of select="marc:subfield[@code='u']"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="visibleopac">
			<xsl:for-each select="marc:datafield[@tag=099]">
				<xsl:value-of select="marc:subfield[@code='d']"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="typdoc" select="marc:datafield[@tag=099]/marc:subfield[@code='t']"/>

		<abbr class="unapi-id" title="koha:biblionumber:{marc:controlfield[@tag=001]}">
			<!-- unAPI -->
		</abbr>





<!--  TITRE #200 -->
<xsl:if test="marc:datafield[@tag=200]">
	<xsl:for-each select="marc:datafield[@tag=200]">
		<h1 class="title">
			<xsl:call-template name="addClassRtl" />
			<xsl:for-each select="marc:subfield">
				<xsl:choose>
					<xsl:when test="@code='6'">
					</xsl:when>
					<xsl:when test="@code='7'">
							<xsl:text>(</xsl:text>
							<xsl:value-of select="."/>
							<xsl:text>)&#160;</xsl:text>
					</xsl:when>
					<xsl:when test="@code='a'">
						<xsl:if test="preceding-sibling::marc:subfield[@code='a']">
							<xsl:text> ; </xsl:text>
						</xsl:if>
						<xsl:variable name="title" select="."/>
						<xsl:variable name="ntitle"
							select="translate($title, '&#x0088;&#x0089;&#x0098;&#x009C;','')"/>
							<xsl:value-of select="$ntitle" />
						</xsl:when>
						<xsl:when test="@code='b'">
							<xsl:text> [</xsl:text>
							<xsl:value-of select="."/>
							<xsl:text>]</xsl:text>
						</xsl:when>
						<xsl:when test="@code='d'">
							<xsl:text> </xsl:text>
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
				<xsl:if test="($typdoc='Livre' or $typdoc='Revue') and $TMDBid">
						<xsl:element name="span">
						<xsl:attribute name="class">kbid hide</xsl:attribute>
						<xsl:value-of select="$TMDBid"/>
					</xsl:element>
				</xsl:if>
			</h1>
		</xsl:for-each>
	</xsl:if>




	<br />

<!--  End TITRE #200 -->

<!--  NOTICE DÉTAILLÉE -->
<table class="citation" summary="Bibliographic Details" border="0" cellpadding="2" cellspacing="0">
	<tbody>


			<tr valign="top">
				<th>SUDOC : </th><td class='sudoc'>
				<xsl:attribute name="style">font-weight:bold;color:#0055BB;</xsl:attribute>
			<xsl:choose>
				<xsl:when test="marc:controlfield[@tag=009]">
					<a>
					<xsl:attribute name="href">http://www.sudoc.fr/<xsl:value-of select="marc:controlfield[@tag=009]"/></xsl:attribute>
					<xsl:attribute name="title">Voir la notice sur le sudoc</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
                     <xsl:attribute name="id">ppn</xsl:attribute>
                     <xsl:value-of select="marc:controlfield[@tag=009]"/>
				   </a>
				</xsl:when>
				<xsl:otherwise><span class='nosudoc'><xsl:attribute name="style">font-weight:bold;color:#DD0000;</xsl:attribute>Notice non sudoc</span> </xsl:otherwise>
			</xsl:choose>

		</td></tr>

	<xsl:if test="marc:controlfield[@tag=001]">
		<tr valign="top">
			<th>Biblionumber (ID Koha) : </th><td>
			<span id='biblionumber'><xsl:value-of select="marc:controlfield[@tag=001]"/></span> <a>
			<xsl:attribute name="href">http://catalogue.bu.univ-rennes2.fr/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:controlfield[@tag=001]"/>
			</xsl:attribute>
			<xsl:attribute name="title">Voir la notice sur l'opac</xsl:attribute>

			<xsl:attribute name="target">_blank</xsl:attribute>
			<xsl:text> (OPAC)</xsl:text>
		</a>
	</td></tr>

	<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='d']!=''">
		<tr>
			<th>Visible OPAC :</th>
			<td>

				<xsl:if test="contains($visibleopac,'Affiché')">
					<xsl:attribute name="style">font-weight:bold;color:#0C9618;</xsl:attribute>
					<span id="visibleOpac"><xsl:value-of select="marc:datafield[@tag=099]/marc:subfield[@code='d']/text()" /></span>
				</xsl:if>
				<xsl:if test="contains($visibleopac,'caché')">
					<xsl:attribute name="style">font-weight:bold;color:#DD0000;</xsl:attribute>
					<span id="hiddenOpac"><xsl:value-of select="marc:datafield[@tag=099]/marc:subfield[@code='d']/text()" /></span>

				</xsl:if>
			</td>
		</tr>
	</xsl:if>
</xsl:if>

<xsl:if test="$typdoc='Thèse'">
	<xsl:if test="marc:datafield[@tag=029]/marc:subfield[@code='b']!=''">
		<tr>
			<th>NNT</th>
			<td>
			<a>
			<xsl:attribute name="class">NNT</xsl:attribute>
			<xsl:attribute name="title">Voir la notice sur theses.fr</xsl:attribute>
			<xsl:attribute name="href">http://www.theses.fr/<xsl:value-of select="marc:datafield[@tag=029]/marc:subfield[@code='b']/text()"/>
			</xsl:attribute>
			<xsl:attribute name="target">_blank</xsl:attribute>

				<xsl:value-of select="marc:datafield[@tag=029]/marc:subfield[@code='b']/text()" />
			</a>
			</td>
		</tr>
	</xsl:if>
</xsl:if>

<!-- 7XX RESPONSABILITÉ INTELLECTUELLE -->
<xsl:if test="marc:datafield[@tag=700 or @tag=710 or @tag=720 or @tag=701 or @tag=711 or @tag=721 or @tag=702 or @tag=712 or @tag=722 or @tag=716]">
	<tr valign="top">
		<th>Auteur<xsl:if test="count(marc:datafield[starts-with(@tag,'700')])&#62;1 or count(marc:datafield[starts-with(@tag,'710')])&#62;1 or count(marc:datafield[starts-with(@tag,'720')])&#62;1 or count(marc:datafield[starts-with(@tag,'701')])&#62;1 or count(marc:datafield[starts-with(@tag,'711')])&#62;1 or count(marc:datafield[starts-with(@tag,'721')])&#62;1 or count(marc:datafield[starts-with(@tag,'702')])&#62;1 or count(marc:datafield[starts-with(@tag,'712')])&#62;1 or count(marc:datafield[starts-with(@tag,'722')])&#62;1 or count(marc:datafield[starts-with(@tag,'716')])&#62;1" >s</xsl:if> : </th>
		<td>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">700</xsl:with-param>
				<xsl:with-param name="label">Auteur<xsl:if test="count(marc:datafield[starts-with(@tag,'700')])&#62;1">s</xsl:if></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">710</xsl:with-param>
				<xsl:with-param name="label">Collectivité<xsl:if test="count(marc:datafield[starts-with(@tag,'710')])&#62;1">s</xsl:if> principale<xsl:if test="count(marc:datafield[starts-with(@tag,'710')])&#62;1">s</xsl:if></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">720</xsl:with-param>
				<xsl:with-param name="label">Auteur principal</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">701</xsl:with-param>
				<xsl:with-param name="label">Co-auteur<xsl:if test="count(marc:datafield[starts-with(@tag,'701')])&#62;1">s</xsl:if></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">711</xsl:with-param>
				<xsl:with-param name="label">Collectivité co-auteur<xsl:if test="count(marc:datafield[starts-with(@tag,'711')])&#62;1">s</xsl:if> - collectivité</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">721</xsl:with-param>
				<xsl:with-param name="label">Co-auteur</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">702</xsl:with-param>
				<xsl:with-param name="label">Auteur<xsl:if test="count(marc:datafield[starts-with(@tag,'702')])&#62;1">s</xsl:if> secondaire<xsl:if test="count(marc:datafield[starts-with(@tag,'702')])&#62;1">s</xsl:if></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">712</xsl:with-param>
				<xsl:with-param name="label">Collectivité secondaire</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">722</xsl:with-param>
				<xsl:with-param name="label">Auteur secondaire</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="tag_7xx">
				<xsl:with-param name="tag">716</xsl:with-param>
				<xsl:with-param name="label">Marque déposée</xsl:with-param>
			</xsl:call-template>
		</td>
	</tr>
</xsl:if>

<!-- 210/214 ÉDITEUR -->
<xsl:call-template name="tag_210_214"/>
<!-- 205 ÉDITION -->
<xsl:call-template name="tag_205_details"/>
<!-- 410 COLLECTION -->
<xsl:call-template name="tag_410"/>
<!-- 215 DESCRIPTION -->
<xsl:call-template name="tag_215"/>
<!-- 215 LANGUE -->
<xsl:call-template name="tag_101"/>
<!-- LIEU DE PUBLICATION -->
<xsl:call-template name="tag_102"/>

<!-- PERIODICITÉ -->
<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">326</xsl:with-param>
	<xsl:with-param name="label">Périodicité</xsl:with-param>
</xsl:call-template>

<!-- GÉO -->
<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">206</xsl:with-param>
	<xsl:with-param name="label">Informations géographiques</xsl:with-param>
</xsl:call-template>

<!-- MUSIQUE -->
<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">208</xsl:with-param>
	<xsl:with-param name="label">Musique imprimée</xsl:with-param>
</xsl:call-template>



<!-- <xsl:if test="marc:datafield[@tag=859]">
<tr valign="top">
<th>Accès&#160;: </th><td>
<xsl:if test="$typdoc='Revue'">
<div id="subjectline" class="results_summary">
<span class="button button-online">En ligne</span>
<xsl:for-each select="marc:datafield[@tag=859]">
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
<xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">Consulter en ligne</xsl:when>
</xsl:choose>
</a>
<xsl:choose>
<xsl:when test="position()=last()"/>
<xsl:otherwise> | </xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</div>
</xsl:if>
</td></tr>
</xsl:if>-->

<xsl:if test="marc:datafield[@tag=856]">
	<tr valign="top">
		<th>Accès&#160;: </th><td>
			<xsl:if test="marc:datafield[@tag=856]">
	<xsl:if test="not(contains($liens856,'electre.com'))">
		<xsl:if test="$typdoc!='Revue'">
			<xsl:for-each select="marc:datafield[@tag=856]">
				<xsl:choose>
					<xsl:when test="marc:subfield[@code='5']">
						<div class="items online">
							<a>
								<xsl:attribute name="class">btn btn-mini</xsl:attribute>
								<xsl:attribute name="href">
								<xsl:choose>
										<xsl:when test="contains($liens856,'theses.scdbases.uhb.fr:8000')">
											<xsl:variable name="lienlocal" select="marc:subfield[@code='u']" />
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$lienlocal"/>
													<xsl:with-param name="replace" select="'theses.scdbases.uhb.fr:8000'"/>
													<xsl:with-param name="by" select="'www.bu.univ-rennes2.fr/system/files/theses'"/>
												</xsl:call-template>
										</xsl:when>
										<xsl:when test="contains($liens856,'scd-fonds.uhb.fr')">
											<xsl:variable name="lienlocal" select="marc:subfield[@code='u']" />
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$lienlocal"/>
													<xsl:with-param name="replace" select="'scd-fonds.uhb.fr'"/>
													<xsl:with-param name="by" select="'www.bu.univ-rennes2.fr/sites/default/files/theses'"/>
												</xsl:call-template>
										</xsl:when>
										<xsl:when test="not(contains($liens856,'theses.scdbases.uhb.fr:8000'))">
											<xsl:variable name="lien" select="marc:subfield[@code='u']" />
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$lien"/>
												<xsl:with-param name="replace" select="'scdbases.uhb.fr'"/>
												<xsl:with-param name="by" select="'distant.bu.univ-rennes2.fr'"/>
												</xsl:call-template>
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="marc:subfield[@code='u']"/>
									</xsl:otherwise>
								</xsl:choose>

								</xsl:attribute>
								<xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='z']">
										<xsl:attribute name="title">
											<xsl:value-of select="marc:subfield[@code='z']"/>
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise><xsl:attribute name="title"><xsl:text>consulter en ligne</xsl:text></xsl:attribute></xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="marc:subfield[@code='z']">

										<xsl:choose>
											<xsl:when test="contains($liens856,'scdbases')">
												<xsl:text>En ligne après authentification</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="marc:subfield[@code='z']"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
								</xsl:choose>
							</a>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not(contains($liens856,'scdbases'))">
<!-- 							<xsl:if test="preceding-sibling::marc:datafield[@tag=856][1]/marc:subfield[@code='u'] != marc:subfield[@code='u']"> -->

								<div class="items online">
									<a>
										<xsl:attribute name="class">btn btn-mini</xsl:attribute>

										<xsl:attribute name="href">
											<xsl:value-of select="marc:subfield[@code='u']"/>
										</xsl:attribute>
										<xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='z']">
												<xsl:attribute name="title">
													<xsl:value-of select="marc:subfield[@code='z']"/>
												</xsl:attribute>
											</xsl:when>
											<xsl:otherwise><xsl:attribute name="title"><xsl:text>consulter en ligne</xsl:text></xsl:attribute></xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="marc:subfield[@code='z']">
												<xsl:value-of select="marc:subfield[@code='z']"/>
											</xsl:when>
											<xsl:otherwise>Consulter en ligne</xsl:otherwise>
										</xsl:choose>
									</a>
								</div>
<!-- 							</xsl:if>  -->
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
	</xsl:if>
</xsl:if>	</td></tr>
</xsl:if>

<!-- 5XX BLOC DES TITRES ASSOCIÉS -->

<xsl:if test="marc:datafield[contains('500,503,530,531,532',@tag)]">

	<tr valign="top">
		<th>Variantes du titre&#160;: </th><td>



		<xsl:if test="marc:datafield[@tag=500]">
			<xsl:for-each select="marc:datafield[@tag=500]">
				<div id="subjectline">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">abhiklmnqrsuw</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:datafield[@tag=503]">
			<xsl:for-each select="marc:datafield[@tag=503]">
				<div id="subjectline">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">abdefhijklmn</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:datafield[@tag=530]">
			<xsl:for-each select="marc:datafield[@tag=530]">
				<div id="subjectline">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">abj</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:datafield[@tag=531]">
			<xsl:for-each select="marc:datafield[@tag=531]">
				<div id="subjectline">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">ab</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="marc:datafield[@tag=532]">
			<xsl:for-each select="marc:datafield[@tag=532]">
				<div id="subjectline">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">a</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</xsl:if>
	</td></tr>
</xsl:if>

<xsl:if test="marc:datafield[contains('510,512,513,514,515,516,517,518,520,540,541,545',@tag)]">

	<tr valign="top">
		<th>Autres titres&#160;: </th><td>


		<xsl:for-each select="marc:datafield[@tag=510]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=512]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>


		<xsl:for-each select="marc:datafield[@tag=513]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=514]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>


		<xsl:for-each select="marc:datafield[@tag=515]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=516]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=517]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=518]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=520]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=540]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>


		<xsl:for-each select="marc:datafield[@tag=541]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>

		<xsl:for-each select="marc:datafield[@tag=545]">
			<div id="subjectline">
				<xsl:call-template name="tagprint-link">
					<xsl:with-param name="codes">aehijn</xsl:with-param>
					<xsl:with-param name="link-codes">a</xsl:with-param>
					<xsl:with-param name="link-index">ti</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:for-each>


	</td></tr>
</xsl:if>





<!-- 3XX NOTES -->
<xsl:if test="marc:datafield[contains('330,300,301,302,303,304,305,306,307, 308,310,311,312,313,314,315,316,317,321,322,323,324,325,327,332,333,334,336,337,345',@tag)]">
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">300</xsl:with-param>
		<xsl:with-param name="label">Note générale</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">301</xsl:with-param>
		<xsl:with-param name="label">Note sur les numéros d'identification</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">302</xsl:with-param>
		<xsl:with-param name="label">Note </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">303</xsl:with-param>
		<xsl:with-param name="label">Note sur la description bibliographique</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">304</xsl:with-param>
		<xsl:with-param name="label">Note sur le titre et l'auteur</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">305</xsl:with-param>
		<xsl:with-param name="label">Note sur l'édition</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">306</xsl:with-param>
		<xsl:with-param name="label">Note sur l'éditeur</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">307</xsl:with-param>
		<xsl:with-param name="label">Note sur la collation</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">308</xsl:with-param>
		<xsl:with-param name="label">Note sur la collection</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">310</xsl:with-param>
		<xsl:with-param name="label">Disponibilité</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">311</xsl:with-param>
		<xsl:with-param name="label">Note sur les zones de liens</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">312</xsl:with-param>
		<xsl:with-param name="label">Note sur les titres associés</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">313</xsl:with-param>
		<xsl:with-param name="label">Note sur les vedettes matières</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">314</xsl:with-param>
		<xsl:with-param name="label">Note sur la responsabilité intellectuelle</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">315</xsl:with-param>
		<xsl:with-param name="label">Note</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">316</xsl:with-param>
		<xsl:with-param name="label">Note sur l'exemplaire</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">317</xsl:with-param>
		<xsl:with-param name="label">Note sur la provenance</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">321</xsl:with-param>
		<xsl:with-param name="label">Note sur les index, extraits et citations publiés séparément</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">322</xsl:with-param>
		<xsl:with-param name="label">Note sur le générique</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">323</xsl:with-param>
		<xsl:with-param name="label">Note sur les interprètes</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">324</xsl:with-param>
		<xsl:with-param name="label">Note sur le document original</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">325</xsl:with-param>
		<xsl:with-param name="label">Note sur la reproduction</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">327</xsl:with-param>
		<xsl:with-param name="label">Note de contenu</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">332</xsl:with-param>
		<xsl:with-param name="label">Titre choisi pour le document</xsl:with-param>
	</xsl:call-template>
	<!--<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">333</xsl:with-param>
	<xsl:with-param name="label">Note sur le public destinataire</xsl:with-param>
	</xsl:call-template>-->
	<xsl:if test="marc:datafield[@tag=334]">
		<tr valign="top">
			<th>Récompenses&#160;: </th><td>
			<xsl:for-each select="marc:datafield[@tag=334]">
				<div id="subjectline" class="results_summary">
					<xsl:call-template name="tagprint">
						<xsl:with-param name="codes">abcd</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:for-each>
		</td></tr>
	</xsl:if>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">336</xsl:with-param>
		<xsl:with-param name="label">Note sur le type de ressource électronique</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="tag_3xx">
		<xsl:with-param name="tag">337</xsl:with-param>
		<xsl:with-param name="label">Configuration requise</xsl:with-param>
	</xsl:call-template>
	<!--<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">345</xsl:with-param>
	<xsl:with-param name="label">Renseignements sur l'acquisition</xsl:with-param>
	</xsl:call-template>-->
</xsl:if>

<!-- 328 NOTE DE THESE -->
<xsl:call-template name="tag_328"/>
<!-- 4XX -->
<xsl:call-template name="tag_4xx" />




<!-- BIBLIOGRAPHIE -->
<xsl:call-template name="tag_3xx">
	<xsl:with-param name="tag">320</xsl:with-param>
	<xsl:with-param name="label">Bibliographie</xsl:with-param>
</xsl:call-template>
<!-- ISBN -->
<xsl:call-template name="tag_010">
	<xsl:with-param name="tag">010</xsl:with-param>
	<xsl:with-param name="label">ISBN</xsl:with-param>
</xsl:call-template>
<!-- ISSN -->
<xsl:call-template name="tag_011">
	<xsl:with-param name="tag">011</xsl:with-param>
	<xsl:with-param name="label">ISSN</xsl:with-param>
</xsl:call-template>
<!-- EAN -->
<xsl:call-template name="tag_010">
	<xsl:with-param name="tag">073</xsl:with-param>
	<xsl:with-param name="label">EAN</xsl:with-param>
</xsl:call-template>
<!-- ISNM -->
<xsl:call-template name="tag_01x">
	<xsl:with-param name="tag">013</xsl:with-param>
	<xsl:with-param name="label">ISMN</xsl:with-param>
</xsl:call-template>
<!-- EMPREINTE -->
<xsl:call-template name="tag_01x">
	<xsl:with-param name="tag">012</xsl:with-param>
	<xsl:with-param name="label">Empreinte</xsl:with-param>
</xsl:call-template>
<!-- AERES -->
<xsl:if test="marc:datafield[@tag=619]/marc:subfield[@code='b']">
	<tr valign="top">
		<th>Classement AERES&#160;: </th><td>
		<xsl:value-of select="marc:datafield[@tag=619]/marc:subfield[@code='b']"/>
	</td></tr>
</xsl:if>



<!-- 6XX SUJETS
<xsl:call-template name="tag_6XX"/>  -->
<xsl:call-template name="tag_subjects"/>
<xsl:call-template name="tag_genre"/>


<!-- Icones Type de doc -->
<tr valign="top">
	<th>Type : </th><td>
	 <xsl:element name="div">
    	<xsl:attribute name="id">typdoc</xsl:attribute>
		<xsl:if test="contains($isSerial,'Est un périodique') or $typdoc='Revue'">
			<xsl:attribute name="class">isSerial</xsl:attribute>
        </xsl:if>
		<xsl:choose>
			<xsl:when test="$typdoc !=''">
				 <strong><xsl:value-of select="$typdoc"/></strong>
			</xsl:when>
			<xsl:otherwise>
				<img src="/opac-tmpl/rennes2/css/img/icons/rennes2/page_white.png" alt="Document" title="Document"/>Pas de type de document
			</xsl:otherwise>
		</xsl:choose>
	 </xsl:element>
</td></tr>
<!-- End Icones Type de doc -->


<!-- 099$a -->
	<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='a']!=''">
		<tr>
			<th>Source</th>
			<td>
				<span id="atoz"><xsl:value-of select="marc:datafield[@tag=099]/marc:subfield[@code='a']/text()" /></span>
			</td>
		</tr>
	</xsl:if>




<!-- 330/339 Résumé -->
<xsl:if test="marc:datafield[@tag=330]">
	<tr valign="top">
		<th>Résumé</th><td>
		<xsl:for-each select="marc:datafield[@tag=330]">

			<p><xsl:value-of select="marc:subfield[@code='a']"/></p>
			<xsl:if test="position()!=last()">
				<hr></hr>
			</xsl:if>
		</xsl:for-each>
	</td></tr>
</xsl:if>


<xsl:if test="marc:datafield[@tag=339]">
	<tr valign="top">
		<th>Résumé</th><td>
		<xsl:for-each select="marc:datafield[@tag=339]">

			<p><xsl:value-of select="marc:subfield[@code='a']"/></p>
			<xsl:if test="position()!=last()">
				<hr></hr>
			</xsl:if>
		</xsl:for-each>
	</td></tr>
</xsl:if>


<!-- 359 TdM -->
<xsl:if test="marc:datafield[@tag=359]">
	<tr valign="top">
		<th>Table des Matières</th><td>
		<ul>
			<xsl:variable name="souschamps"><xsl:text>bcdefghi</xsl:text></xsl:variable>
			<xsl:for-each select="marc:datafield[@tag=359]">
				<xsl:for-each select="marc:subfield">
					<xsl:if test="contains($souschamps, @souschamp)">
						<li><xsl:value-of select="text()"/></li>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
		</ul>
	</td></tr>
</xsl:if>


</tbody></table>



<br />

<!-- 930e FONDS SPÉ  -->

	<xsl:if test="marc:datafield[@tag=930]/marc:subfield[@code='e']!=''">
	<xsl:if test="marc:datafield[@tag=915]">
			<xsl:for-each select="marc:datafield[@tag=915]">
						<xsl:variable name="RCR" select="marc:subfield[@code='5']" />
							<xsl:variable name="idExempl">
								<xsl:call-template name="RCR">
									<xsl:with-param name="code" select="substring-after($RCR, ':')"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="codebarre" select="marc:subfield[@code='b']" />
						<xsl:if test="$idExempl!=''">
								<xsl:for-each select="//marc:datafield[@tag=930][marc:subfield[@code='5']=$RCR]">

								<xsl:if test="marc:subfield[@code='e']!=''">
									<div>
										<xsl:attribute name="id"><xsl:value-of  select="$codebarre"/></xsl:attribute>
										<xsl:attribute name="class">fondsspe</xsl:attribute>
											<xsl:value-of select="marc:subfield[@code='e']"/>
											<!--
<xsl:element name="a">
												<xsl:attribute name="href">
													<xsl:text>/cgi-bin/koha/catalogue/search.pl?idx=nt&amp;q=</xsl:text>
													<xsl:value-of select="marc:subfield[@code='e']"/>
												</xsl:attribute>
												<xsl:attribute name="rel">nofollow</xsl:attribute>
												<xsl:attribute name="title">
													<xsl:text>Recherche sur  "</xsl:text>
													<xsl:value-of select="marc:subfield[@code='e']"/>
													<xsl:text>"</xsl:text>
												</xsl:attribute>
												<xsl:value-of select="marc:subfield[@code='e']"/>
											</xsl:element>
-->
									</div>
								</xsl:if>
								</xsl:for-each>
						</xsl:if>
				</xsl:for-each>
		</xsl:if>
	</xsl:if>





<!-- 955, 956, 957 ÉTATS DE COLLECTION -->
<xsl:if test="contains($isSerial,'Est un périodique') or $typdoc='Revue'">
		<xsl:if test="marc:datafield[@tag=930]">
		<div id="etatCollection">
			<table class="holdingst">
				<thead>
					<tr>
						<th id="item_location"  class="header headerSortDown">Localisation	</th>
						<th id="item_fonds"  class="header">Fonds</th>
						<th id="item_numdisp"  class="header">Numéros disponibles</th>
						<th id="item_lacunes990"  class="header">Lacunes exhaustives</th>
						<th id="item_lacunes959"  class="header">Lacunes exhaustives</th>
						<th id="item_callno"  class="header">Cote</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="marc:datafield[@tag=930]">
						<xsl:variable name="RCR" select="marc:subfield[@code='5']" />
						<xsl:variable name="RCRlib">
							<xsl:call-template name="RCR">
								<xsl:with-param name="code" select="substring-before($RCR, ':')"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:if test="$RCRlib!=''">
							<tr>
								<td class="location">
									<span class="branch-info-tooltip-trigger"> <xsl:value-of select="$RCRlib"/> </span>
									<xsl:if test="marc:subfield[@code='c']">
										<xsl:text> - </xsl:text>
										<span class="shelvingloc"><xsl:value-of select="marc:subfield[@code='c']"/></span>
									</xsl:if>
								</td>
								<td class="fonds">
									<xsl:if test="marc:subfield[@code='c']">
										<xsl:value-of select="marc:subfield[@code='e']"/>
									</xsl:if>
								</td>
								<td class="numdisp">
									<xsl:for-each select="//marc:datafield[@tag=955][marc:subfield[@code='5']=$RCR]">
										<xsl:value-of select="marc:subfield[@code='r']" />
									</xsl:for-each>
                                    <xsl:for-each select="//marc:datafield[@tag=956][marc:subfield[@code='5']=$RCR][marc:subfield[@code='r']]">
                                        <div><strong>Suppléments, hors-séries :</strong><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='r']" /></div>
                                    </xsl:for-each>
                                    <xsl:for-each select="//marc:datafield[@tag=957][marc:subfield[@code='5']=$RCR][marc:subfield[@code='r']]">
                                        <div><strong>Tables, indexes : </strong><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='r']" /></div>
                                    </xsl:for-each>
								</td>
								<td class="lacunes990">
									<xsl:for-each select="//marc:datafield[@tag=990][marc:subfield[@code='5']=$RCR]">
										<xsl:value-of select="marc:subfield[@code='a']" />
									</xsl:for-each>
								</td>
								<td class="lacunes959">
									<xsl:for-each select="//marc:datafield[@tag=959][marc:subfield[@code='5']=$RCR][marc:subfield[@code='r']]">
										<xsl:value-of select="marc:subfield[@code='r']"  />
									</xsl:for-each>
								</td>
								<xsl:if test="marc:subfield[@code='a']">
									<td class="callno">
										<div>
											<xsl:attribute name="id"><xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
											<xsl:attribute name="class">callnumber</xsl:attribute>
											<xsl:value-of select="marc:subfield[@code='a']"/>
										</div>

									</td>
								</xsl:if>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</tbody>
			</table>
		  </div>
		</xsl:if>
		<!-- <xsl:if test="marc:datafield[@tag=930]/marc:subfield[@code='a']">
		<div class="etat2coll">
		<h2 class="ntitle">Localiser la revue&#160;: </h2>
		<xsl:for-each select="marc:datafield[@tag=930]">
		<xsl:if test="marc:subfield[@code='a']">
		<div id="subjectline">
		<span class="label">
		<xsl:call-template name="RCR">
		<xsl:with-param name="code" select="substring-before(marc:subfield[@code='5'], ':')"/>
		</xsl:call-template>
		</span>
		<xsl:if test="marc:subfield[@code='a']">
		<xsl:text>:&#160;</xsl:text>
		<span class="cote"><xsl:text>cote&#160;</xsl:text>
		<xsl:value-of select="marc:subfield[@code='a']"/></span>
		</xsl:if>
		</div>
		</xsl:if>
		</xsl:for-each>
		</div>
		</xsl:if>
		<xsl:if test="marc:datafield[@tag=955]/marc:subfield[@code='r']">
		<div class="etat2coll">
		<h2 class="ntitle">Numéros disponibles&#160;: </h2>
		<xsl:for-each select="marc:datafield[@tag=955]">
		<xsl:if test="marc:subfield[@code='r']">
		<div id="subjectline">
		<span class="label">
		<xsl:call-template name="RCR">
		<xsl:with-param name="code" select="substring-before(marc:subfield[@code='5'], ':')"/>
		</xsl:call-template>
		</span>
		<xsl:if test="marc:subfield[@code='r']">
		<xsl:text>: </xsl:text>
		<xsl:value-of select="marc:subfield[@code='r']"/>
		</xsl:if>
		</div>
		</xsl:if>
		</xsl:for-each>
		</div>
		</xsl:if> -->


</xsl:if>


<xsl:if test="marc:controlfield[@tag=009]">
	<div class="PPN" style="display:none">
		<xsl:value-of select="$ppn"/>
	</div>
</xsl:if>



<!-- 100
<xsl:if test="marc:datafield[@tag=100]">
<div id="toc">
<xsl:for-each select="marc:datafield[@tag=100]">
<xsl:call-template name="subfieldSelect">
<xsl:with-param name="codes">a</xsl:with-param>
</xsl:call-template>
</xsl:for-each>
</div>
</xsl:if> -->



<!--<xsl:if test="count(key('intralinks', marc:datafield[@tag=456]/marc:subfield[@code='0']))&#62;0 or count(key('intralinks', marc:datafield[@tag=452]/marc:subfield[@code='0']))&#62;0 ">
<br/>
<span class="results_summary">
<xsl:text>          Vous pouvez consulter ce document en </xsl:text>
<a style="font-size:110%">
<xsl:choose>
<xsl:when test="marc:datafield[@tag=456]">
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="marc:datafield[@tag=456]/marc:subfield[@code='0']"/>
</xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="href">
/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="marc:datafield[@tag=452]/marc:subfield[@code='0']"/>
</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
<span style="color:green">version numérique</span>
</a>
</span>
</xsl:if>-->

<!--<xsl:if test="marc:controlfield[@tag=009]">
<span class="results_summary"><br/>
<xsl:if test="$leader6!='l'">
<xsl:text>      =&#62; Ce document est également disponible dans </xsl:text>
<a><xsl:attribute name="href">http://www.sudoc.abes.fr/DB=2.1/SET=252/TTL=2/CMD?PRS=HOL/SHW?FRST=1&amp;ACT=SRCHA&amp;IKT=1016&amp;SRT=RLV&amp;TRM=ppn+<xsl:value-of select="marc:controlfield[@tag=009]"/></xsl:attribute>d'autres bibliothèques françaises
</a>
</xsl:if>
</span>
</xsl:if>-->


<!-- 780 -->
<xsl:if test="marc:datafield[@tag=780]">
	<xsl:for-each select="marc:datafield[@tag=780]">
		<span class="results_summary">
			<span class="label">
				<xsl:choose>
					<xsl:when test="@ind2=0">
						Suite de&#160;:</xsl:when>
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
					<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f780, '()', '')"/></xsl:attribute>
					<xsl:value-of select="translate($f780, '()', '')"/>
				</a>
			</span>
			<xsl:choose>
				<xsl:when test="@ind1=0">
					<span class="results_summary">
						<xsl:value-of select="marc:subfield[@code='n']"/>
					</span>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:if>
	<!-- 785 -->
	<xsl:if test="marc:datafield[@tag=785]">
		<xsl:for-each select="marc:datafield[@tag=785]">
			<span class="results_summary">
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
					<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f785, '()', '')"/></xsl:attribute>
					<xsl:value-of select="translate($f785, '()', '')"/>
				</a>
			</span>
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
