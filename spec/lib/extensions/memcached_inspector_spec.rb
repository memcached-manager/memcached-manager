require 'spec_helper'

describe Sinatra::MemcachedInspector do
  let!(:host) { ENV['MEMCACHED_1_PORT_11211_TCP_ADDR'] || 'localhost' }
  let!(:port) { '11211' }
  let(:memcached_connection) { Dalli::Client.new("#{host}:#{port}") }
  let(:klass) { Class.new.extend(Sinatra::MemcachedInspector) }

  context "#memcached_inspect" do
    context 'undefined key' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('hello', 'world')
        memcached_connection.set('question', "Who's John Galt?")
      end

      let(:response) { klass.memcached_inspect host: host, port: port }

      it { expect(response).to be_an_instance_of Array }
      it { expect(response.first.keys).to include :key }
      it { expect(response.first.keys).to include :bytes }
      it { expect(response.first.keys).to include :expires_in }
      it { expect(response.first[:key]).to eq 'hello' }
      it { expect(response.first[:expires_in]).to be_an_instance_of Fixnum }
    end

    context 'defined key' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('hello', 'world')
        memcached_connection.set('question', "eho's John Galt?")
        @response = klass.memcached_inspect host: host, port: port, key: 'hello'
      end

      it { expect(@response).to_not be_an_instance_of Array }
      it { expect(@response).to include :key }
      it { expect(@response).to include :bytes }
      it { expect(@response).to include :expires_in }
      it { expect(@response[:key]).to eq 'hello' }
      it { expect(@response[:expires_in]).to be_an_instance_of Fixnum }
    end

    context 'defined query' do
      before(:each) do
        memcached_connection.flush_all
        memcached_connection.set('foo1', 'world')
        memcached_connection.set('foo', 'world')
        memcached_connection.set('xpto', "Who's John Galt?")
        @response = klass.memcached_inspect host: host, port: port, query: 'foo'
      end

      it { expect(@response).to be_an_instance_of Array }
      it { expect(@response.size).to be 2 }
      it { expect(@response.first).to include :key }
      it { expect(@response.first).to include :bytes }
      it { expect(@response.first.keys).to include :expires_in }
      it { expect(@response.first[:key]).to eq 'foo' }
      it { expect(@response.last[:key]).to eq 'foo1' }
      it { expect(@response.first[:expires_in]).to be_an_instance_of Fixnum }
    end
  end
end
