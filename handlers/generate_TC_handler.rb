require "json"
require_rel "tags"
require_rel "parsers"
require_rel "../constants"

GenerateTCHandler = ->(env) {
  req = Rack::Request.new(env)
  return [405, {}, [ERRORS[:NOT_ALLOWED_METHOD]]] if (!req.post?)

  begin
    document, dataset = GenerateTCParser.parse req.body.read
  rescue => exception
    return [400, {}, [ERRORS[:BAD_REQUEST] + exception.to_s]]
  end

  if (!dataset.nil? && !dataset.empty?)
    replacers = dataset.map { |key, v| Module.const_get(key.to_s).replacer(dataset) }
    document = document.mgsub(replacers)
  end

  [200, {}, [document]]
}
