defmodule Demos.MixProject do
  use Mix.Project

  def project do
    [
      app: :demos,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        # :sqlite_ecto,
        # :ecto,
        # :cowboy,
        # :plug
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      # {:cowboy, "~> 2.8"},
      # {:plug, "~> 1.11"},
      
      # {:sqlite_ecto, "~> 1.1"},
      # {:ecto, "~> 3.5"}
      # {:ecto, "~> 1.1"}

      # {:cowboy, ">= 0.0.0"},
      # {:plug, ">= 0.0.0"},
      # {:sqlite_ecto, ">= 0.0.0"},
      # {:ecto, ">= 0.0.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
