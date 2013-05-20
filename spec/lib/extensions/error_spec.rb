require 'spec_helper'

describe Sinatra::Errors do
  let(:klass) { Class.new.extend(Sinatra::Errors) }

  context "#setup_errors" do
    it do
      klass.setup_errors
      klass.instance_variable_get(:"@errors").should eql []
    end
  end

  context "#try" do
    before(:each) do
      klass.setup_errors
    end

    it "should execute a block and add to errors if an exception is raised" do
      klass.try { raise 'your hands' }
      klass.errors.should include 'your hands'
    end
  end

  context "#errors" do
    before(:each) do
      klass.setup_errors
    end

    it "should exist" do
      klass.respond_to?(:errors).should be true
    end

    it "should be the instance variable of errors" do
      klass.instance_variable_get(:"@errors").should be klass.errors 
    end
  end
end
