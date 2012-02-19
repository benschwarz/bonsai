# coding: utf-8

require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Page do
  
  describe "class methods" do
    it "should respond to all" do
      Bonsai::Page.should respond_to :all
    end

    it "should contain pages" do
      Bonsai::Page.all.first.should be_an_instance_of(Bonsai::Page)
    end

    it "should remove numbers over 10 from the permalink" do
      Bonsai::Page.find("many-pages").permalink.should == "/many-pages/"
    end

    it "should be equal" do
      Bonsai::Page.find("about-us").should == Bonsai::Page.find("about-us")
    end
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
  
  describe "instance" do
    let(:page) { Bonsai::Page.find("about-us/history") }
    subject { page }
    
    its(:slug) { should == "history" }
    its(:name) { should == "History" }
    its(:permalink) { should == "/about-us/history/" }
    its(:ctime) { should be_an_instance_of Time }
    its(:mtime) { should be_an_instance_of Time }
    its(:write_path) { should == "/about-us/history/index.html" }
    its(:disk_path) { should == "#{Bonsai.root_dir}/content/1.about-us/history/demo-template.yml" }
    its(:template) { should be_an_instance_of(Bonsai::Template) }
    it "should to_hash to its variables" do
      page.content[:page_title].should == "About our history"
      page.content[:page_title].should_not be_nil
    end
    
    describe "assets" do
      subject { page.assets }
      
      it { should be_an_instance_of Array }
      its(:length) { should be 6 }
      
      describe "asset properties" do
        it "should have the correct name" do
          page.assets.first['name'].should == "001"
        end

        it "should have the correct path" do
          page.assets.first['path'].should == "/about-us/history/001.jpg"
        end

        it "should have the correct disk_path" do
          page.assets.first['disk_path'].should == File.join(Dir.pwd, "spec/support/content/1.about-us/history/001.jpg")
        end

        it "should titleize the name attribute and remove the file extension" do
          page.assets[2]['name'].should == "A File Asset"
        end
      end
    end
  end
  
  describe "render" do
    describe "general" do
      let(:page) { Bonsai::Page.find("about-us/contact").render }
      subject { page }
      
      it { should_not be_nil }

      it "should replace liquid variables with properties from the content file" do
        page.should == "Hello from our template, named Contact\n\nGet in touch\n<p>&#8220;A designer knows he has achieved perfection not when there is nothing left to add, but when there is nothing left to take away.&#8221;</p>\n\n<p>– Antoine de Saint-Exupery</p>\n\nThis content should be inserted!"
      end
      
      describe "markdown" do
        it "should not use markdown for single line content" do
          page.should =~ /\nGet in touch\n/
        end

        it "should use markdown for multiple line content" do
          page.should =~ /<p>&#8220;A designer knows he/
        end

        it "should use smartypants" do
          page.should =~ /&#8220;/
        end
      end
    end
    
    describe "images" do
      let(:page) { Bonsai::Page.find("render/image-spec").render }
      it "should render successfully" do
        page.should == "\n  /render/image-spec/images/image001.jpg\n"
      end
      
      it "should write in images" do
        page.should include "image001.jpg"
      end
    end
    
    # Pages that use a structure yet have no parent page should still render
    describe "page without parent" do
      it "should render successfully" do
        lambda { Bonsai::Page.find("legals/terms-and-conditions").render }.should_not raise_error
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
        @page.to_hash.keys.should include(key)
      end
    end
    
    it "should include global site variables from site.yml" do
      @page.to_hash['site_name'].should == "Bonsai"
      @page.to_hash['url'].should == "http://tinytree.info"
      @page.to_hash['copyright'].should == 2010
    end
    
    describe "disk_assets" do
      before :all do
        @vars = @page.to_hash
      end
      
      describe "enum" do
        it "should not have a child" do
          @vars.should_not have_key('child')
        end

        it "should have magic" do
          @vars.should have_key('magic')
        end

        it "it should be a an array of hashes" do
          @vars['magic'].should be_an_instance_of(Array)
          @vars['magic'].first.should be_an_instance_of(Hash)
          @vars['magic'].size.should == 2
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
