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
    Bonsai::VERSION.should =~ /\d+.\d+.\d+/
  end
  
  it "should load extensions.rb" do
    Bonsai.root_dir = "spec/support"

    # Test the module was created
    Extensions.class.should == Module
  end
  
  describe "site yml" do
    describe "working" do
      it "should respond to site" do
        Bonsai.should respond_to(:site)
      end

      it "should contain the contents of the site yml" do
        Bonsai.site.should == YAML.load(File.read("#{Bonsai.root_dir}/site.yml"))
      end
    end
    
    describe "broken" do
      before :all do
        Bonsai.root_dir = "spec/support/broken"
      end
      
      after :all do
        Bonsai.root_dir = "spec/support"
      end 
      
      it "should log rather than raising exception with badly formatted yml" do
        Bonsai.should_receive(:log).with("Badly formatted site.yml")
        lambda { Bonsai.site }.should_not raise_error
      end
    end
  end
end