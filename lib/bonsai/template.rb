module Bonsai
  class Template    
    class NotFound < StandardError; end
    
    # Class methods
    class << self
      attr_accessor :path

      def path
        @path || "templates"
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
    
    # Instance methods
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
  end
end