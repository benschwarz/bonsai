module Bonsai
  class Generate  
    def initialize(path)
      @path = path
    
      Bonsai.log "Planting your bonsai '#{path}'"
      copy_templates
      create_directories
    end
  
    private  
    def create_directories
      %w(content content/index public/docs/css public/docs/js).each do |dir|
        Bonsai.log "\tcreate\t#{dir}"
        FileUtils.mkdir_p(File.join(@path, dir))
      end
    end
  
    def copy_templates
      # Using system call because fileutils is inadequate
      system("cp -fR '#{File.expand_path("#{File.dirname(__FILE__)}/templates")}' '#{@path}'")
    end
  end
end