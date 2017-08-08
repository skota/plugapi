defmodule Plugapi.Mixfile do
  use Mix.Project

  def project do
    [app: :plugapi,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger,:guardian, :plug, :cowboy, :comeonin, :ecto, :mariaex, :poison, :jose, :joken],
     mod: {Plugapi.Application, []}]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [ {:guardian, "~> 0.14"},
      {:plug, "~> 1.4"},
      {:cowboy, "~> 1.1"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 0.12"},
      {:mariaex, "~> 0.8.2"},
      {:ecto, "~> 2.1"},
      {:poison, "~> 3.1"},
      {:jose, "~> 1.8"},
      {:joken, "~> 1.5"}
    ]
  end
end
