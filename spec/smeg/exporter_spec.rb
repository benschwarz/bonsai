require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::Exporter do
  before :all do
#    FakeFS.activate!
  end
  
  after :all do
#    FakeFS.deactivate!
  end
  
  it "should have a path" do
    Smeg::Exporter.path.should_not be_nil
  end
  
  it "should set the path" do
    Smeg::Exporter.path = 'support/exporter/test'
    Smeg::Exporter.path.should == 'support/exporter/test'
    Smeg::Exporter.path = SPEC_EXPORTER_PATH
  end
  
  describe "render" do
    before do
      Smeg::Exporter.send(:teardown)
    end
    
    it "should create the output directory" do
      Smeg::Exporter.publish!
      File.exists?(Smeg::Exporter.path).should be_true
    end
    
    it "should remove the output directory before re-creating it" do
      testfile = "#{Smeg::Exporter.path}/test"
      
      Smeg::Exporter.publish!
      FileUtils.touch(testfile)
      File.exists?(testfile).should be_true
      Smeg::Exporter.publish!
      File.exists?(testfile).should be_false
    end
        
    it "should render all pages to the output directory" do
      Smeg::Page.all{|page| File.exists?("#{Smeg::Exporter.path}#{page.write_path}").should be_false }
      Smeg::Exporter.publish!
      Smeg::Page.all{|page| File.exists?("#{Smeg::Exporter.path}#{page.write_path}").should be_true }
    end
    
    it "should copy the images of each page to its directory" do  
      Smeg.root_dir = "spec/support"
      
      File.exists?("#{Smeg::Exporter.path}/about-us/history/image001.jpg").should be_false
      Smeg::Exporter.publish!
      File.exists?("#{Smeg::Exporter.path}/about-us/history/image001.jpg").should be_true
    end
    
    it "should copy the contents of the public directory to the root export path" do
      Smeg.root_dir = "spec/support"
      
      File.exists?("#{Smeg::Exporter.path}/htaccess").should be_false
      Smeg::Exporter.publish!
      File.exists?("#{Smeg::Exporter.path}/htaccess").should be_true
    end
    
    it "should write the index file to output/index.html" do
      File.exists?("#{Smeg::Exporter.path}/index.html").should be_false
      Smeg::Exporter.publish!
      File.exists?("#{Smeg::Exporter.path}/index.html").should be_true
    end
  end
end