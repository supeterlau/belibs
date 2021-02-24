ExUnit.start()

{:ok, _pid} = SimpleWeb.Repo.start_link()

Ecto.Adapters.SQL.Sandbox.mode(SimpleWeb.Repo, :manual)
