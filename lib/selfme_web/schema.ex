defmodule SelfmeWeb.Schema do
  use Absinthe.Schema
  alias SelfmeWeb.Resolvers

  query do
    @desc "Gets the credit count for a user"
    field :get_credits, :integer do
      arg :token, non_null(:string)
      resolve &Resolvers.Content.get_credits/3
    end

    @desc "Gets the experiments for a user"
    field :get_experiments, non_null(list_of(non_null(:integer))) do
      arg :token, non_null(:string)
      resolve &Resolvers.Content.get_experiments/3
    end

#    @desc "Gets an image for the user to vote on"
#    field :get_image, :integer do
#      arg :token, non_null(:string)
#      resolve &Resolvers.Content.get_image/3
#    end

  end

end