
class String
  def examine depth = 0
    inspect
  end
end

class Array
  def examine depth = 0
  end
end

class Hash
  def examine depth = 0
  end
end

class Symbol
  def examine depth = 0
    Mutter.stylize inspect, :purple
  end
end

class Numeric
  def examine depth = 0
    Mutter.stylize inspect, :cyan
  end
end

class Object
  def tap
    yield self
    self
  end
end
