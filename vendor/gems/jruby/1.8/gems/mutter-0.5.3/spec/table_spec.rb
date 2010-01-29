require 'spec/spec_helper'

describe Mutter::Table do
  it "should render tables defined with a block" do
    table = Mutter::Table.new(:delimiter => '|') do
      column :width => 8
      column :align => :right
      column
    end
    
    table << ["hello", "moto", "malacif"]
    table << ["misha", "fafa", "fio"]
    table << ["lombardic", "fister", "falalala"]
        
    table.to_a.should == [
      "hello   |  moto|malacif ",
      "misha   |  fafa|fio     ",
      "lombar..|fister|falalala"
    ]
  end
end
