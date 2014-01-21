require 'rubygems'
require 'fileutils'
require 'logger'
require 'active_support/core_ext/hash/keys'

$LOAD_PATH << "#{File.dirname(__FILE__)}/bonsai"

require 'version'

module Bonsai
  class << self
    attr_accessor :root_dir, :config

    def root_dir=(path)
      unless is_a_bonsai?(path)
        log "no bonsai site found - are you in the right directory?"
        exit 0
      end

      @root_dir = path

      init
    end

    def log(message)
      puts message if config[:enable_logging]
    end

    def config
      @config || { :enable_logging => true }
    end

    def site
      YAML::load(File.read("#{@root_dir}/site.yml")) || {}
    rescue ArgumentError, Psych::SyntaxError
      Bonsai.log "Badly formatted site.yml"
    end

    private
    def init
      set_paths
      load_extensions
    end

    def set_paths
      Exporter.path = "#{@root_dir}/output"
      Page.path = "#{@root_dir}/content"
      Template.path = "#{@root_dir}/templates"
      Liquid::Template.file_system = Liquid::LocalFileSystem.new(Template.path)
    end

    def load_extensions
      extension_path = "#{@root_dir}/extensions.rb"

      if File.exists?(extension_path)
        require File.expand_path(extension_path)
      end
    end

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
  autoload :StaticPassThrough,  "webserver"
  autoload :DevelopmentServer,  "webserver"
end