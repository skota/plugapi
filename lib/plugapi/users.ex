defmodule Plugapi.Users do
  import Ecto.Query, warn: false
  alias Plugapi.Repo
  alias Plugapi.Users.User

  def get_users() do
    Repo.all(User)
  end

end
