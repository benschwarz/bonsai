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
      unless is_a_bonsai?(path)
        log "no bonsai site found - are you in the right directory?" 
        exit 0
      end
      
      @@root_dir = path
      
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
    
    def site
      YAML::load(File.read("#{Bonsai.root_dir}/site.yml")) || {}
    rescue ArgumentError
      Bonsai.log "Badly formatted site.yml"
    end
    
    private
    def is_a_bonsai?(path)
      File.directory?("#{path}/content") && File.directory?("#{path}/public") && File.directory?("#{path}/templates")
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