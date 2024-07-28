defmodule Plugapi.Repo do
  use Ecto.Repo,
    otp_app: :plugapi,
    adapter: Ecto.Adapters.Postgres
end
