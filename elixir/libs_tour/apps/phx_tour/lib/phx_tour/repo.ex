defmodule PhxTour.Repo do
  use Ecto.Repo,
    otp_app: :phx_tour,
    adapter: Ecto.Adapters.Postgres
end
