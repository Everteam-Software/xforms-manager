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
            Description: This page call the getTaskOwnerAndState operatin of TMS to check the state of the task before action claim/complete.
			Author: Ravinderjit Singh [rjassal@intalio.com]
            Creation Date: May 10th, 2012
            Copyright Intalio,Inc. All rights reserved.
        -->
		
<p:config xmlns:p="http://www.orbeon.com/oxf/pipeline"
	xmlns:oxf="http://www.orbeon.com/oxf/processors"
	xmlns:xforms="http://www.w3.org/2002/xforms"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:delegation="http://orbeon.org/oxf/xml/delegation"
	xmlns:b4p="http://www.intalio.com/bpms/workflow/ib4p_20051115"
	xmlns:tas="http://www.intalio.com/BPMS/Workflow/TaskAttachmentService/"
	xmlns:tms="http://www.intalio.com/BPMS/Workflow/TaskManagementServices-20051109/"
	xmlns:ev="http://www.w3.org/2001/xml-events">
	
	<p:param name="data" type="input"/>
	<p:param name="data" type="output"/>
	
	<p:processor name="oxf:xslt">
		<p:input name="data" href="#data"/>
		<p:input name="config">
			<xsl:stylesheet version="2.0">
				<xsl:import href="oxf:/oxf/xslt/utils/copy.xsl"/>

				<xsl:template match="/">
					<xsl:copy>
						<delegation:execute service="tms" operation="getTaskOwnerAndStateRequest" xsl:version="2.0">
							<tms:taskId>
								<xsl:value-of select="/*:output/@taskId"/>
							</tms:taskId>
							<tms:participantToken>
								<xsl:value-of select="/*:output/@participantToken"/>
							</tms:participantToken>
						</delegation:execute>
					</xsl:copy>
				</xsl:template>
				
			</xsl:stylesheet>
		</p:input>
		<p:output name="data" id="getTaskOwnerAndStateOutput"/>
	</p:processor>
	
	<p:processor name="oxf:delegation">
		<p:input name="interface" href="oxf:/config/services.xml"/>
		<p:input name="call" href="#getTaskOwnerAndStateOutput"/>
		<p:output name="data" ref="data"/>
	</p:processor>
</p:config>