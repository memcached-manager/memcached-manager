require 'sinatra'
require 'sinatra/base'
require 'sinatra/contrib'

#TODO: autoload extensions
require_relative 'extensions/errors'
require_relative 'extensions/memcached_settings'
require_relative 'extensions/memcached_connection'
require_relative 'extensions/memcached_command'
require_relative 'extensions/memcached_inspector'
require_relative 'extensions/api_response'

module Sinatra
  helpers Errors
  helpers MemcachedSettings
  helpers MemcachedConnection
  helpers MemcachedInspector
  helpers MemcachedCommand
  helpers APIResponse
end
