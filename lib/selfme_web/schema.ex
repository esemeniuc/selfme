defmodule SelfmeWeb.Schema do
  use Absinthe.Schema
  alias SelfmeWeb.Resolvers
  import_types SelfmeWeb.Schema.CustomTypes #for :experiment type
  import_types Absinthe.Plug.Types  # for :upload` type

  query do
    @desc "Gets the credit count for a user"
    field :get_credits, :integer do
      arg :token, non_null(:string)
      resolve &Resolvers.Queries.get_credits/3
    end

    @desc "Gets the experiments for a user"
    field :get_experiments, non_null(list_of(non_null(:experiment))) do
      arg :token, non_null(:string)
      resolve &Resolvers.Queries.get_experiments/3
    end

    @desc "Gets an image for the user to vote on"
    field :get_image, :string do
      arg :experiment_id, non_null(:string)
      arg :token, non_null(:string)
      resolve &Resolvers.Queries.get_image/3
    end
  end

  mutation do
    @desc "Gets an image for the user to vote on"
    field :upload_image, :string do
      arg :token, non_null(:string)
      arg :image, non_null(:upload)
      resolve &Resolvers.Mutations.upload_image/3
    end

    @desc "Vote on a User Image"
    field :vote, :integer do
      arg :token, non_null(:string)
      arg :experiment_id, non_null(:string)
      arg :attractiveness, non_null(:rating)
      arg :fun, non_null(:rating)
      resolve &Resolvers.Mutations.vote/3
    end
  end

end