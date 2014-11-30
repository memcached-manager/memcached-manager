require 'spec_helper'

# For some reason, I can't use let or subject when I'm doing this class new extend 
# thing and call methods from it, so instead I'm just calling it manually

describe Sinatra::APIResponse do
  context "#api_response" do
    it "should have a block given" do
      expect { Class.new.extend(Sinatra::APIResponse).api_response }.to raise_error('No block given')
    end

    context 'error' do
      let(:klass) { Class.new.extend(Sinatra::APIResponse) }

      it "should respond with the errors" do
        allow(klass).to receive(:errors).and_return([{foo: 'bar'}])
        expect(klass.api_response {{yeah: 'yeahs'}}).to match /errors.*foo.*bar/
      end
    end

    context 'no error' do
      let(:klass) { Class.new.extend(Sinatra::APIResponse) }

      it "should respond with what's inside the block" do
        allow(klass).to receive(:errors).and_return([])
        expect(klass.api_response { {foo: 'bar'} }).to match /foo.*bar/
      end
    end
  end
end
