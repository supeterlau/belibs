use Mix.Config

config :ecto_tour, EctoTour.Repo,
  username: "dg_db_admin",
  password: "NGFmNTYyOWJlZDk",
  database: "ecto_tour_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
