# require 'rack/bug'
# require 'rack/bug/panels/mustache_panel'
# use Rack::Bug::MustachePanel
# use Rack::Bug

module Smeg
  class DevelopmentServer < Sinatra::Base
    get '/' do
      @page = Page.find("index")
      @page.render
    end
    
    get '/*' do
      Page.find(params[:splat].to_s).render
    end
  end
end
