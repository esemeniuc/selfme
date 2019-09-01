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
    @desc "Creates a new experiment for user with token"
    field :create_experiment, :string do
      arg :image, non_null(:upload)
      arg :token, non_null(:string)
      resolve &Resolvers.Mutations.create_experiment/3
    end

    @desc "Vote on a User Image"
    field :vote, :integer do
      arg :experiment_id, non_null(:string)
      arg :attractiveness, non_null(:rating)
      arg :fun, non_null(:rating)
      arg :token, non_null(:string)
      resolve &Resolvers.Mutations.vote/3
    end
  end

end