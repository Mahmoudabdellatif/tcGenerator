require_relative "tag"
require_relative "clause"

class Section < Tag
  def initialize(id, clause_ids)
    super(id)
    @clause_ids = clause_ids
  end

  def text(clause_dataset)
    arr = @clause_ids.map { |id| clause_dataset[id].nil? ? "" : clause_dataset[id].text }
    @text = arr.join(";")
    super()
  end

  def self.key
    :Section
  end

  def self.replacer(dataset)
    [regex, ->(tag) {
      id = get_id(tag).to_i
      dataset[key][id].nil? ? tag : dataset[key][id].text(dataset[Clause.key])
    }]
  end

  private

  def self.regex
    /\[SECTION-(\d+)\]/
  end

  def self.get_id(tag)
    tag[9...-1]
  end
end
