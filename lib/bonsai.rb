require 'rubygems'
require 'fileutils'
require 'logger'

$LOAD_PATH << "#{File.dirname(__FILE__)}/bonsai"

module Bonsai
  class << self
    attr_accessor :root_dir, :config
  
    def root_dir=(path)
      unless is_a_bonsai?(path)
        log "no bonsai site found - are you in the right directory?" 
        exit 0
      end
      
      @root_dir = path
      
      Exporter.path = "#{path}/output"
      Page.path = "#{path}/content"
      Template.path = "#{path}/templates"
    end
    
    def log(message)
      puts message if config[:enable_logging]
    end
  
    def config
      @config || { :enable_logging => true }
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
  autoload :Sitemap,            "sitemap"
  autoload :Exporter,           "exporter"
  autoload :Template,           "template"
  autoload :Generate,           "generate"
  autoload :Navigation,         "navigation"
  autoload :PagePresenter,      "page_presenter"
  autoload :StaticPassThrough,  "webserver"
  autoload :DevelopmentServer,  "webserver"
end