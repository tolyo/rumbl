defmodule Rumbl.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :text

      timestamps()
    end

  end
end
