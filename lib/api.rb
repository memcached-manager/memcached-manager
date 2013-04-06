# Sinatra
require 'sinatra/base'
require 'sinatra/contrib'
require 'json'

# Libs
require 'dalli'
require 'net/telnet'

# Project files
require_relative './extensions'

def try(&block)
  begin
    yield
  rescue Exception => e
    @errors << e.message
  end
end

module MemcachedManager
  class API < Sinatra::Base
    enable :inline_templates
    enable :sessions
    
    set :public_folder, 'public'

    helpers Sinatra::MemcachedSettings
    helpers Sinatra::MemcachedConnection
    helpers Sinatra::Errors

    before do
      setup_errors

      try do
        setup_memcached(memcached_host(session), memcached_port(session))
      end
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
      { success: true }.to_json
    end

    post '/keys.json' do
      content_type :json

      try { @memcached.set(params[:key], params[:value]) }

      { errors: errors }.to_json
    end

    put '/keys.json' do
      content_type :json

      { updated: @memcached.replace(params[:key], params[:value]) }.to_json
    end

    get '/keys.json' do
      content_type :json

      # should extract this somewhere... lol. Got it from a gist
      @keys = []
      @memcached_data = { :host => memcached_host(session), :port => memcached_port(session), :timeout => 3 }
      @cache_dump_limit = 100
      @data = []

      localhost = Net::Telnet::new("Host" => @memcached_data[:host], "Port" => @memcached_data[:port], "Timeout" => @memcached_data[:timeout])
      slab_ids = []
      localhost.cmd("String" => "stats items", "Match" => /^END/) do |c|
        matches = c.scan(/STAT items:(\d+):/)
        slab_ids = matches.flatten.uniq
      end

      slab_ids.each do |slab_id|
        localhost.cmd("String" => "stats cachedump #{slab_id} #{@cache_dump_limit}", "Match" => /^END/) do |c|
          matches = c.scan(/^ITEM (.+?) \[(\d+) b; (\d+) s\]$/).each do |key_data|
            (cache_key, bytes, expires_time) = key_data
            humanized_expires_time = Time.at(expires_time.to_i).to_s
            expired = false
            expired = true if Time.at(expires_time.to_i) < Time.now
            @keys << { key: cache_key, bytes: bytes, expires_at: humanized_expires_time, expired: expired }
          end
        end  
      end

      @keys.to_json
    end

    get '/keys/:key.json' do
      content_type :json
      value = @memcached.get(params[:key])

      if value.nil?
        { error: 'key not found'}.to_json
      else
        { key: params[:key], value: value }.to_json
      end
    end

    delete '/keys/:key.json' do
      content_type :json

      { deleted: @memcached.delete(params[:key]) }.to_json
    end
  end


  class Webapp < Sinatra::Base
  end
end
