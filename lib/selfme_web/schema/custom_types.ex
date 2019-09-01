defmodule SelfmeWeb.Schema.CustomTypes do
  use Absinthe.Schema.Notation

  @desc "An experiment"
  object :experiment do
    field :experiment_id, non_null(:id)
    field :attractiveness, non_null(:stat_tuple)
    field :fun, non_null(:stat_tuple)
    field :image_id, non_null(:string)
  end

  @desc "A Tuple of Statistics"
  object :stat_tuple do
    field :dislikes, non_null(:integer)
    field :mehs, non_null(:integer)
    field :likes, non_null(:integer)
  end

  @desc "A Rating on an Image"
  enum :rating, values: [:like, :meh, :dislike]
end