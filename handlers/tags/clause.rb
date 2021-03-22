require_relative "tag"

class Clause < Tag
  def initialize(id, text)
    super(id)
    @text = text
  end

  def self.key
    :Clause
  end

  def self.replacer(dataset)
    [regex, ->(tag) {
      id = get_id(tag).to_i
      dataset[key][id].nil? ? tag : dataset[key][id].text
    }]
  end

  private

  def self.regex
    /\[CLAUSE-(\d+)\]/
  end

  def self.get_id(tag)
    tag[8...-1]
  end
end
