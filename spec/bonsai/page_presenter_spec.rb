require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::PagePresenter do
  before :all do
    @page = Bonsai::Page.find("about-us/history")
    @pp = Bonsai::PagePresenter.new(@page)
  end
  
  it "should have a name" do
    @pp.name.should == "History"
  end
  
  it "should have a permalink" do
    @pp.permalink.should == "/about-us/history"
  end
  
  it "should have a slug" do
    @pp.slug.should == "history"
  end
  
  it "should have images" do
    @pp.images.should be_an(Array)
  end
  
  it "should have assets" do
    @pp.assets.should be_an(Array)
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
  
  it "should have the pages' content" do
    @pp._content.should == @page._content
  end
  
  describe "magic variables" do
    it "should map its folders to magic variables" do
      @pp.magic.should be_an_instance_of(Array)
      @pp.magic.first.should be_an_instance_of(Hash)
      @pp.magic.size.should == 2
    end
    
    describe "boolean" do
      it "should have a magic? method to tell if there are any magic files for this page"
      it "should be true"
      it "should be false"
    end
  end
end