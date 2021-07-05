<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="marc items str">

  <xsl:import href="UNIMARC_Results_utils_brise_es_koha.xsl"/>
  <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>

  <xsl:key name="item-by-status" match="items:item" use="items:status"/>
  <xsl:key name="item-by-status-and-branch-home" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>
  <xsl:key name="item-by-status-and-branch-holding" match="items:item" use="concat(items:status, ' ', items:holdingbranch)"/>
  <xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>
  <xsl:key name="item-by-status-branch-callnumber" match="items:item" use="concat(items:status, ' ', items:homebranch, ' ', items:location, ' ',items:itemcallnumber)"/>

  <xsl:template match="marc:record">
    <xsl:variable name="leader" select="marc:leader"/>
    <xsl:variable name="leader6" select="substring($leader,7,1)"/>
    <xsl:variable name="leader7" select="substring($leader,8,1)"/>
    <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='a']"/>
    <xsl:variable name="isbn" select="marc:datafield[@tag=010]/marc:subfield[@code='a']"/>
    <xsl:variable name="urlCBLcover" select="marc:datafield[@tag=976]/marc:subfield[@code='u']"/>
    <xsl:variable name="OPACResultsLibrary" select="marc:sysprefs/marc:syspref[@name='OPACResultsLibrary']"/>
    <xsl:variable name="BiblioDefaultView" select="marc:sysprefs/marc:syspref[@name='BiblioDefaultView']"/>
    <xsl:variable name="hidelostitems" select="marc:sysprefs/marc:syspref[@name='hidelostitems']"/>
    <xsl:variable name="singleBranchMode" select="marc:sysprefs/marc:syspref[@name='singleBranchMode']"/>
    <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>

   <span><xsl:attribute name="id"><xsl:value-of select="$isbn"/></xsl:attribute><xsl:attribute name="urlcblcover"><xsl:value-of select="$urlCBLcover"/></xsl:attribute><xsl:attribute name="class">isbn</xsl:attribute></span>
    <xsl:if test="marc:datafield[@tag=200]">
      <xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
        <span class="results_icon">
          <xsl:choose>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Livre imprimé'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/book_b.gif" alt="book" title="book"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Livre numérique'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/binary_b.gif" alt="electronic ressource" title="electronic ressource"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Revue imprimée'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/periodical_b.gif" alt="periodical" title="periodical"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Thèse, mémoire, rapport'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/thesis_b.gif" alt="thesis, report" title="thesis, report"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Carte'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/map_b.gif" alt="map" title="map"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Partition'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/score_b.gif" alt="score" title="score"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Article'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/article_b.gif" alt="article" title="article"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Images, son, multisupport'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/sound_b.gif" alt="Images, son, multisupport" title="Images, son, multisupport"/>&#xA0;
            </xsl:when>
            <xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Support informatique'">
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/binary_b.gif" alt="electronic ressource" title="electronic ressource"/>&#xA0;
            </xsl:when>
            <xsl:otherwise>
              <img src="/opac-tmpl/bootstrap/itemtypeimg/sudoc/unknown_b.gif" alt="other" title="other"/>&#xA0;
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </xsl:if>

      <span class="results_titre">
        <xsl:for-each select="marc:datafield[@tag=200]">
          <xsl:for-each select="marc:subfield">
            <xsl:choose>
              <xsl:when test="@code='a'">
                <xsl:if test="preceding-sibling::marc:subfield[@code='a']">
                  <xsl:text> ; </xsl:text>
                </xsl:if>
                <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
                  <xsl:variable name="title" select="."/>
                  <xsl:variable name="ntitle" select="translate($title, '&#x0098;&#x009C;&#xC29C;&#xC29B;&#xC298;&#xC288;&#xC289;','')"/>
                  <xsl:value-of select="$ntitle" />
                </a>
                <xsl:if test="following-sibling::*[1][@code='a']">
                  <xsl:text> ; </xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:when test="@code='c'">
                <xsl:text> ; </xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
              </xsl:when>
              <xsl:when test="@code='d'">
                <xsl:text> = </xsl:text>
                <xsl:value-of select="."/>
              </xsl:when>
              <xsl:when test="@code='h'">
                <xsl:choose>
                  <xsl:when test="(preceding-sibling::*[1][@code='f'] or preceding-sibling::*[1][@code='g'])">
                    <xsl:text disable-output-escaping="yes">. &lt;b&gt;</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text disable-output-escaping="yes">,  &lt;b&gt;</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="@code='i'">
                <xsl:choose>
                  <xsl:when test="@code='h'">
                    <xsl:text>, </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>. </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
              </xsl:when>
              <xsl:when test="@code='e'">
                <xsl:text> : </xsl:text>
                <xsl:value-of select="."/>
              </xsl:when>
              <xsl:when test="@code='f'">
                <xsl:text> / </xsl:text>
                <xsl:value-of select="."/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </xsl:for-each>
      </span>
    </xsl:if>

    <!-- OpenURL -->
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
      <span class="results_summary">
        <a>
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
        </a>
      </span>
    </xsl:if>
    <!-- End of OpenURL -->

    <span class="results_summary">
      <xsl:if test="marc:datafield[@tag=115]">
        <xsl:call-template name="tag_115" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=205]/marc:subfield[@code='a' or @code='b']">
        <xsl:call-template name="tag_205" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=210]/marc:subfield[@code='c' or @code='d'] and marc:datafield[@tag=099]/marc:subfield[@code='t']!='Article'">
        <xsl:call-template name="tag_210" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=225]/marc:subfield[@code='a']">
        <xsl:call-template name="tag_225" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=463]">
        <xsl:call-template name="tag_463" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=930]">
        <xsl:call-template name="tag_930" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=940]">
        <xsl:call-template name="tag_940" />
      </xsl:if>
      <xsl:if test="marc:datafield[@tag=856]">
        <xsl:call-template name="tag_856" />
      </xsl:if>
    </span>

