defmodule Plugapi.Application do
  use Application

  # entry point to app. Runs eveytime app is started
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Plugapi.Web, []),
      supervisor(Plugapi.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Plugapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
