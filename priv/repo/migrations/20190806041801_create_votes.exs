defmodule Selfme.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :image_id, references(:images, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :attractiveness, :integer
      add :fun, :integer

      timestamps()
  end

    create index(:votes, [:image_id])
    create index(:votes, [:user_id])
  end
end
