require 'rspec'
require 'mocha/api'

Dir.glob("lib/**/*.rb").each do |file|
  require_relative "../#{file}"
end

RSpec::Matchers.define :have_instance_variable do |instance_variable|
  chain :with do |value|
    @value = value
  end

  match do |object|
    @error = :presence if !object.instance_variables.include?(:"@#{instance_variable}") 
    @error = :equality if (object.instance_variable_get("@#{instance_variable}") != @value) && !@value.nil?

    @error.nil?
  end

  failure_message do |object|
    if @error == :presence
      "#{object} should have @#{instance_variable} instance variable"
    else
      "Instance variable @#{instance_variable} of #{object.class} should be #{@value.inspect} not #{object.inspect}"
    end
  end

  description do 
    if @value.nil?
      "have instance variable @#{instance_variable}"
    else
      "have instance variable @#{instance_variable} with #{@value.inspect}"
    end
  end
end

RSpec.configure do |config|
  config.formatter     = 'documentation'
end
