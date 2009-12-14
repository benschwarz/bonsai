require "#{File.dirname(__FILE__)}/../spec_helper"
describe Smeg::Generate do
  describe "generator" do
    before :all do
      @path = File.expand_path("spec/tmp/")
      Smeg::Generate.new(@path)
    end
    
    it "should create base directories" do
      %w(content templates templates/partials public public/docs public/docs/css public/docs/js).each do |dir|
        File.directory?("#{@path}#{dir}").should be_true
      end
    end
    
    it "should copy the htaccess file to public/.htaccess" do
      File.exists?("#{@path}/public/.htaccess").should be_true
    end
    
    it "should copy the base.less file" do
      File.exists?("#{@path}/docs/css/base.less").should be_true
    end
  end
end