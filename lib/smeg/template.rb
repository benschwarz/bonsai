module Smeg
  class Template
    @@path = "templates"
    
    class NotFound < StandardError; end
    
    class << self
      def path; @@path; end
      def path=(path)
        @@path = path
        
        # Set mustache to automagically know where
        # it might find the partials
        Mustache.template_path = path + "/partials"
      end
      
      def find(name)
        disk_path = Dir["#{path}/#{name}.mustache"]
        
        if disk_path.any? 
          new disk_path.first
        else
          raise NotFound, "template '#{name}' not found at #{path}"
        end
      end
    end
    
    def initialize(path)
      @disk_path = path
    end
    
    def read
      File.read(@disk_path)
    end
  end
end