require_relative "tag"

class Clause < Tag
  def initialize(id, text)
    super(id)
    @text = text
  end
end