<xsl:if test="not(marc:datafield[@tag=856])">
<span class="results_summary_dispo">
    
    <xsl:choose>
      <xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">&#160;</xsl:when> 

      <xsl:when test="count(key('item-by-status', 'available'))>0">
        <span class="available">
        <xsl:text>Disponible : </xsl:text>
        <span class="availableBib">
        <xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
        <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-branch-callnumber', concat(items:status, ' ', items:homebranch, ' ', items:location, ' ',items:itemcallnumber))[1])]">
            <b><xsl:value-of select="items:homebranch"/></b><xsl:text> </xsl:text><xsl:value-of select="items:location"/>
  			    <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]
  			    </xsl:if>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-branch-callnumber', concat(items:status, ' ', items:homebranch, ' ', items:location, ' ',items:itemcallnumber)))"/>
            <xsl:text>)</xsl:text>
            <xsl:choose>
              <xsl:when test="position()=last()">
              </xsl:when>
              <xsl:otherwise>
                <xsl:text disable-output-escaping="yes">&lt;br /&gt;</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </span></span>
      </xsl:when>
   </xsl:choose>

   <xsl:choose>
      <xsl:when test="count(key('item-by-status', 'reference'))>0">
        <xsl:if test="count(key('item-by-status', 'available'))>0"><br /></xsl:if>
          <span class="available">
          <xsl:text>Consultable sur place : </xsl:text>
          <span class="availableBib">
          <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
          <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-branch-callnumber', concat(items:status, ' ', items:homebranch, ' ', items:location, ' ',items:itemcallnumber))[1])]">
            <b><xsl:value-of select="items:homebranch"/></b><xsl:text> </xsl:text><xsl:value-of select="items:location"/>
            <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-branch-callnumber', concat(items:status, ' ', items:homebranch, ' ', items:location, ' ',items:itemcallnumber)))"/>
            <xsl:text>)</xsl:text>
            <xsl:choose>
              <xsl:when test="position()=last()">
              </xsl:when>
              <xsl:otherwise>
		<xsl:text disable-output-escaping="yes">&lt;br /&gt;</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </span></span>
      </xsl:when>
   </xsl:choose>

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Checked out'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0"><br /></xsl:if>
      <span class="unavailable">
        <xsl:text>En prêt : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Checked out')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'In process'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="unavailable">
        <xsl:text>En traitement : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'In process')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Waiting'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="unavailable">
        <xsl:text>Réservation : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Waiting')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Quarantaine'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="unavailable">
        <xsl:text>En quarantaine : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Quarantaine')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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


   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Absent inventory'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="lost">
        <xsl:text>Absent inventaire : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Absent inventory')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Confidential'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="unavailable">
        <xsl:text>Confidentiel : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Confidential')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

   <xsl:choose>
    <xsl:when test="count(key('item-by-status', 'Missing'))>0">
     <xsl:if test="count(key('item-by-status', 'available'))>0 or count(key('item-by-status', 'reference'))>0 or count(key('item-by-status', 'Checked out'))>0"><br /></xsl:if>
      <span class="lost">
        <xsl:text>Manquant : </xsl:text>
          <xsl:variable name="checkout_items" select="key('item-by-status', 'Missing')"/>
          <xsl:for-each select="$checkout_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
            <xsl:value-of select="items:homebranch"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
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

     <br />
    <xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
      <span class="lost">
        <xsl:text>Indisponible (</xsl:text>
        <xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
        <xsl:text>). </xsl:text>
      </span>
    </xsl:if>
    <xsl:if test="count(key('item-by-status', 'Lost'))>0">
      <span class="lost">
        <xsl:text>Perdu (</xsl:text>
        <xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
        <xsl:text>). </xsl:text>
      </span>
    </xsl:if>
    <xsl:if test="count(key('item-by-status', 'Damaged'))>0">
      <span class="lost">
        <xsl:text>Endomagé (</xsl:text>
        <xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
        <xsl:text>). </xsl:text>
      </span>
    </xsl:if>
    <xsl:if test="count(key('item-by-status', 'On Orangemanr'))>0">
      <span class="unavailable">
        <xsl:text>En commande (</xsl:text>
        <xsl:value-of select="count(key('item-by-status', 'On order'))"/>
        <xsl:text>). </xsl:text>
      </span>
    </xsl:if>
    <xsl:if test="count(key('item-by-status', 'In transit'))>0">
      <span class="unavailable">
        <xsl:text>En transit (</xsl:text>
        <xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
        <xsl:text>). </xsl:text>
      </span>
    </xsl:if>
  </span>
 </xsl:if>
</xsl:template>
</xsl:stylesheet>
