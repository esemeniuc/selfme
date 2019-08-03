defmodule Selfme.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :credits, :integer
    field :email, :string
    field :pass, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :pass, :token, :credits])
    |> validate_required([:email, :pass, :token, :credits])
    |> unique_constraint(:email)
  end
end
