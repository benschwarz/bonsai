require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::PagePresenter do
  before :all do
    @page = Smeg::Page.find("about-us/history")
    @pp = Smeg::PagePresenter.new(@page)
  end
  
  %w(name slug permalink).each do |prop|
    it "should have a standard property of: #{prop}" do
      @pp.should respond_to(prop.to_sym)
    end
  end
  
  it "should have children" do
    @pp.should respond_to :children
  end
  
  it "should have a parent" do
    @pp.should respond_to :parent
  end
  
  it "should have siblings" do
    @pp.should respond_to :siblings
  end
  
  it "should have navigation" do
    @pp.should respond_to :navigation
  end
  
  it "should have images" do
    @pp.should respond_to :images
  end
  
  it "should have assets" do
    @pp.should respond_to :assets
  end
  
  describe "magic variables" do
    it "should map its folders to magic variables" do
      @pp.magic.should be_an_instance_of(Array)
      @pp.magic.first.should be_an_instance_of(Hash)
      @pp.magic.size.should == 2
    end
  end
end