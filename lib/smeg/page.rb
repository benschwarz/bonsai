module Smeg
  class Page
    class NotFound < StandardError; end;
    class PropertyNotFound < StandardError; end
    
    class << self
      def path; @@path || "content"; end
      def path=(path); @@path = path; end
      
      def all
        Dir["#{path}/**/*.yml"].map do |p|
          Page.new(p) if(File.file?(p))
        end
      end
      
      def index
        @@index ||= new("#{path}/index/*.yml")
      end
      
      def find(permalink)
        disk_path = Dir["#{path}/#{permalink}/*.yml"]
        if disk_path.any?
          new disk_path.first
        else
          raise NotFound, "page not found"
        end
      end
    end
    
    def initialize(path)
      @disk_path = path
    end
    
    def permalink
      @permalink ||= @disk_path.gsub(self.class.path, '').split("/")[0..-2].join("/").gsub(/\d\./, '')
    end
    
    def slug
      @slug ||= permalink.split('/').pop
    end
    
    def template
      template_path = File.basename(@disk_path, '.*')
      @template ||= Template.find(template_path)
    end
    
    def method_missing(sym)
      if content.has_key? sym
        content[sym]
      else
        raise PropertyNotFound
      end
    end
    
    private
    def content
      YAML::load(File.read(@disk_path))
    end
  end
end