require 'spec_helper'

describe Sinatra::MemcachedSettings do
  let(:configured_session) { { :host => 'i.am', :port => '1337' } }
  let(:empty_session) { {} }
  let(:klass) { Class.new.extend(Sinatra::MemcachedSettings) }

  before :each do
    allow(ENV).to receive(:[]).with('memcached_host').and_return nil
    allow(ENV).to receive(:[]).with('memcached_port').and_return nil
  end

  context '#memcached_host' do
    it "host exists" do
      expect(klass.memcached_host(configured_session)).to eq 'i.am'
    end

    it "host doesn't exist" do
      expect(klass.memcached_host(empty_session)).to eq 'localhost'
    end

    it "host is set as an env variable" do
      allow(ENV).to receive(:[]).with("memcached_host").and_return('ruby-lang.org')
      expect(klass.memcached_host(empty_session)).to eq 'ruby-lang.org'
    end
  end

  context '#memcached_port' do
    it "port exists" do
      expect(klass.memcached_port(configured_session)).to eq '1337'
    end

    it "port doesn't exist" do
      expect(klass.memcached_port(empty_session)).to eq '11211'
    end

    it "port is set as an env variable" do
      allow(ENV).to receive(:[]).with("memcached_port").and_return('9000')
      expect(klass.memcached_port(empty_session)).to eq '9000'
    end
  end

  context '-#configured?' do
    context 'host is filled' do
      let(:configured_host) { {'host' => 'i.am'} }

      it "should be configured" do
        expect(klass.send(:configured?, configured_host, 'host')).to be true
      end

      it "should not be configured" do
        expect(klass.send(:configured?, configured_host, 'port')).to be false
      end
    end

    context 'port is filled' do
      let(:configured_port) { {'port' => '1337'} }

      it "should be configured" do
        expect(klass.send(:configured?, configured_port, 'port')).to be true
      end

      it "should not be configured" do
        expect(klass.send(:configured?, configured_port, 'host')).to be false
      end
    end
  end
end
