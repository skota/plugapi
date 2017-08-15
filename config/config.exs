# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config
      
config :plugapi, Plugapi.Repo,
      adapter: Ecto.Adapters.MySQL,
      database: System.get_env("DATABASE"),
      username: System.get_env("USER"),
      password: System.get_env("PASSWORD"),
      hostname: System.get_env("HOST")

config :plugapi, ecto_repos: [Plugapi.Repo]