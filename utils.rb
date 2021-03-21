module Utils

  # Utility constant function
  def self.constant
    ->(x) { ->(_) { x } }
  end

  def self.comp
    ->(f1, f2) { ->(x) { f1[f2[x]] } }
  end

  # Utility function to get the handler out of a route
  def self.second
    ->((_a, b)) { b }
  end
end
