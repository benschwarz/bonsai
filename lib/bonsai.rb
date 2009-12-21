require 'rubygems'
require 'fileutils'
require 'logger'

$LOAD_PATH << "#{File.dirname(__FILE__)}/bonsai"

module Bonsai
  @@root_dir = nil
  @@config = { :enable_logging => true }

  class << self
    def root_dir
      @@root_dir || Dir.pwd
    end
  
    def root_dir=(path)
      @@root_dir = path
      log "Exporting to #{path}/output"
      
      Exporter.path = "#{path}/output"
      Page.path = "#{path}/content"
      Template.path = "#{path}/templates"
    end
    
    def log(message)
      puts message if @@config[:enable_logging]
    end
  
    def config
      @@config 
    end
  
    def configure(&block)
      yield @@config
    end
    
    def version
      File.read("#{File.dirname(__FILE__)}/../VERSION")
    end
  end
  
  autoload :Page,               "page"
  autoload :Console,            "console"
  autoload :Exporter,           "exporter"
  autoload :Template,           "template"
  autoload :Generate,           "generate"
  autoload :Navigation,         "navigation"
  autoload :PagePresenter,      "page_presenter"
  autoload :StaticPassThrough,  "webserver"
  autoload :DevelopmentServer,  "webserver"
end