require "buildr"
require "install.rb"

# Keep this structure to allow the build system to update version numbers.
VERSION_NUMBER = "6.0.0.55-SNAPSHOT"

desc "XForms Manager"
define "xforms-manager" do
  project.version = VERSION_NUMBER
  project.group = "org.intalio.tempo"
  
  compile.options.source = "1.5"
  compile.options.target = "1.5"

  compile.with [ORBEON_LIBS,SERVLET_API]
  resources.filter.using "version" => VERSION_NUMBER
  package :war
end
