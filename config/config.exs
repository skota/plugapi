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

# config for guardian - ignore ..going to remove this...
config :guardian, Guardian,
      allowed_algos: ["HS512"], # optional
      verify_module: Guardian.JWT,  # optional
      issuer: "Plugapi",
      ttl: { 30, :days },
      allowed_drift: 2000,
      verify_issuer: true, # optional
      secret_key: 'superdupersecret123',
      serializer: Plugapi.GuardianSerializer

