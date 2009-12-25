require 'yaml'
require 'rdiscount'

module Bonsai
  class Page
    class NotFound < StandardError; end;
    class PropertyNotFound < StandardError; end
    @@pages = {}
    
    class << self    
      def path; @@path; end
      def path=(path)
        Bonsai.log "Reading content from #{path}"
        @@path = path
      end
      
      def all(dir_path = path, pattern = "*/**")
        Dir["#{dir_path}/#{pattern}/*.yml"].map {|p| Page.new p }
      end
      
      def find(permalink)        
        @@pages[permalink] ||= find!(permalink)
      end
      
      private
      def find!(permalink)
        search_path = permalink.gsub("/", "/*")
        disk_path = Dir["#{path}/*#{search_path}/*.yml"]
        if disk_path.any?
          return new disk_path.first
        else
          raise NotFound, "page '#{permalink}' not found at '#{path}'"
        end
      end
    end
    
    attr_reader :disk_path
    
    def initialize(path)
      @disk_path = path
    end
    
    def slug
      permalink.split('/').pop
    end
    
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
      Template.find(template_name)
    end
    
    # This method is used for the exporter to copy assets
    def assets
      Dir["#{directory}/**/*"].select{|p| !File.directory?(p) && !File.basename(p).include?("yml") }.map do |a|
        {
          :name       => File.basename(a),
          :path       => web_path(a),
          :disk_path  => a
        }
      end
    end
    
    def floating?
      !!(File.dirname(disk_path) =~ /\/[a-zA-z][\w-]+$/)
    end
    
    def parent
      id = permalink[/^\/(.+)\/[^\/]*$/, 1]
      return nil if id.nil?
      
      parent = Page.find(id)
      return nil if parent == self
      
      parent
    rescue NotFound
      nil
    end
    
    def siblings
      self.class.all(File.dirname(disk_path[/(.+)\/[^\/]*$/, 1]), "*").delete_if{|p| p == self}
    end
    
    def children
      self.class.all(File.dirname(disk_path), "*").delete_if{|p| p.floating? }
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
    
    def content
      YAML::load(File.read(@disk_path)) || {}
    rescue ArgumentError
      Bonsai.log "Page '#{permalink}' has badly formatted content"
    end
    
    # This hash is available to all templates, it will map common properties, 
    # content file results, as well as any "magic" hashes for file 
    # system contents
    def to_hash
      {
        :slug         => slug, 
        :permalink    => permalink, 
        :name         => name, 
        :floating?    => floating?,
        :children     => children.map,
        :siblings     => siblings,
        :parent       => parent, 
        :ancestors    => ancestors
      }.merge(formatted_content).merge(disk_assets)
    end
    
    private
    def formatted_content
      formatted_content = content
      
      formatted_content.each do |k,v|
        if v.is_a?(String) and v =~ /\n/
          formatted_content[k] = RDiscount.new(v, :smart).to_html
        end
      end
      
      formatted_content
    end
    
    # Creates methods for each sub-folder within the page's folder
    # that isn't a sub-page (a page object)
    def disk_assets
      assets = {}
      Dir["#{File.dirname(disk_path)}/**"].select{|p| File.directory?(p)}.reject {|p|
        Dir.entries(p).any?{|e| e.include? "yml"}
      }.each{|asset_path| assets.merge!(map_to_disk(asset_path)) }

      assets
    end
    
    def map_to_disk(path)
      name = File.basename(path)
      
      {
        name.to_sym => Dir["#{path}/*"].map do |file|
          {
            :name       => File.basename(file),
            :path       => web_path(file),
            :disk_path  => file
          }  
        end
      }
    end
    
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