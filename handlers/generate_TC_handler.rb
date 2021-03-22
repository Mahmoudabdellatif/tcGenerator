require "json"

GenerateTCHandler = ->(env) {
  req = Rack::Request.new(env)
  body = JSON.parse(req.body.read)
  puts body["template"]
  [200, {}, ["T&C Generator"]]
}
