require 'spec_helper'

describe Sinatra::MemcachedSettings do
  let(:configured_session) { { 'host' => 'i.am', 'port' => '1337' } }
  let(:empty_session) { {} }
  let(:klass) { Class.new.extend(Sinatra::MemcachedSettings) }
 
  before :each do
    ENV.stubs(:[]).with("memcached_host").returns(nil)
    ENV.stubs(:[]).with("memcached_port").returns(nil)
  end

  context '#memcached_host' do
    it "host exists" do
      klass.memcached_host(configured_session).should eql 'i.am'
    end

    it "host doesn't exist" do
      klass.memcached_host(empty_session).should eql 'localhost'
    end

    it "host is set as an env variable" do
      ENV.stubs(:[]).with("memcached_host").returns('ruby-lang.org')
      klass.memcached_host(empty_session).should eql 'ruby-lang.org'
    end
  end

  context '#memcached_port' do
    it "port exists" do
      klass.memcached_port(configured_session).should eql '1337'
    end

    it "port doesn't exist" do
      klass.memcached_port(empty_session).should eql '11211'
    end

    it "port is set as an env variable" do
      ENV.stubs(:[]).with("memcached_port").returns('9000')
      klass.memcached_port(empty_session).should eql '9000'
    end
  end

  context '-#configured?' do
    context 'host is filled' do
      let(:configured_host) { {'host' => 'i.am'} }

      it "should be configured" do
        klass.send(:configured?, configured_host, 'host').should be true
      end

      it "should not be configured" do
        klass.send(:configured?, configured_host, 'port').should be false
      end
    end

    context 'port is filled' do
      let(:configured_port) { {'port' => '1337'} }

      it "should be configured" do
        klass.send(:configured?, configured_port, 'port').should be true
      end

      it "should not be configured" do
        klass.send(:configured?, configured_port, 'host').should be false
      end
    end
  end
end
