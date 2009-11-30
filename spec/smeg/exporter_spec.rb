require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::Exporter do
  it "should have a path" do
    Smeg::Exporter.path.should_not be_nil
  end
  
  it "should set the path" do
    Smeg::Exporter.path = 'support/exporter/test'
    Smeg::Exporter.path.should == 'support/exporter/test'
    Smeg::Exporter.path = SPEC_EXPORTER_PATH
  end
  
  describe "render" do
    it "should create the output directory"
    it "should get all pages"
    it "should render all pages to the output directory"
  end
end