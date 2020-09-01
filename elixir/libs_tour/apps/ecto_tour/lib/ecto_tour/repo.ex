defmodule EctoTour.Repo do
  use Ecto.Repo,
    otp_app: :ecto_tour,
    adapter: Ecto.Adapters.Postgres
end
