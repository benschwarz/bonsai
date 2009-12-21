require 'irb'
module Bonsai
  class Console
    def initialize
      IRB.start(__FILE__)
    end
  end
end