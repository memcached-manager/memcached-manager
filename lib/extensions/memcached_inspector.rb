module Sinatra
  module MemcachedInspector
    def memcached_inspect options
      host = options[:host]
      port = options[:port]
      key = options[:key]
      query = options[:query]
      limit = options[:limit]

      inspect = inspector host, port

      # Filter by key if defined
      inspect = inspect.select{|pair| pair[:key] == key }.first if !key.nil?

      # Filter keys by query/regexp
      inspect = inspect.select{|pair| pair[:key] =~ Regexp.new(query, 'i') } if !query.nil?

      # Filter keys by limit
      inspect = inspect.take(limit.to_i) if !limit.nil?

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
            expires_in = expires_time.to_i
            infinite = false
            infinite = true if Time.at(expires_time.to_i) < Time.now

            keys << { key: cache_key, bytes: bytes, expires_in: expires_in, infinite: infinite }
          end
        end
      end

      keys
    end
  end
end

