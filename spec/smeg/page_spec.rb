require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::Page do
  it "should have a path" do
    Smeg::Page.path.should_not be_nil
  end
  
  it "should set the path" do
    Smeg::Page.path = 'support/content/test'
    Smeg::Page.path.should == 'support/content/test'
    Smeg::Page.path = SPEC_CONTENT_PATH
  end
  
  it "should respond to all" do
    Smeg::Page.should respond_to :all
  end
  
  it "should respond to index" do
    Smeg::Page.should respond_to :index
    Smeg::Page.index.should be_an_instance_of(Smeg::Page)
  end
  
  it "should contain pages" do
    Smeg::Page.all.first.should be_an_instance_of(Smeg::Page)
  end
  
  describe "instance" do
    before :all do
      @page = Smeg::Page.find("about-us/history")
    end
    
    it "should have a slug" do
      @page.slug.should == "history"
    end
    
    it "should have a permalink" do
      @page.permalink.should == "/about-us/history"
    end
    
    it "should have images" do
      @page.images.should be_an_instance_of(Array)
    end
    
    it "should have files" do
      @page.files.should be_an_instance_of(Array)
    end
    
    it "should have a template" do
      @page.template.should be_an_instance_of(Smeg::Template)
    end
    
    it "should method_missing to its variables" do
      @page.name.should_not be_nil
      @page.name.should == "About our history"
    end
  end
end