require 'spec_helper'

describe Sinatra::MemcachedInspector do
  let(:host) { 'localhost' }
  let(:port) { '11211' }
  let(:memcached_connection) { Dalli::Client.new("#{host}:#{port}") }
  let(:klass) { Class.new.extend(Sinatra::MemcachedInspector) }

  context "#memcached_inspect" do
    before(:each) do
      memcached_connection.set('hello', 'world')
      memcached_connection.set('question', "Who's John Galt?")
      @response = klass.memcached_inspect host, port
    end

    it { @response.should be_an_instance_of Array }
    it { @response.size.should == 2 }
    it { @response.first.keys.should include :key }
    it { @response.first.keys.should include :bytes }
    it { @response.first.keys.should include :expired }
    it { @response.first[:key].should == 'hello' }
    it { @response.first[:expired].should == true }
  end
end
