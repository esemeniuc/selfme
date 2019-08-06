defmodule Rating do
  @behaviour Ecto.Type
  def type, do: :atom

  def cast(rating) when is_atom(rating) and rating in [:like, :meh, :dislike], do: {:ok, rating}
  def cast(rating) when is_integer(rating) and rating in -1..1 do
    case rating do
      1 -> {:ok, :like}
      0 -> {:ok, :meh}
      -1 -> {:ok, :disklike}
    end
  end
  # Everything else is a failure though
  def cast(_), do: :error

  # When loading data from the database
  def load(data) when is_atom(data) do
    cast(data)
  end

  # When dumping data to the database
  def dump(rating) when is_atom(rating) and rating in [:like, :meh, :dislike] do
    case rating do
      :like -> {:ok, 1}
      :meh -> {:ok, 0}
      :dislike -> {:ok, -1}
    end
  end
  def dump(_), do: :error
end
