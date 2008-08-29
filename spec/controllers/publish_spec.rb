require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Publish, "index action" do
  before(:each) do
    dispatch_to(Publish, :index)
  end
end