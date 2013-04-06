require 'spec_helper'

describe Sinatra::MemcachedConnection do
  before(:each) do
    @klass = Class.new.extend(Sinatra::MemcachedConnection)
  end

  context "#setup_memcached" do
    it "should setup the memcached instance variable" do
      @klass.setup_memcached 'localhost', '1337'
      @klass.instance_variables.should include :"@memcached"
    end
  end

  context "#close_memcached" do
    before(:each) do
      @klass.setup_memcached 'localhost', '1337'
    end

    it do
      # There isn't an Dalli api that tells if the connection is closed
      @klass.respond_to? :close_memcached
    end
  end

  context "#memcached_connection" do
    before(:each) do
      @klass.setup_memcached 'localhost', '1337'
    end

    it "should be the instance variable of memcached" do
      @klass.instance_variable_get(:"@memcached").should be @klass.memcached_connection
    end
  
  end
end
