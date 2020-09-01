defmodule EctoTour.Post do
  alias Ecto.Changeset

  alias EctoTour.Repo
  alias EctoTour.Tag

  use Ecto.Schema

  schema "posts" do
    field :title
    field :body
    field :visits

    many_to_many :tags, EctoTour.Tag,
      join_through: "posts_tags",
      on_replace: :delete

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:title, :body])
    |> Changeset.put_assoc(:tags, parse_tags(params))
  end

  defp parse_tags(params) do
    (params["tags"] || "") 
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Repo.get_by(Tag, name: name) || Repo.insert!(%Tag{name: name})
  end
end
