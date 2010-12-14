<?xml version="1.0"?>
<!--
  Copyright (C) 2010 Orbeon, Inc.

  This program is free software; you can redistribute it and/or modify it under the terms of the
  GNU Lesser General Public License as published by the Free Software Foundation; either version
  2.1 of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.

  The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="http://orbeon.org/oxf/xml/formatting" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xxforms="http://orbeon.org/oxf/xml/xforms" xmlns:version="java:org.orbeon.oxf.common.Version" version="2.0">
  <!-- XML formatting -->
  <xsl:import href="oxf:/ops/utils/formatting/formatting.xsl"/>
  <!-- Orbeon Forms version -->
  <xsl:variable name="orbeon-forms-version" select="version:getVersion()" as="xs:string"/>
  <!-- - - - - - - Themed page template - - - - - - -->
  <xsl:template match="/">
    <xhtml:html>
      <xsl:apply-templates select="/xhtml:html/@*"/>
      <xhtml:head>
        <!-- Add meta as early as possible -->
        <xsl:apply-templates select="/xhtml:html/xhtml:head/xhtml:meta"/>
        <!-- NOTE: The XForms engine may place additional scripts and stylesheets here as needed -->
        <!-- Handle head elements except scripts -->
        <xsl:for-each select="/xhtml:html/xhtml:head/(xhtml:meta | xhtml:link | xhtml:style)">
          <xsl:element name="xhtml:{local-name()}" namespace="{namespace-uri()}">
            <xsl:apply-templates select="@*|node()"/>
          </xsl:element>
        </xsl:for-each>
        <!-- Title -->
        <xhtml:title>
          <xsl:apply-templates select="/xhtml:html/xhtml:head/xhtml:title/@*"/>
          <xsl:choose>
            <xsl:when test="/xhtml:html/xhtml:head/xhtml:title != ''">
              <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="(/xhtml:html/xhtml:body/xhtml:h1)[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xhtml:title>
        <!-- Orbeon Forms version -->
        <xhtml:meta name="generator" content="Orbeon Forms {$orbeon-forms-version}"/>
        <!-- Favicon -->
        <xhtml:link rel="shortcut icon" href="/ops/images/orbeon-icon-16.ico"/>
        <xhtml:link rel="icon" href="/ops/images/orbeon-icon-16.png" type="image/png"/>
      </xhtml:head>
      <xhtml:body>
        <!-- Copy body attributes -->
        <xsl:apply-templates select="/xhtml:html/xhtml:body/@*"/>
        <xsl:apply-templates select="/xhtml:html/xhtml:body/node()"/>
      </xhtml:body>
      <!-- Scripts at the bottom of the page. This is not valid HTML, but it is a recommended practice for
                 performance as of early 2008. See http://developer.yahoo.com/performance/rules.html#js_bottom -->
      <xsl:for-each select="/xhtml:html/xhtml:head/xhtml:script">
        <xsl:element name="xhtml:{local-name()}" namespace="{namespace-uri()}">
          <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
      </xsl:for-each>
    </xhtml:html>
  </xsl:template>
  <!-- Simply copy everything that's not matched -->
  <xsl:template match="@*|node()" priority="-2">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
