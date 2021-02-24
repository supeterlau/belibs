import Config

config :demos, ecto_repos: [
  SimpleWeb.Repo
]

import_config "#{Mix.env()}.exs"
