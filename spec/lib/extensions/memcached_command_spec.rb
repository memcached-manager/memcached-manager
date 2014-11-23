require 'spec_helper'

describe Sinatra::MemcachedCommand do
  let(:host) { ENV['MEMCACHED_1_PORT_11211_TCP_ADDR'] || 'localhost' }
  let(:port) { '11211' }
  let(:memcached_connection) { Dalli::Client.new("#{host}:#{port}") }
  let(:klass) { Class.new.extend(Sinatra::MemcachedCommand) }

  it 'runs a command in memcached' do
    memcached_connection.set('hello', 'world')
    expect(klass.memcached_command(host: host, port: port, command: 'get hello')[:response]).to match /world/
  end
end
