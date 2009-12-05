module Smeg
  class Page    
    class NotFound < StandardError; end;
    class PropertyNotFound < StandardError; end
    
    class << self
      def path; @@path; end
      def path=(path)
        Smeg::log.info "Reading content from #{path}/content"
        @@path = path
      end
      
      def all(dir_path = path, pattern = "*/**")
        Dir["#{dir_path}/#{pattern}/*.yml"].map do |p|
          Page.new(p) if(File.file?(p))
        end
      end
      
      def find(permalink)
        disk_path = Dir["#{path}/*#{permalink}/*.yml"]
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
      template_path = File.basename(@disk_path, '.*')
      @template ||= Template.find(template_path)
    end
    
    def images
      Dir["#{directory}/images/*.{jpg,gif,png}"].map do |p| 
        {
          :name       => File.basename(p),
          :path       => web_path(p),
          :disk_path  => p
        }
      end
    end
    
    def thumbs
      Dir["#{directory}/thumbs/*.{jpg,gif,png}"].map do |p| 
        {
          :name       => File.basename(p),
          :path       => web_path(p),
          :disk_path  => p
        }
      end
    end
    
    def logos
      Dir["#{directory}/logos/*.{jpg,gif,png}"].map do |p| 
        {
          :name       => File.basename(p),
          :path       => web_path(p),
          :disk_path  => p
        }
      end
    end
    
    def assets
      Dir["#{directory}/**/*"].select{|p| !File.directory?(p) && !File.basename(p).include?("yml") }.map do |a|
        {
          :name       => File.basename(a),
          :path       => web_path(a),
          :disk_path  => a
        }
      end
    end
    
    def parent
      id = permalink[/^\/(.+)\/[^\/]*$/, 1]

      parent = Page.find(id)
      if id.nil? or parent == self
        nil
      else 
        parent
      end
    end
    
    def siblings
      Page.all(File.dirname(disk_path[/(.+)\/[^\/]*$/, 1]), "*")
    end
    
    def children
      Page.all(File.dirname(disk_path), "*") - [self]
    end
    
    def ancestors
      ancestors = []
      while(parent.disk_path != self.class.path) do
        ancestors << parent
        parent = parent.parent
        break if parent.nil?
      end

      ancestors
    end
    
    def ==(other)
      self.permalink == other.permalink
    end
    
    def render
      Mustache.render(template.read, present!)
    rescue => stack
      raise "Issue rendering #{self.name}\n\n#{stack}"
    end
    
    def content
      @content ||= YAML::load(File.read(@disk_path)) || {}
    rescue ArgumentError
      Smeg.log.error "Page '#{permalink}' has badly formatted content"
    end
    
    def directory
      @disk_path.split("/")[0..-2].join("/")
    end
    
    def to_hash
      {
        :parent     => parent.nil? ? nil : parent.to_shallow_hash,
        :children   => children.map{|p| p.to_hash },
        :siblings   => siblings.map{|p| p.to_shallow_hash }
      }.merge(to_shallow_hash)
    end
    
    def to_shallow_hash
      {
        :permalink  => permalink,
        :slug       => slug,
        :name       => name,
        :images     => images,
        :thumbs     => thumbs,
        :assets     => assets
      }.merge(content)
    end
    
    private
    def present!
      to_hash.merge({
        :navigation => Smeg::Navigation.tree.map{|p| p.to_shallow_hash }
      })
    end
    
    def web_path(path)
      path.gsub(self.class.path, '').gsub(/^\/\d\./, '/')
    end
  end
end