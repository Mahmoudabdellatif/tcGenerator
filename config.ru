require "rack/reloader"
require_relative "app"

use Rack::Reloader
run ->(env) { App.call(env) }
