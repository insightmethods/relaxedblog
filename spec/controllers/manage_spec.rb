require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Manage, "index action" do
  before(:each) do
    dispatch_to(Manage, :index)
  end
end