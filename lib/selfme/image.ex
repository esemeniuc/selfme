defmodule Selfme.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :payload, :binary

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:payload])
    |> validate_required([:payload])
  end
end
