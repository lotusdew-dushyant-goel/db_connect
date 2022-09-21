import Config

# configuring mnesia
config :mnesia, dir: '.mnesia/#{Mix.env()}/#{node()}'

import_config "#{config_env()}.exs"
