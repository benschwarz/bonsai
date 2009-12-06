module Smeg
  class PagePresenter < Mustache
    def initialize(page)
      @page = page
      self.template = @page.template.read
    end
        
    def navigation
      Smeg::Navigation.tree.map{|p| p.to_shallow_hash }
    end
    
    def children
      @page.children.map{|p| p.to_hash }
    end
    
    def siblings
      @page.siblings.map{|p| p.to_shallow_hash }
    end
    
    def parent
      @page.parent.nil? ? nil : @page.parent.to_shallow_hash
    end

    # Catch lookups to the template for variables
    def [](message)
      Smeg.log.debug("catching #{message} sent to []")
      @page.send(message)
    end

    # Catch anything that wasn't picked up by local methods
    def method_missing(message, *args, &block)
      Smeg.log.debug("catching #{message} sent to method_missing")
      
      return @page.send(message) 

      #map_to_disk(message) || super
    end
    
    private
    def map_to_disk(path)
      Dir.glob("#{File.dirname(@page.disk_path)}/#{path}/*").map do |path|
        {
          :name       => File.basename(path),
          :path       => @page.send(:web_path, path),
          :disk_path  => path
        }
      end
    end
  end
end