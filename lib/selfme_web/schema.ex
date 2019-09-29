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
      arg :experiment_id, non_null(:id)
      arg :token, non_null(:string)
      resolve &Resolvers.Queries.get_image/3
    end
  end

  mutation do
    @desc "Creates a new experiment for user with token, returns experiment id if successful"
    field :create_experiment, :id do
      arg :image, non_null(:upload)
      arg :token, non_null(:string)
      resolve &Resolvers.Mutations.create_experiment/3
    end

    @desc "Vote on an experiment, returns experiment id if successful"
    field :vote, :id do
      arg :experiment_id, non_null(:id)
      arg :attractiveness, non_null(:rating)
      arg :fun, non_null(:rating)
      arg :token, non_null(:string)
      resolve &Resolvers.Mutations.vote/3
    end
  end

end