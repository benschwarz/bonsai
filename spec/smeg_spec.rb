require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Smeg do
  it "should have a root dir" do
    Smeg.should respond_to :root_dir
  end
  
  it "should set the root dir" do
    Smeg.root_dir = "spec/support"
    Smeg.root_dir.should == "spec/support"
  end
end