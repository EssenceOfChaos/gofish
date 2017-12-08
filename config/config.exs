# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gofish,
  ecto_repos: [Gofish.Repo]

# Configures the endpoint
config :gofish, GofishWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v26htsyx/b2r0TNT5SBQY5AlOnlbW5ehMfDog1dzxPlNXgg0Lar8mQ7BDZMSvoex",
  render_errors: [view: GofishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gofish.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
