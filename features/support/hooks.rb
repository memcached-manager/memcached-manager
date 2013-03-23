AfterConfiguration do |config|
  Memcached = Dalli::Client.new('localhost:11211')
end

After do
  Memcached.flush
end
