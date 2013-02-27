require 'sinatra/base'
require 'sinatra/contrib'
require 'json'

module MemcachedManager
  class App < Sinatra::Base
    enable :inline_templates

    get '/' do
      content_type :json
      { xpto: 1 }.to_json
    end
  end
end

MemcachedManager::App.run! if __FILE__ == $0
