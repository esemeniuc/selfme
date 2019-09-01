defmodule SelfmeWeb.Resolvers.Mutations do
  import SelfmeWeb.Schema.CustomTypes
  import Ecto.Query

  @spec create_experiment(any, %{required(:token) => String.t(), required(:image) => Plug.Upload}, any) :: String.t()
  def create_experiment(_parent, %{token: token, image: image}, _resolution) do
    {ok, contents} = File.read(image.path)
    if ok != :ok do
      {:error, "uploaded image not found error"}
    end
    user_id = Selfme.Repo.one(from u in Selfme.User, select: u.id, where: u.token == ^token)
    case Selfme.Repo.insert %Selfme.Experiment{user_id: user_id, payload: contents} do
      {:ok, struct} -> {:ok, struct.id}
      {:error, changeset} -> {:error, "token not found error"}
    end
  end

  @spec vote(
          any,
          %{
            required(:token) => String.t(),
            required(:experiment_id) => String.t(),
            required(:attractiveness) => :rating,
            required(:fun) => :rating
          },
          any
        ) :: integer
  def vote(
        _parent,
        %{token: token, experiment_id: experiment_id, attractiveness: attractiveness, fun: fun},
        _resolution
      ) do
    #    IO.puts(token)
    #    IO.puts(experiment_id)
    #    IO.puts(attractiveness)
    #    IO.puts(fun)
    {:ok, 95}
  end
end