require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class BlockRun
  def self.call
  end
end

describe "watch" do    
  before :all do
    @watch = Watch.new("tmp/**/*") { BlockRun.call }
  end
  
  it 'should run the block on startup' do
    BlockRun.should_receive(:call)
  end
  
  it 'should run the block when a file is added' do
    BlockRun.should_receive(:call)
    File.open("tmp/file", "w+") {|f| f << "abc"}
  end

  it 'should run the block on a file modification' do
    BlockRun.should_receive(:call)
    File.open("tmp/file", "w+") {|f| f << "def"}
  end

  it 'should run the block when a file is removed' do
    BlockRun.should_receive(:call)
    File.delete("tmp/file")
  end
end
