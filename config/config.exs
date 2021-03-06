# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :lightning, Lightning.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "9jkeCz9SqGwgKyneq1Df1+KQ5fRZcHJhYSU33xNgl+urtJqGkZQgGjDjRwDtqG01",
  debug_errors: false,
  pubsub: [name: Lightning.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :hound, driver: "phantomjs", host: "localhost", port: 8910
config :hound, driver: "selenium"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
