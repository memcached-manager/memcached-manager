require 'spec_helper'

describe Sinatra::MemcachedInspector do
  let(:host) { ENV['MEMCACHED_1_PORT_11211_TCP_ADDR'] || 'localhost' }
  let(:port) { '11211' }
  let(:memcached_connection) { Dalli::Client.new("#{host}:#{port}") }
  let(:klass) { Class.new.extend(Sinatra::MemcachedInspector) }

  context "#memcached_inspect" do
    context 'undefined key' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('hello', 'world')
        memcached_connection.set('question', "Who's John Galt?")
        @response = klass.memcached_inspect host: host, port: port
      end

      it { @response.should be_an_instance_of Array }
      it { @response.first.keys.should include :key }
      it { @response.first.keys.should include :bytes }
      it { @response.first.keys.should include :expired }
      it { @response.first[:key].should == 'hello' }
      it { @response.first[:expired].should == true }
    end

    context 'defined key' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('hello', 'world')
        memcached_connection.set('question', "Who's John Galt?")
        @response = klass.memcached_inspect host: host, port: port, key: 'hello'
      end

      it { @response.should_not be_an_instance_of Array }
      it { @response.should include :key }
      it { @response.should include :bytes }
      it { @response.should include :expired }
      it { @response[:key].should == 'hello' }
      it { @response[:expired].should == true }
    end

    context 'defined query' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('foo1', 'world')
        memcached_connection.set('foo', 'world')
        memcached_connection.set('xpto', "Who's John Galt?")
        @response = klass.memcached_inspect host: host, port: port, query: 'foo'
      end

      it { @response.should be_an_instance_of Array }
      it { @response.size.should == 2 }
      it { @response.first.keys.should include :key }
      it { @response.first.keys.should include :bytes }
      it { @response.first.keys.should include :expired }
      it { @response.first[:key].should == 'foo' }
      it { @response.last[:key].should == 'foo1' }
    end
  end
end
