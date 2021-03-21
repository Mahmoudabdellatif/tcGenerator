require_relative "utils"
require_relative "routes"

route_matcher = ->(env) { ->((cond, _handler)) { cond[env] } }
find_route = ->(env) { Routes.find(&route_matcher[env]) }
find_handler = Utils.comp[Utils.second, find_route]
router = ->(env) { find_handler[env][env] }

App = router
