# General application configuration
import Config

# replace with your db credentials
config :plugapi, Plugapi.Repo,
  username: "sriramkota",
  password: "",
  hostname: "localhost",
  database: "sampleapp_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
