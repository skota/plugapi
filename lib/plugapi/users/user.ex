defmodule Plugapi.Users.User do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :confirmed_at, :naive_datetime
    timestamps(type: :utc_datetime)
  end


end
