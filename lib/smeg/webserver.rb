# require 'rack/bug'
# require 'rack/bug/panels/mustache_panel'
# use Rack::Bug::MustachePanel
# use Rack::Bug

module Smeg
  class DevelopmentServer < Sinatra::Base
    set :public, Smeg.root_dir + "/output"
    
    get '/' do
      @page = Page.find("index")
      @page.render
    end
    
    get '/*' do
      Page.find(params[:splat]).render
    end
  end
end
