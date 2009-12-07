require "#{File.dirname(__FILE__)}/../spec_helper"

describe Smeg::Template do
  it "should have a path" do
    Smeg::Template.path.should_not be_nil
  end
  
  it "should respond to find" do
    Smeg::Template.should respond_to(:find)
    Smeg::Template.find("demo-template").should be_an_instance_of(Smeg::Template)
  end
  
  describe "instance" do
    it "should give the template source" do
      @template = Smeg::Template.find("demo-template")
      @template.read.should == "Hello from our template, named {{name}}\n\n{{page_title}}\n\n{{#images}}\n  {{path}}\n{{/images}}\n\n{{#children}}\n  {{permalink}}\n{{/children}}\n\n{{#magic}}\n  {{path}}\n{{/magic}}\n\n{{>inserted}}"
    end
  end
end