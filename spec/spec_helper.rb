$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'smeg'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  Smeg.configure {|config| config[:enable_logging] = false }
  
  SMEG_PATH = "#{File.dirname(__FILE__)}/support" unless defined? SMEG_PATH
  Smeg.root_dir = SMEG_PATH
end


