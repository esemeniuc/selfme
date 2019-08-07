defmodule Selfme.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :experiment_id, :id
    field :user_id, :id
    field :attractiveness, Rating
    field :fun, Rating

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, []) #TODO add requirements
    |> validate_required([])
  end
end
