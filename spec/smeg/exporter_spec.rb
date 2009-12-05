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
    Smeg::Exporter.path = SMEG_PATH + "/output"
  end
  
  describe "publish, used to export the entire site to an output directory" do
    before do
      Smeg::Exporter.publish!
    end
    
    describe "lesscss" do
      it "should process .less files to .css" do
        File.exists?("#{Smeg::Exporter.path}/stylesheets/base.css").should be_true
      end
      
      it "should be processed with less" do
        File.read("#{Smeg::Exporter.path}/stylesheets/base.css").should == ".mymixin, #content { display: block; }\n"
      end
    end
    
    describe "process!" do
      describe "expectations" do
        after do
          Smeg::Exporter.process!
        end
        
        it "should copy assets" do
          Smeg::Exporter.should_receive(:copy_assets)
        end

        it "should copy public" do
          Smeg::Exporter.should_receive(:copy_public)
        end

        it "should generate css via lesscss" do
          Smeg::Exporter.should_receive(:generate_css_from_less)
        end
      end
    end
    
    describe "publish!" do
      describe "actions" do
        before :all do
          Smeg::Exporter.publish!
        end

        it "should create the output directory" do
          File.exists?(Smeg::Exporter.path).should be_true
        end

        it "should render pages to the output directory" do
          # Index is rendered to index.html and index/index.html
          Dir[Smeg::Exporter.path + "/**/*.html"].size.should == Smeg::Page.all.size + 1  
        end

        it "should copy the images of each page to its directory" do
          File.exists?("#{Smeg::Exporter.path}/about-us/history/images/image001.jpg").should be_true
        end

        it 'should copy the assets of each page to its directory' do    
          File.exists?("#{Smeg::Exporter.path}/about-us/history/a_file_asset.txt").should be_true
        end

        it "should copy the contents of the public directory to the root export path" do
          File.exists?("#{Smeg::Exporter.path}/htaccess").should be_true
        end

        it "should write the index file to output/index.html" do
          File.exists?("#{Smeg::Exporter.path}/index.html").should be_true
        end
      end

      describe "expectations" do
        it "should remove the output directory before re-creating it" do
          FileUtils.should_receive(:rm_rf).with(Smeg::Exporter.path)
          Smeg::Exporter.publish!
        end
      end
    end
  end
end