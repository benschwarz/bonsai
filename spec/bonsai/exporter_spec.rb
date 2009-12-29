require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Exporter do
  after :suite do
    FileUtils.rm_rf Bonsai::Exporter.path
  end
  
  it "should have a path" do
    Bonsai::Exporter.path.should_not be_nil
  end
  
  it "should set the path" do
    Bonsai::Exporter.path = 'support/exporter/test'
    Bonsai::Exporter.path.should == 'support/exporter/test'
    Bonsai::Exporter.path = BONSAI_PATH + "/output"
  end
  
  shared_examples_for "lesscss" do      
    it "should process .less files to .css" do
      File.exists?("#{Bonsai::Exporter.path}/stylesheets/base.css").should be_true
    end
        
    it "should log an error when badly formatted less is supplied (and not raise an exception)" do
      Bonsai.should_receive(:log)
      lambda { Bonsai::Exporter.send(:generate_css_from_less) }.should_not raise_error(Less::SyntaxError)
    end
  end
  
  describe "process!" do
    describe "tasks" do
      before :all do
        FileUtils.rm_rf Bonsai::Exporter.path
        Bonsai::Exporter.process!
      end
      
      it_should_behave_like "lesscss"
      
      # Uncompressed CSS
      it "should be processed with less" do
        File.read("#{Bonsai::Exporter.path}/stylesheets/base.css").should == ".mymixin, #content { display: block; }\n"
      end
      
      it "should not write the base.css file to the public directory" do
        File.exists?("#{Bonsai.root_dir}/public/base.css").should_not be_true
      end
      
    end
    
    describe "expectations" do
      after do
        Bonsai::Exporter.process!
      end
      
      it "should copy assets" do
        Bonsai::Exporter.should_receive(:copy_assets)
      end

      it "should copy public" do
        Bonsai::Exporter.should_receive(:copy_public)
      end

      it "should generate css via lesscss" do
        Bonsai::Exporter.should_receive(:generate_css_from_less)
      end      
    end
  end

  describe "publish!" do
    describe "actions" do
      before :all do
        FileUtils.rm_rf Bonsai::Exporter.path
        Bonsai::Exporter.publish!
      end
      
      it_should_behave_like "lesscss"
      
      # Compressed CSS
      it "should be processed with less" do
        File.read("#{Bonsai::Exporter.path}/stylesheets/base.css").should == ".mymixin,#content{display:block;}"
      end
      
      it "should not export the base.less file" do
        File.exists?("#{Bonsai::Exporter.path}/stylesheets/base.less").should be_false
      end

      it "should create the output directory" do
        File.exists?(Bonsai::Exporter.path).should be_true
      end

      it "should render pages to the output directory" do
        # Index is rendered to index.html and index/index.html
        Dir[Bonsai::Exporter.path + "/**/*.html"].size.should == Bonsai::Page.all.size + 1  
      end

      it "should copy the images of each page to its directory" do
        File.exists?("#{Bonsai::Exporter.path}/about-us/history/images/image001.jpg").should be_true
      end

      it 'should copy the assets of each page to its directory' do    
        File.exists?("#{Bonsai::Exporter.path}/about-us/history/a_file_asset.txt").should be_true
      end

      it "should copy the contents of the public directory to the root export path" do
        File.exists?("#{Bonsai::Exporter.path}/.htaccess").should be_true
      end

      it "should write the index file to output/index.html" do
        File.exists?("#{Bonsai::Exporter.path}/index.html").should be_true
      end
      
      it "should write a readme file to explain how the site was generated"
      
      describe "asset compression" do
        it "should compress the css file" do
          File.read("#{Bonsai::Exporter.path}/stylesheets/base.css").should == ".mymixin,#content{display:block;}"
        end
        
        it "should compress the js file" do
          File.read("#{Bonsai::Exporter.path}/js/script.js").should == "$(function(){$(\".default-value\").each(function(){var a=this.value;$(this).focus(function(){if(this.value==a){this.value=\"\"}});$(this).blur(function(){if(this.value==\"\"){this.value=a}})});$(\".details dd:empty\").hide().prev(\"dt\").hide()});"
        end
      end
    end

    describe "expectations" do
      after do
        Bonsai::Exporter.publish!
      end
      
      it "should remove the output directory before re-creating it" do
        FileUtils.should_receive(:rm_rf).with(Bonsai::Exporter.path)
      end
      
      it "should generate css via lesscss" do
        Bonsai::Exporter.should_receive(:generate_css_from_less)
      end

      it "should compress assets" do
        Bonsai::Exporter.should_receive(:compress_assets)
      end
    end
  end
end