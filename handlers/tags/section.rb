require_relative "tag"

class Section < Tag
  def initialize(id, clause_ids)
    super(id)
    @clause_ids = clause_ids
  end

  def text
    # TODO : loop over clause_ids and substitute

    super
  end
end
