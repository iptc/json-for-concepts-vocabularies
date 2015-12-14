<?xml version="1.0" encoding="UTF-8"?>
<!--
	Stylesheet for transforming an IPTC NewsML-G2 KnowledgeItem into IKOS JSON
	Author: Michael Steidl, IPTC
	Version:
	v1 2015-12-14, draft version 1 (incomplete: in scheme part notes are missing, in concept part some relationship properties are missing)

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nar="http://iptc.org/std/nar/2006-10-01/">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="squot">'</xsl:variable>
<!--**************************************************************************************************
*** Main template
**************************************************************************************************-->
	<xsl:template match="/">
			<xsl:text>{ &#x0D;&#x0A;</xsl:text>
			<xsl:apply-templates select="//nar:schemeMeta"/>
			<xsl:apply-templates select="//nar:conceptSet"><xsl:with-param name="schemeUri" select="//nar:schemeMeta/@uri"/></xsl:apply-templates>
			<xsl:text>} &#x0D;&#x0A;</xsl:text>
	</xsl:template>
<!--**************************************************************************************************
*** Scheme template
**************************************************************************************************-->
	<xsl:template match="nar:schemeMeta">
		<xsl:text>"uri" : "</xsl:text><xsl:value-of select="./@uri"/><xsl:text>", &#x0D;&#x0A;</xsl:text>
		<xsl:text>	"type": [
		"http://www.w3.org/2004/02/skos/core#ConceptScheme"
	],
