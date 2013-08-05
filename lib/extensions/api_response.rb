module Sinatra
  module APIResponse
    # This makes the api very DRY by taking care of API errors and converting the object
    # or value passed by the block to json.
    def api_response(&block)
      if errors.any?
        { errors: errors }.to_json
      else
        block.call.tap {|response| response.to_json }
      end
    end
  end
end
