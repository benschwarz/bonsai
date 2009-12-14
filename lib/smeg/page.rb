module Smeg
  class Page    
    class NotFound < StandardError; end;
    class PropertyNotFound < StandardError; end
    
    class << self
      @@pages = {}
      
      def path; @@path; end
      def path=(path)
        Smeg.log.info "Reading content from #{path}/content"
        @@path = path
      end
      
      def all(dir_path = path, pattern = "*/**")
        @@pages[dir_path + pattern] ||= Dir["#{dir_path}/#{pattern}/*.yml"].map {|p| 
          Page.new p
        }
      end
      
      def find(permalink)
        search_path = permalink.gsub("/", "/*")
        disk_path = Dir["#{path}/*#{search_path}/*.yml"]
        if disk_path.any?
          new disk_path.first
        else
          raise NotFound, "page '#{permalink}' not found at '#{path}'"
        end
      end
      
    end
    
    attr_reader :disk_path
    
    def initialize(path); @disk_path = path; end
    def slug; @slug ||= permalink.split('/').pop; end
    
    def name
      slug.gsub(/\W/, " ").gsub(/\d\./, '').gsub(/^\w/){$&.upcase}
    end
    
    def permalink
      web_path(directory)
    end
    
    def write_path
      "#{permalink}/index.html"
    end
    
    def template
      @template ||= Template.find(template_name)
    end
    
    def images
      @images ||= Dir["#{directory}/images/*.{jpg,gif,png}"].map do |p| 
        {
          :name       => File.basename(p),
          :path       => web_path(p),
          :disk_path  => p
        }
      end
    end
    
    # This method is used for the exporter to copy assets
    def assets
      @assets ||= Dir["#{directory}/**/*"].select{|p| !File.directory?(p) && !File.basename(p).include?("yml") }.map do |a|
        {
          :name       => File.basename(a),
          :path       => web_path(a),
          :disk_path  => a
        }
      end
    end
    
    def parent
      id = permalink[/^\/(.+)\/[^\/]*$/, 1]
      return nil if id.nil?
      
      parent = Page.find(id)
      return nil if parent == self
      
      parent
    end
    
    def siblings
      self.class.all(File.dirname(disk_path[/(.+)\/[^\/]*$/, 1]), "*")
    end
    
    def children
      self.class.all(File.dirname(disk_path), "*") - [self]
    end
    
    def ancestors
      ancestors = []
      # Remove leading slash
      page_ref = permalink.gsub(/^\//, '')
      
      # Find pages up the permalink tree if possible
      while(page_ref) do
        page_ref = page_ref[/(.+)\/[^\/]*$/, 1]
        ancestors << self.class.find(page_ref) rescue nil
      end
      
      ancestors.compact.reverse
    end
    
    def ==(other)
      self.permalink == other.permalink
    end
    
    def render
      PagePresenter.new(self).render
    rescue => stack
      raise "Issue rendering #{permalink}\n\n#{stack}"
    end
    
    def _content
      YAML::load(File.read(@disk_path)) || {}
    rescue ArgumentError
      Smeg.log.error "Page '#{permalink}' has badly formatted content"
    end
    
    def to_hash
      {
        :parent     => parent.nil? ? nil : parent.to_shallow_hash,
        :children   => children.map{|p| p.to_hash },
        :siblings   => siblings.map{|p| p.to_shallow_hash },
        :assets     => assets
      }.merge(to_shallow_hash)
    end
    
    def to_shallow_hash
      {
        :permalink  => permalink,
        :slug       => slug,
        :name       => name,
        :images     => images
      }.merge(_content)
    end
    
    private
    def directory
      @disk_path.split("/")[0..-2].join("/")
    end
    
    def template_name
      File.basename(@disk_path, '.*')
    end
    
    def web_path(path)
      path.gsub(self.class.path, '').gsub(/\/\d+\./, '/')
    end
  end
end