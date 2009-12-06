require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::Page do
  it "should respond to all" do
    Smeg::Page.should respond_to :all
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
    
    it "should have a name" do
      @page.name.should == "History"
    end
    
    it "should have a permalink" do
      @page.permalink.should == "/about-us/history"
    end
    
    
    it "should have a write_path" do
      @page.write_path.should == "/about-us/history/index.html"
    end
    
    it "should respond to disk path" do
      @page.disk_path.should == "#{Smeg.root_dir}/content/1.about-us/history/demo-template.yml"
    end
    
    it "should have images" do
      @page.images.should be_an_instance_of(Array)
      @page.images.first[:name].should == "image001.jpg"
      @page.images.first[:path].should == "/about-us/history/images/image001.jpg"
      @page.images.first[:disk_path].should == "#{Smeg.root_dir}/content/1.about-us/history/images/image001.jpg"
    end
    
    it "should have assets" do
      @page.assets.should be_an_instance_of(Array)
      @page.assets.length.should == 5
    end
    
    it "should be equal" do
      Smeg::Page.find("about-us").should == Smeg::Page.find("about-us")
    end
    
    describe "relationships" do
      before :all do
        @index = Smeg::Page.find("index")
        @about = Smeg::Page.find("about-us")
        @history = Smeg::Page.find("about-us/history")   
        @contact = Smeg::Page.find("about-us/contact")
        @child = Smeg::Page.find("about-us/history/child")
      end
      
      it "should have siblings" do
        @history.siblings.should be_an_instance_of(Array)
        @history.siblings.size.should == 2
        @history.siblings.should include(@contact)
        @history.siblings.should include(@history)
      end

      it "should have a parent" do
        @history.parent.should == @about
      end

      it "should not have a parent" do
        @about.parent.should == nil
      end
      
      it "should not have a parent for index" do
        @index.parent.should == nil
      end

      it "should have children" do
        @about.children.should be_an_instance_of(Array)
        @about.children.size.should == 2
        @about.children.should include(@history)
        @about.children.should include(@contact)
      end

      it "should have ancestors" do
        @child.ancestors.should be_an_instance_of(Array)
        @child.ancestors.size.should == 2
        @child.ancestors.should include(@history)
        @child.ancestors.should include(@about)
      end
    end    
    
    it "should have a template" do
      @page.template.should be_an_instance_of(Smeg::Template)
    end
    
    it "should to_hash to its variables" do
      @page.content[:name].should_not be_nil
      @page.content[:name].should == "About our history"
    end
    
    describe "render" do
      before :all do
        @output = @page.render 
      end
      
      it "should render" do
        @output.should_not be_nil
      end
      
      it "should replace moustache variables with properties from the content file" do
        @output.should == "Hello from our template, named History\n\n/about-us/history/images/image001.jpg\nThis content should be inserted!"
      end
      
      it "should write in images" do
        @output.should include "image001.jpg"
      end
    end
    
    describe "broken page" do
      before do
        Smeg::Page.path = "spec/support/broken/content"
      end
      
      it "should exist" do
        Smeg::Page.find("page").should be_an_instance_of(Smeg::Page)
      end
      
      it "should error gracefully" do
        lambda { Smeg::Page.find("page").render }.should_not raise_error(ArgumentError)
      end
    end
  end
end