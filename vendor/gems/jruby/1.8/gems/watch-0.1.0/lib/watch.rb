class Watch
  def initialize(glob, &block)
    raise "must pass a block" unless block_given?
    
    @path = glob
    @files = []
    @block = block
    
    @block.call
    
    run_loop
  end
  
  private
  def run_loop
    loop do
      @block.call if changed?    
      setup
      sleep 0.5
    end
  end
  
  def changed?
    file_list != @files
  end
  
  def setup
    @files = file_list
  end
  
  def file_list
    Dir[@path].map {|file| File.mtime(file) }
  end
end