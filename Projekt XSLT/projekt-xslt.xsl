<?xml version="1.0" encoding="UTF-8"?>
<!--Kamil Malinowski-->
<!--grupa A-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
    <xsl:variable name="head">
        <head>
            <title>Sprawdzian xsl</title>
            <meta charset="UTF-8" />
            <style>table, tr, th, td { border: black solid 2px; border-collapse: collapse; padding: 3px}</style>
        </head>
    </xsl:variable>
    <xsl:attribute-set name="h1attributes">
        <xsl:attribute name="style">text-decoration:underline;</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template match="/">
		<html>
            <xsl:copy-of select="$head"/>
			<body>
                <xsl:call-template name="powitanie">
                    <xsl:with-param name="pow" select="'Powitanie'"/>
                </xsl:call-template>
			
                <h1 xsl:use-attribute-sets="h1attributes"> Pracownicy</h1>
                <table>
                    <tr>
                        <th>Imie</th>
                        <th>Nazwisko</th>
                        <th>Wiek</th>
                    </tr>
                    <xsl:for-each select="sklep/pracownicy/pracownik">
                    <xsl:sort/>
                        <tr>
                            <td><xsl:value-of select="imie"/></td>
                            <td>
                            <xsl:copy>
                                <xsl:apply-templates select="current()/nazwisko"/>
                            </xsl:copy>
                            </td>
                            <td><xsl:number value="wiek"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <h1 xsl:use-attribute-sets="h1attributes"> Kobiety</h1>
                <table>
                    <tr>
                        <th>Imie</th>
                        <th>Nazwisko</th>
                        <th>Wiek</th>
                    </tr>
                    <xsl:for-each select="sklep/pracownicy/pracownik">
                    <xsl:choose>
                    <xsl:when test="not(imie/@plec='m')">
                        <tr>
                            <td><xsl:value-of select="imie"/></td>
                            <td>
                            <xsl:copy>
                                <xsl:apply-templates select="current()/nazwisko"/>
                            </xsl:copy>
                            </td>
                            <td><xsl:number value="wiek"/></td>
                        </tr>
                    </xsl:when>
                    </xsl:choose>
                    </xsl:for-each>
                </table>
                
                <h1 xsl:use-attribute-sets="h1attributes"> Pracownicy starsi niż 45lat</h1>
                <table>
                    <tr>
                        <th>Imie</th>
                        <th>Nazwisko</th>
                        <th>Wiek</th>
                    </tr>
                    <xsl:for-each select="sklep/pracownicy/pracownik">
                    <xsl:if test="number(wiek) &gt;45">
                        <tr>
                            <td><xsl:value-of select="imie"/></td>
                            <td>
                            <xsl:copy>
                                <xsl:apply-templates select="current()/nazwisko"/>
                            </xsl:copy>
                            </td>
                            <td><xsl:number value="wiek"/></td>
                        </tr>
                    </xsl:if>
                    </xsl:for-each>
                </table>
                
                <h1 xsl:use-attribute-sets="h1attributes"> Sredni wiek pracowników: <xsl:value-of select="sum(/sklep/pracownicy/pracownik/wiek) div count(/sklep/pracownicy/pracownik)"/></h1>
                
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="powitanie">
	<xsl:param name="pow"/>
        <h1><xsl:value-of select="$pow"/></h1>
	</xsl:template>
</xsl:stylesheet>


