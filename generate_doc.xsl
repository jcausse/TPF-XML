<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" method="text" indent="yes"/>
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="//error">
= Some errors occurred. Here's the report:
                <xsl:for-each select="artist_data/error">
* <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="imprimir"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<xsl:template name="imprimir">
= <xsl:value-of select="artist_data/artist/name"/>
---
---
                <xsl:if test="artist_data/artist/disambiguation">
* Disambiguation: <xsl:value-of select="artist_data/artist/disambiguation"/>
                </xsl:if>
* Type: <xsl:value-of select="artist_data/artist/type"/>
* Birth Place: <xsl:value-of select="artist_data/artist/area/origin"/>, <xsl:value-of select="artist_data/artist/area/name"/>
* Life-span: <xsl:value-of select="artist_data/artist/life-span/begin"/> - <xsl:choose><xsl:when test="artist_data/artist/life-span/ended=true()"><xsl:value-of select="artist_data/artist/life-span/end"/></xsl:when><xsl:otherwise>present</xsl:otherwise></xsl:choose>
---
---
=== Recordings:
                <xsl:for-each select="artist_data/artist/recordings/recording">
==== <xsl:value-of select="title"/><xsl:if test="length"> . Length <xsl:value-of select="length"/></xsl:if><xsl:if test="first-release-date"> . First release date: <xsl:value-of select="first-release-date"/></xsl:if>
====== Releases:
|===
| Title | Date | Country | Type | Track Number
                    <xsl:for-each select="release">
| <xsl:value-of select="title"/> | <xsl:value-of select="date"/> | <xsl:value-of select="country"/> | <xsl:value-of select="Type"/> | <xsl:value-of select="track-number"/>
            </xsl:for-each>
|===
                </xsl:for-each>
            </xsl:template>
</xsl:stylesheet>
