defmodule SelfmeWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  @desc "An experiment"
  object :experiment do
    field :attractiveness, :stat_tuple
    field :fun, :stat_tuple
    field :image_id, :string
  end

  @desc "A Tuple of Statistics"
  object :stat_tuple do
    field :dislikes, :integer
    field :mehs, :integer
    field :likes, :integer
  end
end