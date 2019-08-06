defmodule Selfme.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :pass, :string, null: false
      add :token, :string, null: false
      add :credits, :integer, null: false

      timestamps()
    end

    create unique_index(:users, [:email])

  end
end