require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Bonsai do
  it "should have a root dir" do
    Bonsai.should respond_to :root_dir
  end
  
  it "should set the root dir" do
    Bonsai.root_dir = "spec/support"
    Bonsai.root_dir.should == "spec/support"
  end
  
  it "should throw an exception if it doesn't look like a bonsai site" do
    lambda { Bonsai.root_dir = "spec" }.should raise_error
    lambda { Bonsai.root_dir = "spec/support" }.should_not raise_error
  end
  
  it "should know the version" do
    Bonsai.version.should =~ /\d+.\d+.\d+/
  end
end