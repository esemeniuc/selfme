defmodule Selfme.Schema do
  use Absinthe.Schema
  alias Selfme.Resolvers

  query do
    @desc "Get all posts"
    field :posts, :integer do
      resolve &Resolvers.Content.list_posts/3
    end

  end

end