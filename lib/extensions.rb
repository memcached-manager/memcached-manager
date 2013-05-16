require_relative 'extensions/errors'
require_relative 'extensions/memcached_settings'
require_relative 'extensions/memcached_connection'
require_relative 'extensions/memcached_inspector'

module Sinatra
  helpers Errors
  helpers MemcachedSettings
  helpers MemcachedConnection
  helpers MemcachedInspector
end
