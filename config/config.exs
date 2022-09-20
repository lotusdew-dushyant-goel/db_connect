import Config

# configuring mnesia
config :mnesia, dir: '.mnesia/demo_tables'

import_config "#{config_env()}.exs"
