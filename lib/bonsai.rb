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
      log.info "Exporting to #{path}/output"
      
      Exporter.path = "#{path}/output"
      Page.path = "#{path}/content"
      Template.path = "#{path}/templates"
    end
  
    # Log for info, debug, error and warn with:
    # 
    #   Bonsai.log.info "message"
    #   Bonsai.log.debug "message"
    #   Bonsai.log.error "message"
    #   Bonsai.log.warn "message"
    def log
      @@log ||= Logger.new(config[:enable_logging] ? $stdout : "/dev/null")
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