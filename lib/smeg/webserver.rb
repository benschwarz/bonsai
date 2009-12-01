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
