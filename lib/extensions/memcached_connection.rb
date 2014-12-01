module Sinatra
  module MemcachedConnection
    def setup_memcached host, port
      @memcached = Dalli::Client.new("#{host}:#{port}")
    end

    def close_memcached
      @memcached.close
    end

    def memcached_connected? host, port
      begin
        Net::Telnet::new("Host" => host, "Port" => port)
      rescue Errno::ECONNREFUSED
        return false
      end
      true
    end

    def memcached_connection
      @memcached
    end
  end
end
