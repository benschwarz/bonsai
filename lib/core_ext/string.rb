class String
  def to_permalink
    # Pinched: http://github.com/jrun/merb_permalink_fu/tree/master/lib/merb_permalink_fu/permalink_fu.rb
    string = self
    
    string = string.gsub(/\W+/, ' ')
    string = string.strip
    string = string.downcase
    string = string.gsub(/\ +/, '-') # spaces to dashes, preferred separator char everywhere
  end
end