require "buildr"

# Keep this structure to allow the build system to update version numbers.
VERSION_NUMBER = "6.0.0.50-SNAPSHOT"

repositories.remote = [ 
  "http://www.intalio.org/public/maven2", 
  "http://repo1.maven.org/maven2",
  "http://people.apache.org/repo/m2-ibiblio-rsync-repository/"
]

repositories.release_to[:username] ||= "release"
repositories.release_to[:url] ||= "sftp://www.intalio.org/var/www-org/public/maven2"
repositories.release_to[:permissions] ||= 0664

# the list of dependencies below has been generated
ORBEON_LIBS = ["orbeon:activation-1_0_2:jar:3.8.0.201005141856-CE",
"orbeon:ant-1_6_5:jar:3.8.0.201005141856-CE",
"orbeon:ant-jsch-1_6_5:jar:3.8.0.201005141856-CE",
"orbeon:antlr-2_7_4_orbeon:jar:3.8.0.201005141856-CE",
"orbeon:avalon-framework-4_2_0:jar:3.8.0.201005141856-CE",
"orbeon:axis_1_2_1-axis:jar:3.8.0.201005141856-CE",
"orbeon:axis_1_2_1-jaxrpc:jar:3.8.0.201005141856-CE",
"orbeon:axis_1_2_1-saaj:jar:3.8.0.201005141856-CE",
"orbeon:axis_1_2_1-wsdl4j-1.5.1:jar:3.8.0.201005141856-CE",
"orbeon:barcode4j-1.0:jar:3.8.0.201005141856-CE",
"orbeon:batik-all-1_6:jar:3.8.0.201005141856-CE",
"orbeon:castor-0_9_4_3-xml:jar:3.8.0.201005141856-CE",
"orbeon:commons-beanutils-1_5:jar:3.8.0.201005141856-CE",
"orbeon:commons-cli-1_0:jar:3.8.0.201005141856-CE",
"orbeon:commons-codec-1_3:jar:3.8.0.201005141856-CE",
"orbeon:commons-collections-3_1:jar:3.8.0.201005141856-CE",
"orbeon:commons-digester-1_5:jar:3.8.0.201005141856-CE",
"orbeon:commons-discovery-0_2:jar:3.8.0.201005141856-CE",
"orbeon:commons-fileupload-1.2.1:jar:3.8.0.201005141856-CE",
"orbeon:commons-httpclient-3_1:jar:3.8.0.201005141856-CE",
"orbeon:commons-io-1_1:jar:3.8.0.201005141856-CE",
"orbeon:commons-lang-2_3:jar:3.8.0.201005141856-CE",
"orbeon:commons-logging-1_0_4:jar:3.8.0.201005141856-CE",
"orbeon:commons-pool-1.3:jar:3.8.0.201005141856-CE",
"orbeon:commons-validator-1_0_2:jar:3.8.0.201005141856-CE",
"orbeon:dom4j-1_6_1:jar:3.8.0.201005141856-CE",
"orbeon:exist-1_2_6_orbeon_20090702:jar:3.8.0.201005141856-CE",
"orbeon:exist-antlr-2_7_6:jar:3.8.0.201005141856-CE",
"orbeon:exist-jgroups-all-exist:jar:3.8.0.201005141856-CE",
"orbeon:exist-jta:jar:3.8.0.201005141856-CE",
"orbeon:exist-modules-1_2_6_orbeon_20090702:jar:3.8.0.201005141856-CE",
"orbeon:exist-ngram-module-1_2_6_orbeon_20090702:jar:3.8.0.201005141856-CE",
"orbeon:exist-optional-1_2_6_orbeon_20090702:jar:3.8.0.201005141856-CE",
"orbeon:exist-quartz-1_6_0:jar:3.8.0.201005141856-CE",
"orbeon:exist-stax-api-1_0_1:jar:3.8.0.201005141856-CE",
"orbeon:exist-ws-commons-util-1.0.2:jar:3.8.0.201005141856-CE",
"orbeon:exist-xmldb:jar:3.8.0.201005141856-CE",
"orbeon:exist-xmlrpc-client-3_1_1:jar:3.8.0.201005141856-CE",
"orbeon:exist-xmlrpc-common-3_1_1:jar:3.8.0.201005141856-CE",
"orbeon:exist-xmlrpc-server-3_1_1:jar:3.8.0.201005141856-CE",
"orbeon:flyingsaucer-20100212-itext-2_1_7:jar:3.8.0.201005141856-CE",
"orbeon:flyingsaucer-core-renderer_orbeon_20100512:jar:3.8.0.201005141856-CE",
"orbeon:fop-0_93:jar:3.8.0.201005141856-CE",
"orbeon:hsqldb-1_8_0_7:jar:3.8.0.201005141856-CE",
"orbeon:itext-bcmail-jdk14-138:jar:3.8.0.201005141856-CE",
"orbeon:itext-bcprov-jdk14-138:jar:3.8.0.201005141856-CE",
"orbeon:jakarta-oro-2_0_8_orbeon:jar:3.8.0.201005141856-CE",
"orbeon:jakarta-poi-1.11.0-dev-20030610:jar:3.8.0.201005141856-CE",
"orbeon:jakarta-slide-webdavlib-2.0rc1:jar:3.8.0.201005141856-CE",
"orbeon:jaxen-1_1_beta_9:jar:3.8.0.201005141856-CE",
"orbeon:jcommon-1.0.12:jar:3.8.0.201005141856-CE",
"orbeon:jfreechart-1.0.9:jar:3.8.0.201005141856-CE",
"orbeon:jms-api-1_1:jar:3.8.0.201005141856-CE",
"orbeon:jsch-0.1.42:jar:3.8.0.201005141856-CE",
"orbeon:jtidy-8.0-20060801.131059-3:jar:3.8.0.201005141856-CE",
"orbeon:junit:jar:3.8.0.201005141856-CE",
"orbeon:log4j-1_2_15:jar:3.8.0.201005141856-CE",
"orbeon:mail-1_3_2:jar:3.8.0.201005141856-CE",
"orbeon:metadata-extractor-2_1:jar:3.8.0.201005141856-CE",
"orbeon:msv-20081113_orbeon_20081209:jar:3.8.0.201005141856-CE",
"orbeon:msv-isorelax-20070407:jar:3.8.0.201005141856-CE",
"orbeon:msv-relaxngDatatype-20070407:jar:3.8.0.201005141856-CE",
"orbeon:msv-xsdlib-20070407_orbeon_20100309:jar:3.8.0.201005141856-CE",
"orbeon:orbeon-form-builder:jar:3.8.0.201005141856-CE",
"orbeon:orbeon-form-runner:jar:3.8.0.201005141856-CE",
"orbeon:orbeon-resources-private:jar:3.8.0.201005141856-CE",
"orbeon:orbeon-resources-public:jar:3.8.0.201005141856-CE",
"orbeon:orbeon-xforms-filter:jar:3.8.0.201005141856-CE",
"orbeon:orbeon:jar:3.8.0.201005141856-CE",
"orbeon:pdfbox-0_7_1:jar:3.8.0.201005141856-CE",
"orbeon:saxon-9-1-0-8_orbeon_20100413:jar:3.8.0.201005141856-CE",
"orbeon:saxpath-dev_orbeon:jar:3.8.0.201005141856-CE",
"orbeon:tagsoup-1.2:jar:3.8.0.201005141856-CE",
"orbeon:xerces-resolver-2_9_orbeon_20070711:jar:3.8.0.201005141856-CE",
"orbeon:xerces-serializer-2_9_orbeon_20070711:jar:3.8.0.201005141856-CE",
"orbeon:xerces-xercesImpl-2_9_orbeon_20070711:jar:3.8.0.201005141856-CE",
"orbeon:xerces-xml-apis-2_9_orbeon_20070711:jar:3.8.0.201005141856-CE",
"orbeon:xmlgraphics-commons-1_1:jar:3.8.0.201005141856-CE"
]

desc "XForms Manager"
define "xforms-manager" do
  project.version = VERSION_NUMBER
  project.group = "org.intalio.tempo"
  compile.options.target = "1.5"

  compile.with ORBEON_LIBS
  resources.filter.using "version" => VERSION_NUMBER
  package :war
end