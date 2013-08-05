module Sinatra
  module APIResponse
    # This makes the api very DRY by taking care of API errors and converting the object
    # or value passed by the block to json.
    def api_response(&block)
      raise 'No block given' unless block_given?

      if errors.any?
        return { errors: errors }.to_json
      else
        block.call.tap {|response| return response.to_json }
      end
    end
  end
end
