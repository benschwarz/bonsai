$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'bonsai'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  Bonsai.config = { :enable_logging => false }
  
  BONSAI_PATH = "#{File.dirname(__FILE__)}/support" unless defined? BONSAI_PATH
  Bonsai.root_dir = BONSAI_PATH
end


