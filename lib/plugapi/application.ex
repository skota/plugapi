defmodule Plugapi.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plugapi.Repo,
      {Bandit, plug: Plugapi.Router},
    ]

    opts = [strategy: :one_for_one, name: Plugapi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
