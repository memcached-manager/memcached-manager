module Sinatra
  module MemcachedSettings
    def memcached_host session
      return session['host'] if configured? session, 'host'
      ENV['memcached_host'] || 'localhost'
    end

    def memcached_port session
      return session['port'] if configured? session, 'port'
      ENV['memcached_port'] || '11211'
    end

    private
    def configured? session, parameter
      session.key?(parameter)
    end
  end
end
