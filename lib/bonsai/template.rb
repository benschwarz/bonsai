module Bonsai
  class Template
    @@path = "templates"
    
    class NotFound < StandardError; end
    
    class << self
      def path; @@path; end
      
      def path=(path)
        @@path = path
      end
      
      def find(name)
        disk_path = Dir["#{path}/#{name}.*"]
        
        if disk_path.any? 
          new disk_path.first
        else
          raise NotFound, "template '#{name}' not found at #{path}"
        end
      end
    end
    
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
  end
end