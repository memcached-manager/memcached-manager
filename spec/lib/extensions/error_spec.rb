require 'spec_helper'

describe Sinatra::Errors do
  subject(:klass) { Class.new.extend(Sinatra::Errors) }
  before(:each) { subject.setup_errors }

  context "#setup_errors" do
    it { should have_instance_variable(:errors).with([]) }
  end

  context "#try" do
    before(:each) do
      subject.try { raise 'your hands' }
    end

    it { should have_instance_variable(:errors).with(['your hands']) }
  end

  context "#errors" do
    it { should respond_to(:errors) }
    it { should have_instance_variable(:errors) }
  end
end
