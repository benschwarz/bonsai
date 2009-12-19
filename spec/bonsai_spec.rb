require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Bonsai do
  it "should have a root dir" do
    Bonsai.should respond_to :root_dir
  end
  
  it "should set the root dir" do
    Bonsai.root_dir = "spec/support"
    Bonsai.root_dir.should == "spec/support"
  end
end