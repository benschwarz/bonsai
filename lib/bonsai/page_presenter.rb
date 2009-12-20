module Bonsai
  class PagePresenter < Mustache
    attr_reader :page
    
    def initialize(page)
      @page = page
            
      self.class.path = page.template.class.path + "/partials"
      self.template = page.template.read
    end
        
    def navigation
      @navigation ||= Bonsai::Navigation.tree.map{|p| p.to_shallow_hash }
    end
    
    def children
      @children ||= page.children.map{|p| p.to_hash }
    end
    
    def siblings
      @siblings ||= page.siblings.map{|p| p.to_shallow_hash }
    end
    
    def parent
      @parent ||= page.parent.nil? ? nil : @page.parent.to_shallow_hash
    end
    
    # Catch anything that wasn't picked up by local methods
    def method_missing(message, *args, &block)
      return page.send(message) if page.respond_to? message
      return page._content[message] if page._content.has_key? message
      map_to_disk(message)
    end
    
    # Hack to make the PagePresenter class believe that it really
    # can respond to the method regardless of weather it really can.
    # method_missing picks up the peices and will return a nil result
    # if nothing can be found.
    def respond_to?(message)
      true
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