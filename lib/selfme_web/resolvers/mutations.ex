defmodule SelfmeWeb.Resolvers.Mutations do
  import SelfmeWeb.Schema.CustomTypes
  import Ecto.Query

  @spec create_experiment(any, %{required(:token) => String.t(), required(:image) => Plug.Upload}, any) :: :id
  def create_experiment(_parent, %{token: token, image: image}, _resolution) do
    with {:ok, contents} <- File.read(image.path),
         user_id = Selfme.Repo.one(from u in Selfme.User, select: u.id, where: u.token == ^token),
         {:ok, struct} <- Selfme.Repo.insert %Selfme.Experiment{user_id: user_id, payload: contents} do
            {:ok, struct.id}
       else
      {:error, posix} -> {:error, "failed to get uploaded image"}
      {:error, _} -> {:error, "failed to create create experiment"}
    end

  end

  @spec vote(
          any,
          %{
            required(:token) => String.t(),
            required(:experiment_id) => :id,
            required(:attractiveness) => :rating,
            required(:fun) => :rating
          },
          any
        ) :: :id
  def vote(
        _parent,
        %{token: token, experiment_id: experiment_id, attractiveness: attractiveness, fun: fun},
        _resolution
      ) do
    user_id = Selfme.Repo.one(from u in Selfme.User, select: u.id, where: u.token == ^token)
    experiment_user_id = Selfme.Repo.one(from e in Selfme.Experiment, select: e.user_id, where: e.id == ^experiment_id)
#    if experiment_user_id == user_id do
#      return {:error, "error: can't vote on your own experiment"}
#    end
    to_insert = Selfme.Vote.parse(%Selfme.Vote{
      experiment_id: experiment_id,
      user_id: user_id,
      attractiveness: attractiveness,
      fun: fun
    })
    require IEx; IEx.pry
    case Selfme.Repo.insert to_insert do
      {:ok, struct} -> {:ok, struct.id}
      {:error, changeset} -> {:error, "error voting on experiment"}
    end
  end
end