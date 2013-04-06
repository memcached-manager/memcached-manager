module Sinatra
  module MemcachedSettings
    def memcached_host session
      if configured? session
        session['host']
      else
        'localhost'
      end
    end

    def memcached_port session
      if configured? session
        session['port']
      else
        '11211'
      end
    end

    private
    def configured? session
      session.key?('host') || session.key?('port')
    end
  end

  module Errors
    def setup_errors
      @errors = []
    end

    def try(&block)
      begin
        yield
      rescue Exception => e
        @errors << e.message
      end
    end

    def errors
      @errors
    end
  end

  helpers Errors
  helpers MemcachedSettings
end
