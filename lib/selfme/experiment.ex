defmodule Selfme.Experiment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experiments" do
    field :user_id, :id
    field :payload, :binary

    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:user_id, :payload])
    |> validate_required([:user_id, :payload])
  end
end
