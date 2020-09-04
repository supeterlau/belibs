# Configure your database
config :phx_tour, PhxTour.Repo,
  username: "postgres",
  password: "postgres",
  database: "phx_tour_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
