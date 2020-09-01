defmodule EctoTour.Tag do
  use Ecto.Schema

  schema "tags" do
    field :name

    timestamps()
  end
end
