# Sinatra
require 'sinatra/base'
require 'sinatra/contrib'
require 'json'

module MemcachedManager
  class Webapp < Sinatra::Base
    enable :sessions

    get '/' do
      @engine_path = request.script_name
      erb :index
    end
  end
end
