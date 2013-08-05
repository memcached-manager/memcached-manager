# Sinatra
require 'sinatra/base'
require 'sinatra/contrib'
require 'json'

# Libs
require 'dalli'
require 'net/telnet'

# Project files
require_relative './extensions'

module MemcachedManager
  class API < Sinatra::Base
    enable :inline_templates
    enable :sessions
    
    set :public_folder, 'public'

    helpers Sinatra::MemcachedSettings
    helpers Sinatra::MemcachedConnection
    helpers Sinatra::MemcachedInspector
    helpers Sinatra::Errors
    helpers Sinatra::APIResponse

    before do
      content_type :json

      setup_errors

      try { setup_memcached(memcached_host(session), memcached_port(session)) }
    end

    after do
      close_memcached
    end

    get '/config.json' do
      api_response { { host: memcached_host(session), port: memcached_port(session) } }
    end

    post '/config.json' do
      session['host'] = params['host']
      session['port'] = params['port']

      api_response { { host: memcached_host(session), port: memcached_port(session) } }
    end

    post '/keys.json' do
      try { memcached_connection.set(params[:key], params[:value]) }

      api_response { memcached_inspect(host: memcached_host(session), port: memcached_port(session), key: params[:key]) }
    end

    put '/keys.json' do
      try { memcached_connection.replace(params[:key], params[:value]) }

      api_response { memcached_inspect(host: memcached_host(session), port: memcached_port(session), key: params[:key]) }
    end

    get '/keys.json' do
      api_response do
        memcached_inspect(host: memcached_host(session), port: memcached_port(session))
      end
    end

    get '/keys/:key.json' do
      value = memcached_connection.get(params[:key])

      try { raise 'Key not found.' if value.nil? }

      api_response { { key: params[:key], value: value } }
    end

    delete '/keys/:key.json' do
      try { memcached_connection.delete(params[:key]) }

      api_response { { key: params[:key] } }
    end

    get '/stats.json' do
      api_response { memcached_connection.stats }
    end
  end
end
