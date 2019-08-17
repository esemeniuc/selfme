defmodule SelfmeWeb.Resolvers.Queries do
  import SelfmeWeb.Schema.CustomTypes
  import Ecto.Query

  @spec get_credits(any, %{required(String.t()) => String.t()}, any) :: integer
  def get_credits(_parent, %{token: token}, _resolution) do
    credits = Selfme.Repo.one(from u in Selfme.User, select: u.credits, where: u.token == ^token)
    {:ok, credits}
  end

  @spec get_experiments(any, %{required(String.t()) => String.t()}, any) :: [:experiment]
  def get_experiments(_parent, %{token: token}, _resolution) do
    attractiveness_rows = Selfme.Repo.all(
      from e in Selfme.Experiment,
      #for token validation
      join: u in Selfme.User,
      on: u.id == e.user_id,
        #for getting stats
      join: v in Selfme.Vote,
      on: v.experiment_id == e.id,
      where: u.token == ^token,
      group_by: v.attractiveness,
      select: %{
        rating_type: v.attractiveness,
        count: count(v.id)
      },
      order_by: [
        desc: v.attractiveness
      ]
    )

    #returns %{like: [2], meh: [1]}
    #missing rating means 0
    attractiveness_data = Enum.group_by(attractiveness_rows, fn (row) -> row.rating_type end, fn (row) -> row.count end)
#Enum.at(b.meh, 0, 0)
    #Map.get(b, :dislike, [0])
    mock_experiment = %{
      attractiveness: %{
        dislikes: 1,
        mehs: 2,
        likes: 3,
      },
      fun: %{
        dislikes: 4,
        mehs: 5,
        likes: 6,
      },
      payload: "an image"
    }
    {:ok, [mock_experiment]}
  end

  @spec get_image(any, %{required(String.t()) => String.t()}, any) :: String.t()
  def get_image(_parent, %{experiment_id: experiment_id, token: token}, _resolution) do
    #    IO.puts(experiment_id)
    #    IO.puts(token)
    {:ok, "fakeImageConvertedToString"}
  end
end