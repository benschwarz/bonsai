require 'rubygems'
require 'yaml'
require 'mustache'
require 'fileutils'
require 'logger'
require 'sinatra'
require 'less'

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
end

Dir["#{File.dirname(__FILE__)}/bonsai/*.rb"].each {|f| require f }