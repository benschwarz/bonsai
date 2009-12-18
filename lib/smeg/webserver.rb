module Smeg
  class StaticPassThrough < Rack::Static
    def call(env)
      result = super
      return result unless result[0] == 404 || result[0] == "404"
      @app.call(env)
    end
  end
  
  class DevelopmentServer < Sinatra::Base
    get '/' do
      Page.find("index").render
    end
    
    get '/*' do
      Page.find(params[:splat].to_s).render
    end
  end
end
