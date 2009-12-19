require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Navigation do
  it "should respond to tree" do
    Bonsai::Navigation.should respond_to :tree
  end
  
  before do
    @tree = Bonsai::Navigation.tree
    @about = Bonsai::Page.find("about-us")
    @products = Bonsai::Page.find("products")
  end
  
  it "should contain 2 items" do
    @tree.should be_an_instance_of(Array)
    @tree.size.should == 3
  end
  
  it "should contain about and products" do
    @tree.should include @about
    @tree.should include @products
  end
  
  it "should be ordered" do
    @tree.first.should == @about
    @tree.last.should == @products
  end
end