defmodule EctoTour.Person do
  use Ecto.Schema

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :last_name, :age])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])

    # Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} -> {msg, opts}end)
    # 参数为 changeset 而非 changeset.errors
    # Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} -> 
    #   Enum.reduce(opts, msg, fn {key, value}, acc -> 
    #     String.replace(acc, "%{#{key}}", to_string(value))
    #   end)
    # end)
  end
end
