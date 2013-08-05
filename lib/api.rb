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

    before do
      content_type :json

      setup_errors

      try { setup_memcached(memcached_host(session), memcached_port(session)) }
    end

    after do
      close_memcached
    end

    get '/config.json' do
      { host: memcached_host(session), port: memcached_port(session) }.to_json
    end

    post '/config.json' do
      session['host'] = params['host']
      session['port'] = params['port']

      { errors: errors }.to_json
    end

    post '/keys.json' do
      try { memcached_connection.set(params[:key], params[:value]) }

      if errors.any?
        { errors: errors }.to_json
      else
        find_memcached_key(memcached_host(session), memcached_port(session), params[:key]).to_json
      end
    end

    put '/keys.json' do
      try { memcached_connection.replace(params[:key], params[:value]) }

      if errors.any?
        { errors: errors }.to_json
      else
        find_memcached_key(memcached_host(session), memcached_port(session), params[:key]).to_json
      end
    end

    get '/keys.json' do
      memcached_inspect(memcached_host(session), memcached_port(session)).to_json
    end

    get '/keys/:key.json' do
      value = memcached_connection.get(params[:key])

      try { raise 'Key not found.' if value.nil? }

      if errors.any?
        { errors: errors }.to_json
      else
        { key: params[:key], value: value }.to_json
      end
    end

    delete '/keys/:key.json' do
      try { memcached_connection.delete(params[:key]) }

      if errors.any?
        { errors: errors}.to_json
      else
        { key: params[:key] }.to_json
      end
    end

    get '/stats.json' do
      memcached_connection.stats.to_json
    end
  end
end
