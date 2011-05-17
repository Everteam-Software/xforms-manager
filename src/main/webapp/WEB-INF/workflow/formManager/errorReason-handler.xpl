<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2005-2008 Intalio inc.
*
* All rights reserved. This program and the accompanying materials
* are made available under the terms of the Eclipse Public License v1.0
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v10.html
*
* Contributors:
* Intalio inc. - initial API and implementation
-->
        <!--
            Description: This page serves to catch and handle exceptions, due to workflow actions, on already completed tasks.
			Author: Sandeep Reddy
			[sandeep@intalio.com]
            Creation Date: May 16th, 2011
            Copyright Intalio,Inc. All rights reserved.
        -->

<p:config xmlns:p="http://www.orbeon.com/oxf/pipeline"
          xmlns:oxf="http://www.orbeon.com/oxf/processors"
          xmlns:saxon="http://saxon.sf.net/"
          xmlns:xhtml="http://www.w3.org/1999/xhtml"
          xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		  
	<p:param name="header" type="input"/>
	<p:param name="data" type="input"/>
	<p:param name="ws-request" type="input"/>
	<p:param name="data" type="output"/>
	
	<p:processor name="oxf:xslt">
		<p:input name="data" href="#data"/>
		<p:input name="ws-request" href="#ws-request"/>
		<p:input name="header" href="#header"/>
		<p:input name="config">
			<xsl:stylesheet version="2.0">
				<xsl:output method="html" name="ws-request-output"/>
				<xsl:template match="/">
					<xhtml:html>
						<xhtml:body>
							<xhtml:center>
								<xhtml:h1><xsl:copy-of select="doc('input:header')/*"/></xhtml:h1>
							</xhtml:center>
							<xhtml:div>
								<xhtml:b>Delegation in XPL to Web-Service:</xhtml:b>
								<xhtml:br/>
								<xsl:copy-of select="saxon:serialize(doc('input:ws-request'), 'ws-request-output')"/>
							</xhtml:div>
							<xhtml:p>
								<xsl:apply-templates select="*"/>
							</xhtml:p>
						</xhtml:body>
					</xhtml:html>
				</xsl:template>
				
			</xsl:stylesheet>
		</p:input>
		<p:output name="data" ref="data"/>
	</p:processor>
	
	
</p:config>
		