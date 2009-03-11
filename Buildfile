require "buildr"

# Keep this structure to allow the build system to update version numbers.
VERSION_NUMBER = "6.0.0.39-SNAPSHOT"

repositories.remote = [ 
  "http://www.intalio.org/public/maven2", 
  "http://repo1.maven.org/maven2",
  "http://people.apache.org/repo/m2-ibiblio-rsync-repository/"
]

repositories.release_to[:username] ||= "release"
repositories.release_to[:url] ||= "sftp://www.intalio.org/var/www-org/public/maven2"
repositories.release_to[:permissions] ||= 0664

ORBEON_CORE = [
  group("orbeon", "orbeon-xforms-filter", "orbeon-resources-public", "orbeon-resources-private", :under=>"orbeon", :version=>"3.7.0beta1.200811030320")
]
#3.7.0beta1.200902241728

APACHE_COMMONS = {
  :beanutils => "commons-beanutils:commons-beanutils:jar:1.7.0",
  :cli => "commons-cli:commons-cli:jar:1.1",
  :codec => "commons-codec:commons-codec:jar:1.3",
  :collections => "commons-collections:commons-collections:jar:3.2", 
  :digester => "commons-digester:commons-digester:jar:1.7",
  :discovery => "commons-discovery:commons-discovery:jar:0.2",
  :fileupload => "commons-fileupload:commons-fileupload:jar:1.2.1",
  :httpclient => "commons-httpclient:commons-httpclient:jar:3.1",
  :io => "commons-io:commons-io:jar:1.2",
  :lang => "commons-lang:commons-lang:jar:2.3",
  :pool => "commons-pool:commons-pool:jar:1.4",
  :validator => "commons-validator:commons-validator:jar:1.2.0"
}

ORBEON_COMMONS = [
  APACHE_COMMONS[:beanutils],
  APACHE_COMMONS[:cli],
  APACHE_COMMONS[:codec],
  APACHE_COMMONS[:collections],
  APACHE_COMMONS[:digester],
  APACHE_COMMONS[:discovery],
  APACHE_COMMONS[:fileupload],
  APACHE_COMMONS[:httpclient],
  APACHE_COMMONS[:io],
  APACHE_COMMONS[:lang],
  APACHE_COMMONS[:pool],
  APACHE_COMMONS[:validator],
]

ORBEON_MSV = [
  group("msv", "isorelax", "relaxng-datatype","xsdlib", :under => "msv", :version => "20070407")
]

ORBEON_AXIS = [
  "orbeon:axis-orbeon:jar:1.2.1",
  "orbeon:axis-jaxrpc:jar:1.2.1",
  "orbeon:axis-saaj:jar:1.2.1",
  "orbeon:axis-wsdl4j:jar:1.2.1-1.5.1"
]

ORBEON_XERCES = [
  group("xerces-resolver", "xerces-serializer", "xerces-xml-apis", "xerces-xercesImpl", :under => "orbeon" , :version => "2_9_orbeon_20070711")
]

ORBEON_CUSTOM = [
  ORBEON_XERCES,
  "orbeon:jakarta-oro-orbeon:jar:2.0.8",
  "orbeon:saxpath:jar:dev_orbeon",
  "orbeon:xsltc-orbeon:jar:2.5.1",
  "orbeon:xalan-orbeon:jar:2.5.1",
  "orbeon:castor-xml:jar:0.9.4.3",
  "orbeon:metadata-extractor:jar:2.1",
  "orbeon:saxon-8_8_orbeon:jar:20080516"
]

JAVAMAIL = "geronimo-spec:geronimo-spec-javamail:jar:1.3.1-rc5", "geronimo-spec:geronimo-spec-activation:jar:1.0.2-rc4"
DOM4J = "dom4j:dom4j:jar:1.6.1"
GERONIMO_SPECS = {
  "jta" => "org.apache.geronimo.specs:geronimo-jta_1.1_spec:jar:1.1",
  "jpa" => "org.apache.geronimo.specs:geronimo-jpa_3.0_spec:jar:1.0",
  "jms" => "org.apache.geronimo.specs:geronimo-jms_1.1_spec:jar:1.0.1"
}
JAXEN = "jaxen:jaxen:jar:1.1.1"

ORBEON_LIBS_NO_JAXEN = [
  JAVAMAIL,
  ORBEON_AXIS,
  ORBEON_COMMONS,
  ORBEON_MSV,
  ORBEON_CORE,
  ORBEON_CUSTOM,
  DOM4J,
  GERONIMO_SPECS["jms"],
  "jtidy:jtidy:jar:8.0-20060801.131059-3",
  "batik:batik-all:jar:1.6"
]

ORBEON_LIBS = [
  ORBEON_LIBS_NO_JAXEN,
  JAXEN
  # "orbeon:jaxen:jar:1.1-beta-1-dev",  
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