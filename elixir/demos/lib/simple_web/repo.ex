defmodule SimpleWeb.Repo do
  use Ecto.Repo,
    otp_app: :demos,
    adapter: Ecto.Adapters.Postgres
end
