module Mutter
  class Indenter
    def initialize tab = 2
      @tab = tab
    end

    def [] n, obj = nil
      ' ' * (n * @tab)
    end
  end
end
