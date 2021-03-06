defmodule Http.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # {Http, port: 8000}

      # {Http.PlugAdapter, plug: CurrentTime, port: 8000},
      # {Http.PlugAdapter, plug: Plug.Octopus, port: 8000},

      # {Plug.Cowboy, scheme: :http, plug: HelloPlug, options: [port: 8000]},
      {Plug.Cowboy, scheme: :http, plug: HelloRouter, options: [port: 8000]}
    ]
    opts = [strategy: :one_for_one, name: Http.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
