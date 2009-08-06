require "buildr"

# Keep this structure to allow the build system to update version numbers.
VERSION_NUMBER = "6.0.0.45-SNAPSHOT"

repositories.remote = [ 
  "http://www.intalio.org/public/maven2", 
  "http://repo1.maven.org/maven2",
  "http://people.apache.org/repo/m2-ibiblio-rsync-repository/"
]

repositories.release_to[:username] ||= "release"
repositories.release_to[:url] ||= "sftp://www.intalio.org/var/www-org/public/maven2"
repositories.release_to[:permissions] ||= 0664

# the list of dependencies below has been generated
ORBEON_LIBS = ["orbeon:activation-1_0_2:jar:dev-3.7.1.200905272119",
"orbeon:ant-1_6_5:jar:dev-3.7.1.200905272119",
"orbeon:antlr-2_7_4_orbeon:jar:dev-3.7.1.200905272119",
"orbeon:avalon-framework-4_2_0:jar:dev-3.7.1.200905272119",
"orbeon:axis_1_2_1-axis:jar:dev-3.7.1.200905272119",
"orbeon:axis_1_2_1-jaxrpc:jar:dev-3.7.1.200905272119",
"orbeon:axis_1_2_1-saaj:jar:dev-3.7.1.200905272119",
"orbeon:axis_1_2_1-wsdl4j-1.5.1:jar:dev-3.7.1.200905272119",
"orbeon:barcode4j-1.0:jar:dev-3.7.1.200905272119",
"orbeon:batik-all-1_6:jar:dev-3.7.1.200905272119",
"orbeon:castor-0_9_4_3-xml:jar:dev-3.7.1.200905272119",
"orbeon:commons-beanutils-1_5:jar:dev-3.7.1.200905272119",
"orbeon:commons-cli-1_0:jar:dev-3.7.1.200905272119",
"orbeon:commons-codec-1_3:jar:dev-3.7.1.200905272119",
"orbeon:commons-collections-3_1:jar:dev-3.7.1.200905272119",
"orbeon:commons-digester-1_5:jar:dev-3.7.1.200905272119",
"orbeon:commons-discovery-0_2:jar:dev-3.7.1.200905272119",
"orbeon:commons-fileupload-1.2.1:jar:dev-3.7.1.200905272119",
"orbeon:commons-httpclient-3_1:jar:dev-3.7.1.200905272119",
"orbeon:commons-io-1_1:jar:dev-3.7.1.200905272119",
"orbeon:commons-lang-2_3:jar:dev-3.7.1.200905272119",
"orbeon:commons-pool-1.3:jar:dev-3.7.1.200905272119",
"orbeon:commons-validator-1_0_2:jar:dev-3.7.1.200905272119",
"orbeon:dom4j-1_6_1:jar:dev-3.7.1.200905272119",
"orbeon:exist-1_2_4:jar:dev-3.7.1.200905272119",
"orbeon:exist-antlr-2_7_6:jar:dev-3.7.1.200905272119",
"orbeon:exist-jgroups-all-exist:jar:dev-3.7.1.200905272119",
"orbeon:exist-jta:jar:dev-3.7.1.200905272119",
"orbeon:exist-modules-1_2_4:jar:dev-3.7.1.200905272119",
"orbeon:exist-ngram-module-1_2_4:jar:dev-3.7.1.200905272119",
"orbeon:exist-optional-1_2_4:jar:dev-3.7.1.200905272119",
"orbeon:exist-quartz-1_6_0:jar:dev-3.7.1.200905272119",
"orbeon:exist-stax-api-1_0_1:jar:dev-3.7.1.200905272119",
"orbeon:exist-xmldb:jar:dev-3.7.1.200905272119",
"orbeon:exist-xmlrpc-1_2-patched:jar:dev-3.7.1.200905272119",
"orbeon:flying-saucer-r8-core-renderer-minimal:jar:dev-3.7.1.200905272119",
"orbeon:flying-saucer-r8-core-renderer:jar:dev-3.7.1.200905272119",
"orbeon:flying-saucer-r8-itext-2_0_8:jar:dev-3.7.1.200905272119",
"orbeon:fop-0_93:jar:dev-3.7.1.200905272119",
"orbeon:hsqldb-1_8_0_7:jar:dev-3.7.1.200905272119",
"orbeon:jakarta-oro-2_0_8_orbeon:jar:dev-3.7.1.200905272119",
"orbeon:jakarta-poi-1.11.0-dev-20030610:jar:dev-3.7.1.200905272119",
"orbeon:jakarta-slide-webdavlib-2.0rc1:jar:dev-3.7.1.200905272119",
"orbeon:jaxen-1_1_beta_9:jar:dev-3.7.1.200905272119",
"orbeon:jcommon-1.0.12:jar:dev-3.7.1.200905272119",
"orbeon:jfreechart-1.0.9:jar:dev-3.7.1.200905272119",
"orbeon:jms-api-1_1:jar:dev-3.7.1.200905272119",
"orbeon:joost-20030623_orbeon:jar:dev-3.7.1.200905272119",
"orbeon:jtidy-8.0-20060801.131059-3:jar:dev-3.7.1.200905272119",
"orbeon:junit:jar:dev-3.7.1.200905272119",
"orbeon:log4j-1_2_15:jar:dev-3.7.1.200905272119",
"orbeon:mail-1_3_2:jar:dev-3.7.1.200905272119",
"orbeon:metadata-extractor-2_1:jar:dev-3.7.1.200905272119",
"orbeon:msv-20081113_orbeon_20081209:jar:dev-3.7.1.200905272119",
"orbeon:msv-isorelax-20070407:jar:dev-3.7.1.200905272119",
"orbeon:msv-relaxngDatatype-20070407:jar:dev-3.7.1.200905272119",
"orbeon:msv-xsdlib-20070407:jar:dev-3.7.1.200905272119",
"orbeon:orbeon-form-builder:jar:dev-3.7.1.200905272119",
"orbeon:orbeon-form-runner:jar:dev-3.7.1.200905272119",
"orbeon:orbeon-resources-private:jar:dev-3.7.1.200905272119",
"orbeon:orbeon-resources-public:jar:dev-3.7.1.200905272119",
"orbeon:orbeon-xforms-filter:jar:dev-3.7.1.200905272119",
"orbeon:orbeon:jar:dev-3.7.1.200905272119",
"orbeon:pdfbox-0_7_1:jar:dev-3.7.1.200905272119",
"orbeon:saxon-8_8_orbeon_20080516:jar:dev-3.7.1.200905272119",
"orbeon:saxpath-dev_orbeon:jar:dev-3.7.1.200905272119",
"orbeon:tagsoup-1.2:jar:dev-3.7.1.200905272119",
"orbeon:xalan-2_5_1_orbeon:jar:dev-3.7.1.200905272119",
"orbeon:xerces-resolver-2_9_orbeon_20070711:jar:dev-3.7.1.200905272119",
"orbeon:xerces-serializer-2_9_orbeon_20070711:jar:dev-3.7.1.200905272119",
"orbeon:xerces-xml-apis-2_9_orbeon_20070711:jar:dev-3.7.1.200905272119",
"orbeon:xmlgraphics-commons-1_1:jar:dev-3.7.1.200905272119",
"orbeon:xsltc-2_5_1_orbeon:jar:dev-3.7.1.200905272119",
# private orbeon folder
"orbeon:commons-logging-1_0_4:jar:dev-3.7.1.200905272119",
"orbeon:xerces-xercesImpl-2_9_orbeon_20070711:jar:dev-3.7.1.200905272119"
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