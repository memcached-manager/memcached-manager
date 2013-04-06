require_relative 'extensions/errors'
require_relative 'extensions/memcached_settings'
require_relative 'extensions/memcached_connection'

module Sinatra
  helpers Errors
  helpers MemcachedSettings
  helpers MemcachedConnection
end
