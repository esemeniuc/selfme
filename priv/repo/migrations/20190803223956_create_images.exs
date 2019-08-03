defmodule Selfme.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :payload, :binary

      timestamps()
    end

  end
end
