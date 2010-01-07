module Bonsai
  class StaticPassThrough < Rack::Static
    def call(env)
      result = super
      return result unless result[0] == 404 || result[0] == "404"
      @app.call(env)
    end
  end
  
  class DevelopmentServer < Sinatra::Base
    set :views, "#{File.dirname(__FILE__)}/webserver"
    
    get '/' do
      Page.find("index").render
    end
    
    get '/*' do
      begin
        Page.find(params[:splat].to_s).render
      rescue Bonsai::Page::NotFound => e
        @error = e
        erb :error
      end
    end
  end
end
