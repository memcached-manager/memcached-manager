require 'spec_helper'

describe Sinatra::APIResponse do
  subject(:klass) { Class.new.extend(Sinatra::Errors) }

  context "#api_response" do
    context 'error' do

    end

    context 'no error' do
      pending
    end
  end
end
