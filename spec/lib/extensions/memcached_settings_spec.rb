require 'spec_helper'

describe Sinatra::MemcachedSettings do
  let(:configured_session) do
    { 'host' => 'i.am', 'port' => '1337' }
  end

  let(:empty_session) do
    {}
  end

  before(:each) do
    @klass = Class.new.extend(Sinatra::MemcachedSettings)
  end

  context '#memcached_host' do
    it "host exists" do
      @klass.memcached_host(configured_session).should eql 'i.am'
    end

    it "host doesn't exist" do
      @klass.memcached_host(empty_session).should eql 'localhost'
    end
  end

  context '#memcached_port' do
    it "port exists" do
      @klass.memcached_port(configured_session).should eql '1337'
    end

    it "port doesn't exist" do
      @klass.memcached_port(empty_session).should eql '11211'
    end
  end
end
