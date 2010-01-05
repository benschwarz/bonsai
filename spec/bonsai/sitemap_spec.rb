require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Sitemap do
  before :all do
    @sitemap = Bonsai::Sitemap.generate
  end
  
  it "should contain /" do
    @sitemap.should include "<loc>http://tinytree.info</loc>"
  end

  it "should not include /index" do
    @sitemap.should_not include "<loc>http://tinytree.info/index</loc>"
  end
end