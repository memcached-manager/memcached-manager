module Sinatra
  module MemcachedInspector
    def memcached_inspect options
      host = options[:host]
      port = options[:port]
      key = options[:key]

      inspect = inspector host, port

      # Filter by key if defined
      if !key.nil?
        inspect = inspect.select{|pair| pair[:key] == key }.first
      end

      inspect
    end

    private
    def inspector host, port
      # Looks horrible, got it from a gist... yet, it works.

      keys = []
      cache_dump_limit = 9_000 # It's over...

      localhost = Net::Telnet::new("Host" => host, "Port" => port, "Timeout" => 3)
      slab_ids = []

      localhost.cmd("String" => "stats items", "Match" => /^END/) do |c|
        matches = c.scan(/STAT items:(\d+):/)
        slab_ids = matches.flatten.uniq
      end

      slab_ids.each do |slab_id|
        localhost.cmd("String" => "stats cachedump #{slab_id} #{cache_dump_limit}", "Match" => /^END/) do |c|
          matches = c.scan(/^ITEM (.+?) \[(\d+) b; (\d+) s\]$/).each do |key_data|
            (cache_key, bytes, expires_time) = key_data
            humanized_expires_time = Time.at(expires_time.to_i).to_s
            expired = false
            expired = true if Time.at(expires_time.to_i) < Time.now
            keys << { key: cache_key, bytes: bytes, expires_at: humanized_expires_time, expired: expired }
          end
        end
      end

      keys
    end
  end
end

