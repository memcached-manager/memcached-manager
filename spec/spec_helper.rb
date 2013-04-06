require 'rspec'

Dir.glob("lib/**/*.rb").each do |file|
  require_relative "../#{file}"
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
