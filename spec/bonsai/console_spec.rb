require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Console do
  it "should respond to new" do
    Bonsai::Console.should respond_to(:new)
  end
  
  it "should start a new IRB session" do
    IRB.should_receive(:new)
    Bonsai::Console.new
  end
end