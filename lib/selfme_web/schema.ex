defmodule SelfmeWeb.Schema do
  use Absinthe.Schema
  alias SelfmeWeb.Resolvers

  query do
    @desc "Get all posts"
    field :posts, :integer do
      resolve &Resolvers.Content.list_posts/3
    end

  end

end