require 'rubygems'
require 'yaml'
require 'mustache'
require 'fileutils'
require 'logger'
require 'sinatra'

module Smeg
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
    #   Smeg.log.info "message"
    #   Smeg.log.debug "message"
    #   Smeg.log.error "message"
    #   Smeg.log.warn "message"
    def log
      @@log ||= Logger.new(config[:enable_logging] ? $stdout : "/dev/null")
    end
  
    def config
      @@config 
    end
  
    def configure(&block)
      yield @@config
    end
  end
end

Dir["#{File.dirname(__FILE__)}/smeg/*.rb"].each {|f| require f }