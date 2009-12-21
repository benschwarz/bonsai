require 'irb'
module Bonsai
  class Console
    def initialize
      IRB.new(__FILE__)
    end
  end
end