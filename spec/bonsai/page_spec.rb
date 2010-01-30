# coding: utf-8

require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Page do
  it "should respond to all" do
    Bonsai::Page.should respond_to :all
  end
  
  it "should contain pages" do
    Bonsai::Page.all.first.should be_an_instance_of(Bonsai::Page)
  end
  
  describe "instance" do
    before :all do
      @page = Bonsai::Page.find("about-us/history/")
    end
    
    it "should have a slug" do
      @page.slug.should == "history"
    end
    
    it "should have a name" do
      @page.name.should == "History"
    end
    
    it "should have a permalink" do
      @page.permalink.should == "/about-us/history/"
    end
    
    it "should have a ctime" do
      @page.should respond_to :ctime
      @page.ctime.should be_an_instance_of(Time)
    end
    
    it "should have an mtime" do
      @page.should respond_to :mtime
      @page.mtime.should be_an_instance_of(Time)
    end
    it "should remove numbers over 10 from the permalink" do
      Bonsai::Page.find("many-pages").permalink.should == "/many-pages/"
    end
    
    it "should have a write_path" do
      @page.write_path.should == "/about-us/history/index.html"
    end
    
    it "should respond to disk path" do
      @page.disk_path.should == "#{Bonsai.root_dir}/content/1.about-us/history/demo-template.yml"
    end
        
    it "should have assets" do
      @page.assets.should be_an_instance_of(Array)
      @page.assets.length.should == 6
    end
    
    it "should be equal" do
      Bonsai::Page.find("about-us").should == Bonsai::Page.find("about-us")
    end
    
    describe "relationships" do
      before :all do
        @index = Bonsai::Page.find("index")
        @about = Bonsai::Page.find("about-us")
        @history = Bonsai::Page.find("about-us/history")   
        @contact = Bonsai::Page.find("about-us/contact")
        @child = Bonsai::Page.find("about-us/history/child")
      end
      
      it "should have siblings" do
        @history.siblings.should be_an_instance_of(Array)
        @history.siblings.size.should == 1
        @history.siblings.should include(@contact)
        @history.siblings.should_not include(@history)
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
        @about.children.size.should == 1
        @about.children.should include(@contact)
      end
      
      it "should not have floating pages in the children array" do
        @about.children.should_not include(@history)
      end

      it "should have ancestors" do
        @child.ancestors.should be_an_instance_of(Array)
        @child.ancestors.size.should == 2
        @child.ancestors.should include(@history)
        @child.ancestors.should include(@about)
      end
      
      it "should have the ancestors in a top down order" do
        @child.ancestors.first.should == @about
        @child.ancestors.last.should == @history
      end
      
      it "index should be a floating page" do
        @index.floating?.should be_true
      end

      it "about should not be a floating page" do
        @about.floating?.should be_false
      end
    end
    
    it "should have a template" do
      @page.template.should be_an_instance_of(Bonsai::Template)
    end
    
    it "should to_hash to its variables" do
      @page.content[:page_title].should == "About our history"
      @page.content[:page_title].should_not be_nil
    end
    
    describe "render" do
      before :all do
        @output = Bonsai::Page.find("about-us/contact").render 
      end
      
      it "should render" do
        @output.should_not be_nil
      end
      
      it "should replace mustache variables with properties from the content file" do
        @output.should == "Hello from our template, named Contact\n\nGet in touch\n\n/about-us/contact/images/image001.jpg\n/about-us/contact/child/\n/about-us/contact/magic/image001.jpg\n/about-us/contact/magic/image002.jpg\nThis content should be inserted!\n\n<p>&ldquo;A designer knows he has achieved perfection\nnot when there is nothing left to add,\nbut when there is nothing left to take away.&rdquo;</p>\n\n<p>– Antoine de Saint-Exupery</p>\n"
      end
      
      it "should write in images" do
        @output.should include "image001.jpg"
      end
      
      # Pages that use a structure yet have no parent page should still render
      describe "page without parent" do
        it "should render successfully" do
          lambda { Bonsai::Page.find("legals/terms-and-conditions").render }.should_not raise_error
        end
      end
      
      describe "markdown" do
        it "should not use markdown for single line content" do
          @output.should =~ /\nGet in touch\n/
        end
        
        it "should use markdown for multiple line content" do
          @output.should =~ /<p>&ldquo;A designer knows he/
        end
        
        it "should use smartypants" do
          @output.should =~ /&rdquo;/
        end
      end
    end
    
    describe "to hash" do
      before :all do
        @page = Bonsai::Page.find("about-us/history")
      end
      
      it "should respond to to_hash" do
        @page.should respond_to(:to_hash)
      end
      
      %w(slug permalink name page_title children siblings parent ancestors magic navigation updated_at created_at).each do |key|
        it "should have a to_hash key for #{key}" do
          @page.to_hash.keys.should include(key.to_sym)
        end
      end
      
      describe "disk_assets" do
        before :all do
          @vars = @page.to_hash
        end
        
        describe "enum" do
          it "should not have a child" do
            @vars.should_not have_key(:child)
          end

          it "should have magic" do
            @vars.should have_key(:magic)
          end

          it "it should be a an array of hashes" do
            @vars[:magic].should be_an_instance_of(Array)
            @vars[:magic].first.should be_an_instance_of(Hash)
            @vars[:magic].size.should == 2
          end
        end
        
        describe "boolean" do
          it "should be false" do
            pending
            @vars[:child?].should be_false
          end
          
          it "should be true" do
            pending
            @vars[:magic?].should be_true
          end
        end
      end
    end
    
    describe "broken page" do
      before :all do
        Bonsai::Page.path = "spec/support/broken/content"
      end
      
      after :all do
        Bonsai::Page.path = "spec/support/content"
      end
      
      it "should exist" do
        Bonsai::Page.find("page").should be_an_instance_of(Bonsai::Page)
      end
      
      it "should error gracefully" do
        lambda { Bonsai::Page.find("page").render }.should_not raise_error(ArgumentError)
      end
    end
  end
end
