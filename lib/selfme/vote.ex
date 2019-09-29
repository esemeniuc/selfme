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

  def parse(vote) do
    changeset(%Selfme.Vote{}, Map.from_struct(vote))
    |> apply_changes
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:experiment_id, :user_id, :attractiveness, :fun])
    |> validate_required([:experiment_id, :user_id, :attractiveness, :fun])
  end
end
