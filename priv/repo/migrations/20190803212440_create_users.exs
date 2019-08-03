defmodule Selfme.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :email, :string, primary_key: true
      add :pass, :string, null: false
      add :token, :string, null: false
      add :credits, :integer, null: false

      timestamps()
    end

  end
end
