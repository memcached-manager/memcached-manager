module Sinatra
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
end
