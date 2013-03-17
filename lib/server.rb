require 'sinatra/base'
require 'sinatra/contrib'
require 'json'
require 'dalli'
require 'net/telnet'

module MemcachedManager
  class App < Sinatra::Base
    enable :inline_templates

    get '/api/keys.json' do
      content_type :json

      # should extract this somewhere... lol. Got it from a gist
      @keys = []
      @memcached_data = { :host => "localhost", :port => 11211, :timeout => 3 }
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

    get '/api/keys/:key.json' do
      content_type :json
      response = Memcached.get(params[:key])

      if response == 'null'
        ''
      else
        {
          key: params[:key],
          value: Memcached.get(params[:key])
        }.to_json
      end
    end
  end
end
Memcached = Dalli::Client.new('localhost:11211')
MemcachedManager::App.run! if __FILE__ == $0