</xsl:text>
		<xsl:text>"prefAlias" : "</xsl:text><xsl:value-of select="./@preferredalias"/><xsl:text>", &#x0D;&#x0A;</xsl:text>
		<xsl:text>"authority" : "</xsl:text><xsl:value-of select="./@authority"/><xsl:text>", &#x0D;&#x0A;</xsl:text>
		<xsl:text>"prefLabel" : {&#x0D;&#x0A;</xsl:text>
		<xsl:for-each select="nar:name">
			<xsl:if test="position()!=1"><xsl:text>,&#x0D;&#x0A;</xsl:text></xsl:if>
			<xsl:text>"</xsl:text><xsl:value-of select="./@xml:lang"/><xsl:text>" : "</xsl:text><xsl:call-template name="normalizeText"><xsl:with-param name="txt" select="."/></xsl:call-template><xsl:text>"</xsl:text>
		</xsl:for-each>
		<xsl:text>},&#x0D;&#x0A;</xsl:text>
		<xsl:text>"definition" : {&#x0D;&#x0A;</xsl:text>
		<xsl:for-each select="nar:definition">
			<xsl:if test="position()!=1"><xsl:text>,&#x0D;&#x0A;</xsl:text></xsl:if>
			<xsl:text>"</xsl:text><xsl:value-of select="./@xml:lang"/><xsl:text>" : "</xsl:text><xsl:call-template name="normalizeText"><xsl:with-param name="txt" select="."/></xsl:call-template><xsl:text>"</xsl:text>
		</xsl:for-each>
		<xsl:text>},&#x0D;&#x0A;</xsl:text>
		<xsl:text>"hasTopConcept" : [&#x0D;&#x0A;</xsl:text>	
		<xsl:for-each select="nar:related[@rel='skos:hasTopConcept' ]">
			<xsl:if test="position()!=1"><xsl:text>, </xsl:text></xsl:if>
			<xsl:text>"</xsl:text><xsl:value-of select="../@uri"/><xsl:value-of select="substring-after(@qcode, ':')"/><xsl:text>"</xsl:text>			
		</xsl:for-each>
		<xsl:text>&#x0D;&#x0A;],&#x0D;&#x0A;</xsl:text>
	</xsl:template>
<!--**************************************************************************************************
*** Concept template
**************************************************************************************************-->
	<xsl:template match="nar:conceptSet">
		<xsl:param name="schemeUri"/>
		<xsl:text>"conceptSet" : [&#x0D;&#x0A;</xsl:text>
		<xsl:for-each select="nar:concept">
			<xsl:if test="position()!=1"><xsl:text>,&#x0D;&#x0A;</xsl:text></xsl:if>
			<xsl:text>{&#x0D;&#x0A;</xsl:text>
			<xsl:text>"uri" : "</xsl:text><xsl:value-of select="$schemeUri"/><xsl:value-of select="substring-after(nar:conceptId/@qcode, ':')"/><xsl:text>", &#x0D;&#x0A;</xsl:text>
			<xsl:text>"qcode" : "</xsl:text><xsl:value-of select="nar:conceptId/@qcode"/><xsl:text>", &#x0D;&#x0A;</xsl:text>
			<xsl:text>	"type": [
		"http://www.w3.org/2004/02/skos/core#Concept"
	],
</xsl:text>
			<xsl:text>"inScheme" : [ "</xsl:text><xsl:value-of select="$schemeUri"/><xsl:text>" ], &#x0D;&#x0A;</xsl:text>	
			<xsl:if test="//nar:schemeMeta/nar:related[@rel='skos:hasTopConcept' and @qcode=nar:conceptId/@qcode]">
				<xsl:text>"topConceptOf" : "</xsl:text><xsl:value-of select="$schemeUri"/><xsl:text>", &#x0D;&#x0A;</xsl:text>	
			</xsl:if>
			<xsl:text>"created" : "</xsl:text><xsl:value-of select="nar:conceptId/@created"/><xsl:text>", &#x0D;&#x0A;</xsl:text>	
			<xsl:if test="./@modified">
				<xsl:text>"modified" : "</xsl:text><xsl:value-of select="./@modified"/><xsl:text>", &#x0D;&#x0A;</xsl:text>	
			</xsl:if>
			<xsl:if test="nar:conceptId/@retired">
				<xsl:text>"retired" : "</xsl:text><xsl:value-of select="nar:conceptId/@retired"/><xsl:text>", &#x0D;&#x0A;</xsl:text>	
			</xsl:if>
			<xsl:text>"prefLabel" : {&#x0D;&#x0A;</xsl:text>
			<xsl:for-each select="nar:name">
				<xsl:if test="position()!=1"><xsl:text>,&#x0D;&#x0A;</xsl:text></xsl:if>
				<xsl:text>"</xsl:text><xsl:value-of select="./@xml:lang"/><xsl:text>" : "</xsl:text><xsl:call-template name="normalizeText"><xsl:with-param name="txt" select="."/></xsl:call-template><xsl:text>"</xsl:text>
			</xsl:for-each>
			<xsl:text>},&#x0D;&#x0A;</xsl:text>
			<xsl:text>"definition" : {&#x0D;&#x0A;</xsl:text>
			<xsl:for-each select="nar:definition">
				<xsl:if test="position()!=1"><xsl:text>,&#x0D;&#x0A;</xsl:text></xsl:if>
				<xsl:text>"</xsl:text><xsl:value-of select="./@xml:lang"/><xsl:text>" : "</xsl:text><xsl:call-template name="normalizeText"><xsl:with-param name="txt" select="."/></xsl:call-template><xsl:text>"</xsl:text>
			</xsl:for-each>
			<xsl:text>}</xsl:text>
			<xsl:if test="count(nar:broader) &gt; 0">
				<xsl:text>,&#x0D;&#x0A;"broader" : [&#x0D;&#x0A;</xsl:text>	
				<xsl:for-each select="nar:broader">
					<xsl:if test="position()!=1"><xsl:text>, </xsl:text></xsl:if>
					<xsl:text>"</xsl:text><xsl:value-of select="$schemeUri"/><xsl:value-of select="substring-after(@qcode, ':')"/><xsl:text>"</xsl:text>			
				</xsl:for-each>
				<xsl:text>&#x0D;&#x0A;]&#x0D;&#x0A;</xsl:text>
			</xsl:if>
			<xsl:text>}</xsl:text>
<!--		End of data for a Concept  -->
		</xsl:for-each>
		<xsl:text>]&#x0D;&#x0A;</xsl:text>	
	</xsl:template>
<!--**************************************************************************************************
*** Normalize Text template
**************************************************************************************************-->
	<xsl:template name="normalizeText">
		<xsl:param name="txt"/>
		<xsl:value-of select='translate($txt,concat("&#x0D;&#x0A;’",$quot),"  **") '/>
	</xsl:template>
</xsl:stylesheet>
