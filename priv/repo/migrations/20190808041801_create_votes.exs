defmodule Selfme.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :experiment_id, references(:experiments, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :attractiveness, :integer, null: false
      add :fun, :integer, null: false

      timestamps()
    end

    create index(:votes, [:experiment_id])
    create index(:votes, [:user_id])
    create unique_index(:votes, [:experiment_id, :user_id])
  end
end
