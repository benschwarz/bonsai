$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'smeg'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  SPEC_CONTENT_PATH = "#{File.dirname(__FILE__)}/support/content"
  Smeg::Page.path = SPEC_CONTENT_PATH
  
  SPEC_TEMPLATE_PATH = "#{File.dirname(__FILE__)}/support/templates"
  Smeg::Template.path = SPEC_TEMPLATE_PATH
  
  OUTPUT_PATH = "#{File.dirname(__FILE__)}/tmp"
  Smeg::Renderer.path = OUTPUT_PATH
end
