module Sinatra
  module MemcachedConnection
    def setup_memcached host, port
      @memcached = Dalli::Client.new("#{host}:#{port}")
    end

    def close_memcached
      @memcached.close
    end

    def memcached_connection
      @memcached
    end
  end
end
