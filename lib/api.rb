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
    enable :cookies

    set :public_folder, 'public'

    helpers Sinatra::Cookies
    helpers Sinatra::MemcachedSettings
    helpers Sinatra::MemcachedConnection
    helpers Sinatra::MemcachedCommand
    helpers Sinatra::MemcachedInspector
    helpers Sinatra::Errors
    helpers Sinatra::APIResponse

    before do
      content_type :json

      setup_errors

      try { setup_memcached(memcached_host(cookies), memcached_port(cookies)) }
    end

    after do
      close_memcached
    end

    get '/status.json' do
      api_response { { connected: memcached_connected?(memcached_host(cookies), memcached_port(cookies)) } }
    end

    get '/config.json' do
      api_response { { host: memcached_host(cookies), port: memcached_port(cookies) } }
    end

    post '/config.json' do
      response.set_cookie(:host, :value => params['host'], :path => '/')
      response.set_cookie(:port, :value => params['port'], :path => '/')

      api_response { { host: memcached_host(cookies), port: memcached_port(cookies) } }
    end

    post '/run.json' do
      api_response do
        memcached_command(host: memcached_host(cookies), port: memcached_port(cookies), command: params[:command])
      end
    end

    [:post, :put].each do |method|
      send(method, '/keys.json') do
        try { memcached_connection.set(params[:key], params[:value]) }

        api_response { memcached_inspect(host: memcached_host(cookies), port: memcached_port(cookies), key: params[:key]) }
      end
    end

    get '/keys.json' do
      pairs = memcached_inspect(host: memcached_host(cookies), port: memcached_port(cookies), query: params[:query], limit: params[:limit])

      # Removing all expired keys
      pairs.select! {|pair| !memcached_connection.get(pair[:key]).nil? }

      api_response do
        pairs
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
