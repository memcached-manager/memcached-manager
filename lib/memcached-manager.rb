require 'sinatra/base'
require 'sinatra/contrib'

module MemcachedManager
  class App < Sinatra::Base
    enable :inline_templates
    helpers Sinatra::JSON
    set :json_encoder,      :to_json
    set :json_content_type, :json

    get '/' do
    end
  end
end

MemcachedManager::App.run! if __FILE__ == $0
