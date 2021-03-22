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

class String
  def mgsub(key_value_pairs = [].freeze)
    regexp_fragments = key_value_pairs.collect { |k, v| k }
    gsub(
      Regexp.union(*regexp_fragments)
    ) do |match|
      key_value_pairs.detect { |k, v| k =~ match }[1][match]
    end
  end
end
