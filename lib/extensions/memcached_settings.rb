module Sinatra
  module MemcachedSettings
    def memcached_host session
      if configured? session, 'host'
        session['host']
      else
        'localhost'
      end
    end

    def memcached_port session
      if configured? session, 'port'
        session['port']
      else
        '11211'
      end
    end

    private
    def configured? session, parameter
      session.key?(parameter)
    end
  end
end
