require "json"
require_rel "tags"
require_rel "parsers"
require_rel "../constants"

GenerateTCHandler = ->(env) {
  req = Rack::Request.new(env)

  begin
    document, clause_dataset, sections_dataset = GenerateTCParser.parse req.body.read
  rescue => exception
    return [400, {}, [ERRORS[:BAD_REQUEST] + exception.to_s]]
  end

  [200, {}, ["T&C Generator"]]
}
