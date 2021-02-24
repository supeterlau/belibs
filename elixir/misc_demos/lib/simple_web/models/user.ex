defmodule SimpleWeb.User do
  use Ecto.Schema

  schema "simple_web_users" do
    # implicit id field
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end
end
