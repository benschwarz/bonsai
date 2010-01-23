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
      begin
        Page.find("index").render
      rescue Exception => e
        @error = e
        erb :error
      end
    end

    get '/*' do
      begin
        Page.find(params[:splat].join).render
      rescue Exception => e
        @error = e
        erb :error
      end
    end
  end
end
