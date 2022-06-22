<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" method="text" indent="yes"/>
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="//error">
                # Some errors occurred. Here's the report:
                <xsl:for-each select="artist_data/error">
                    * <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="artist_data/artist">
                    # <xsl:value-of select="name"/>
                    ---
                    ---
                    <xsl:when test="disambiguation">
                        * Disambiguation: <xsl:value-of sleect="disambiguation"/>
                    </xsl:when>
                    * Type: <xsl:value-of select="type"/>
                    * Birth Place: <xsl:value-of select="area/origin"/>, <xsl:value-of select="area/name"/>
                    * Life-span: <xsl:value-of select="life-span/begin"/> - <xsl:if test="life-span/ended=true()">present<xsl:if><xsl:otherwise><xsl:value-of select="life-span/end"/><xsl:otherwise>
                </xsl:value-of>
                ---
                ---
                ### Recordings:
                <xsl:for-each select="recordings/recording">
                    #### <xsl:value-of select="title"/><xsl:when test="length"> . Length <xsl:value-of select="length"></xsl:when><xsl:when test="first-release-date"> . First release date: <xsl:value-of select="first-release-date"></xsl:when>
                    ###### Releases:
                    |===
                    | ** Title ** | ** Date ** | ** Country ** | ** Type ** | ** Track Number **
                    <xsl:for-each select="release">
                        | <xsl:value-of select="title"/> | <xsl:value-of select="date"/> | <xsl:value-of select="country"/> | <xsl:value-of select="Type"/> | <xsl:value-of select="track-number"/>
                    <xsl:for-each>
                    |===
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>