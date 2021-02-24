defmodule Demos.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # alias Demos.Repo

      import Ecto
      import Ecto.Query
      import Demos.RepoCase 
      # other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(SimpleWeb.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(SimpleWeb.Repo, {:shared, self()})
    end

    :ok
  end
end
