require 'mustache'

module Bonsai
  class PagePresenter < Mustache
    attr_reader :page
    
    def initialize(page)
      @page = page
            
      self.class.path = page.template.class.path + "/partials"
      self.template = page.template.read
    end
        
    def navigation
      Bonsai::Navigation.tree
    end
    
    # Catch anything that wasn't picked up by local methods
    def method_missing(message, *args, &block)
      return page.to_hash[message] if page.to_hash.has_key? message
    end
    
    # Hack to make the PagePresenter class believe that it really
    # can respond to the method regardless of weather it really can.
    # method_missing picks up the peices and will return a nil result
    # if nothing can be found.
    def respond_to?(message)
      true
    end
  end
end