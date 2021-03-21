require "require_all"
require_rel "handlers"
require_relative "utils"

exact_path_matcher = ->(path) { ->(env) { env["PATH_INFO"] == path } }

Routes = [
  [exact_path_matcher["/"], GenerateTCHandler],
  # else
  [Utils.constant[true], NotFoundHandler],
]
