defmodule EctoTour.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias EctoTour.Repo

      import Ecto
      import Ecto.Query
      import EctoTour.RepoCase
    end
  end

  setup tags do
    # checkouts a database connectio
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EctoTour.Repo)

    # 当测试不在 async 模式下时，启动共享 sandbox 连接模式
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EctoTour.Repo, {:shared, self()})
    end

    :ok
  end
end
