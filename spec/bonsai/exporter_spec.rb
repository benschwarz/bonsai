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

  shared_examples_for "asset generators" do
    it "should process .scss files to .css" do
      File.exists?("#{Bonsai::Exporter.path}/stylesheets/sassy.css").should be_true
    end

    it "should process .coffee files to .js" do
      File.exists?("#{Bonsai::Exporter.path}/js/hot.js").should be_true
    end

    it "should log an error when badly formatted less is supplied (and not raise an exception)" do
      Bonsai.should_receive(:log)
      lambda { Bonsai::Exporter.send(:generate_assets) }.should_not raise_error(Sass::SyntaxError)
    end

    it "cleans up compiled source files" do
      File.exists?("#{Bonsai::Exporter.path}/js/hot.coffee").should_not be_true
      File.exists?("#{Bonsai::Exporter.path}/stylesheets/brokensass.sass").should_not be_true
      File.exists?("#{Bonsai::Exporter.path}/stylesheets/sassy.scss").should_not be_true
      File.exists?("#{Bonsai::Exporter.path}/stylesheets/lessy.less").should_not be_true
    end
  end

  describe "process!" do
    describe "tasks" do
      before :all do
        FileUtils.rm_rf Bonsai::Exporter.path
        Bonsai::Exporter.process!
      end

      it_should_behave_like "asset generators"

      # Uncompressed CSS
      it "should be processed with sass" do
        File.read("#{Bonsai::Exporter.path}/stylesheets/sassy.css").should == "#content {\n  display: block; }\n"
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
        Bonsai::Exporter.should_receive(:generate_assets)
      end
    end
  end

  describe "publish!" do
    describe "actions" do
      before :all do
        FileUtils.rm_rf Bonsai::Exporter.path
        Bonsai::Exporter.publish!
      end

      it_should_behave_like "asset generators"

      # Compressed CSS
      it "should be processed with sass" do
        File.read("#{Bonsai::Exporter.path}/stylesheets/sassy.css").should == "#content{display:block}"
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
        File.exists?("#{Bonsai::Exporter.path}/about-us/history/1_a_file_asset.txt").should be_true
      end

      it "should copy the contents of the public directory to the root export path" do
        File.exists?("#{Bonsai::Exporter.path}/.htaccess").should be_true
      end

      it "should write the index file to output/index.html" do
        File.exists?("#{Bonsai::Exporter.path}/index.html").should be_true
      end

      it "should write a sitemap.xml" do
        File.exists?("#{Bonsai::Exporter.path}/sitemap.xml").should be_true
      end

      it "should write a readme file to explain how the site was generated" do
        File.exists?("#{Bonsai::Exporter.path}/ABOUT-THIS-SITE.txt").should be_true
      end

      describe "asset compression" do
        it "should compress the css file" do
          File.read("#{Bonsai::Exporter.path}/stylesheets/sassy.css").should == "#content{display:block}"
        end

        it "should compress the js files" do
          File.read("#{Bonsai::Exporter.path}/js/script.js").should == "$(function(){$(\".default-value\").each(function(){var default_value=this.value;$(this).focus(function(){if(this.value==default_value){this.value=\"\"}});$(this).blur(function(){if(this.value==\"\"){this.value=default_value}})});$(\".details dd:empty\").hide().prev(\"dt\").hide()});"
          File.read("#{Bonsai::Exporter.path}/js/hot.js").should == "(function(){this.foo=function(){return alert(\"bar\")}}).call(this);"
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

      it "should process css with less or sass" do
        Bonsai::Exporter.should_receive(:generate_assets)
      end

      it "should compress assets" do
        Bonsai::Exporter.should_receive(:compress_assets)
      end
    end
  end
end