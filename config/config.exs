# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config
      
config :plugapi, Plugapi.Repo,
      adapter: Ecto.Adapters.MySQL,
      database: "plugapi_repo",
      username: "root",
      password: "root",
      hostname: "localhost"

config :plugapi, ecto_repos: [Plugapi.Repo]