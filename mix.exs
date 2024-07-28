defmodule Plugapi.MixProject do
  use Mix.Project

  def project do
    [
      app: :plugapi,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Plugapi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.5"},
      # new dependencies
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:json, "~> 1.4"}
    ]
  end
end
