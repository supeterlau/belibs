defmodule SimpleWeb.Repo.Migrations.CreateSimpleWebUsers do
  use Ecto.Migration

  def change do
    create table(:simple_web_users) do
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end
  end
end
