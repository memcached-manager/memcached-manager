require 'spec_helper'

# For some reason, I can't use let or subject when I'm doing this class new extend 
# thing and call methods from it, so instead I'm just calling it manually

describe Sinatra::APIResponse do
  context "#api_response" do
    it "should have a block given" do
      lambda { Class.new.extend(Sinatra::APIResponse).api_response }.should raise_error('No block given')
    end

    context 'error' do
      it "should respond with the errors" do
        klass = Class.new.extend(Sinatra::APIResponse)
        klass.stubs(:errors).returns([{foo: 'bar'}])
        klass.api_response {{yeah: 'yeahs'}}.should =~ /errors.*foo.*bar/
      end
    end

    context 'no error' do
      it "should respond with what's inside the block" do
        klass = Class.new.extend(Sinatra::APIResponse)
        klass.stubs(:errors).returns([])
        klass.api_response { {foo: 'bar'} }.should =~ /foo.*bar/
      end
    end
  end
end
