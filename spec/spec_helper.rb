$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'smeg'
require 'spec'
require 'spec/autorun'
require 'fakefs/safe'

Spec::Runner.configure do |config|
  SPEC_CONTENT_PATH = "#{File.dirname(__FILE__)}/support/content" unless defined? SPEC_CONTENT_PATH
  Smeg::Page.path = SPEC_CONTENT_PATH
  
  SPEC_TEMPLATE_PATH = "#{File.dirname(__FILE__)}/support/templates" unless defined? SPEC_TEMPLATE_PATH
  Smeg::Template.path = SPEC_TEMPLATE_PATH
  
  SPEC_EXPORTER_PATH = "#{File.dirname(__FILE__)}/tmp" unless defined? SPEC_EXPORTER_PATH
  Smeg::Exporter.path = SPEC_EXPORTER_PATH
end

Smeg.configure do |c|
  c[:enable_logging] = false
end