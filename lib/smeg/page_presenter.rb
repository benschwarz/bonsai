module Smeg
  class PagePresenter < Hash
    def initialize(page)
      @page = page 
    end

    %w(name slug permalink images assets).each do |m|
      define_method m do
        @page.send(m)
      end
    end
    
    def navigation
      Smeg::Navigation.tree.map{|p| p.to_hash }
    end
    
    def children
      @page.children.map{|p| p.to_shallow_hash }
    end
    
    def siblings
      @page.siblings.map{|p| p.to_shallow_hash }
    end
    
    def parent
      @page.parent.nil? ? nil : @page.parent.to_shallow_hash
    end
    
    def [](name)
      send(name)
    end
    
    def method_missing(message, *args, &block)
      map_to_disk(message) || nil
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