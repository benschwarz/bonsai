module Bonsai
  class Generate  
    def initialize(path)
      @path = path
    
      Bonsai.log "Planting your bonsai '#{path}'"
      create_directories
      copy_templates
    end
  
    private
    def templates
      File.expand_path("#{File.dirname(__FILE__)}/templates")
    end
  
    def create_directories
      %w(content content/index public/docs/css public/docs/js templates/partials).each do |dir|
        Bonsai.log "\tcreate\t#{dir}"
        FileUtils.mkdir_p(File.join(@path, dir))
      end
    end
  
    def copy_templates
      FileUtils.cp("#{templates}/base.less", File.join(@path, "public", "docs", "css"))
      FileUtils.cp("#{templates}/.htaccess", File.join(@path, "public"))
      FileUtils.cp("#{templates}/default.yml", File.join(@path, "content", "index"))
      FileUtils.cp("#{templates}/default.mustache", File.join(@path, "templates"))
    end
  end
end