require "#{File.dirname(__FILE__)}/../spec_helper"

describe Bonsai::Template do
  it "should have a path" do
    Bonsai::Template.path.should_not be_nil
  end
  
  it "should respond to find" do
    Bonsai::Template.should respond_to(:find)
    Bonsai::Template.find("demo-template").should be_an_instance_of(Bonsai::Template)
  end
  
  describe "instance" do
    it "should give the template source" do
      @template = Bonsai::Template.find("demo-template")
      File.read(@template.path).should == "Hello from our template, named {{name}}\n\n{{page_title}}\n{{body}}\n\n{% include 'partials/inserted' %}"
    end
  end
end