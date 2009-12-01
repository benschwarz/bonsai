module Smeg
  class Page
    @@path = "content"
    
    class NotFound < StandardError; end;
    class PropertyNotFound < StandardError; end
    
    class << self
      def path; @@path; end
      def path=(path); @@path = path; end
      
      def all(dir_path = path)
        Dir["#{dir_path}/**/*.yml"].map do |p|
          Page.new(p) if(File.file?(p))
        end
      end
      
      def index
        @@index ||= new("#{path}/index/*.yml")
      end
      
      def find(permalink)
        disk_path = Dir["#{path}/*#{permalink}/*.yml"]
        if disk_path.any?
          new disk_path.first
        else
          raise NotFound, "page '#{permalink}' not found"
        end
      end
    end
    
    def initialize(path); @disk_path = path; end
    def slug; @slug ||= permalink.split('/').pop; end
    
    def permalink
      web_path(directory)
    end
    
    def write_path
      "#{permalink}/index.html"
    end
    
    def template
      template_path = File.basename(@disk_path, '.*')
      @template ||= Template.find(template_path)
    end
    
    def images
      Dir["#{directory}/*.{jpg,gif,png}"].map do |p| 
        {
          :name => File.basename(p),
          :path => web_path(p)
        }
      end
    end
    
    def parent
      parent = Page.find(permalink[/^\/(.+)\/[^\/]*$/, 1])
      (parent == self) ? nil : parent
    end
    
    def siblings
      parent.children - [self]
    end
    
    def children
      # raise self.class.path + permalink
      Page.all(self.class.path + permalink)
    end
    
    def ancestors
      top = permalink.split('/')[0]
      if top != permalink
        #Page.all(top)
      else
        nil
      end
    end
    
    def ==(other)
      self.permalink == other.permalink
    end
    
    def render
      Mustache.render(template.read, present!)
    end
    
    def content
      @content ||= YAML::load(File.read(@disk_path)) || {}
    rescue ArgumentError
      Smeg.log.error "Page '#{permalink}' has badly formatted content"
    end
    
    def directory
      @disk_path.split("/")[0..-2].join("/")
    end
    
    private
    def present!
      content.merge({
        :images => images,
        :parent => parent,
        :siblings => siblings,
        :children => children,
        :ancestors => ancestors
      })
    end
    
    def web_path(path)
      path.gsub(self.class.path, '').gsub(/^\/\d\./, '/')
    end
  end
end