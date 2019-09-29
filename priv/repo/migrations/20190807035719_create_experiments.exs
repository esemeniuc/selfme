defmodule Selfme.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :payload, :binary, null: false

      timestamps()
    end

    create index(:experiments, [:user_id])
  end
end
