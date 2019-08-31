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
      group_by: [v.attractiveness, e.id],
      select: %{
        experiment_id: e.id,
        rating_type: v.attractiveness,
        count: count(v.id)
      },
      order_by: [
        desc: v.attractiveness
      ]
    ) #returns %{like: [2], meh: [1]}, #missing rating means 0
    attractiveness_data = Enum.group_by(attractiveness_rows, fn (row) -> row.rating_type end, fn (row) -> row.count end)

    fun_rows = Selfme.Repo.all(
      from e in Selfme.Experiment,
      #for token validation
      join: u in Selfme.User,
      on: u.id == e.user_id,
        #for getting stats
      join: v in Selfme.Vote,
      on: v.experiment_id == e.id,
      where: u.token == ^token,
      group_by: v.fun,
      select: %{
        rating_type: v.fun,
        count: count(v.id)
      },
      order_by: [
        desc: v.fun
      ]
    )
    fun_data = Enum.group_by(fun_rows, fn (row) -> row.rating_type end, fn (row) -> row.count end)

    query_out = %{
      attractiveness: %{
        likes: List.first(Map.get(attractiveness_data, :like, [0])),
        mehs: List.first(Map.get(attractiveness_data, :meh, [0])),
        dislikes: List.first(Map.get(attractiveness_data, :dislike, [0])),
      },
      fun: %{
        likes: List.first(Map.get(fun_data, :like, [0])),
        mehs: List.first(Map.get(fun_data, :meh, [0])),
        dislikes: List.first(Map.get(fun_data, :dislike, [0])),
      },
      payload: "an image"
    }
    {:ok, [query_out]}
  end

  @spec get_image(any, %{required(String.t()) => String.t()}, any) :: String.t()
  def get_image(_parent, %{experiment_id: experiment_id, token: token}, _resolution) do
    #    IO.puts(experiment_id)
    #    IO.puts(token)
    {:ok, "fakeImageConvertedToString"}
  end
end

"""
  import Ecto.Query
  token = "poken2" #for bob
   attractiveness_rows = Selfme.Repo.all(
      from e in Selfme.Experiment,
      #for token validation
      join: u in Selfme.User,
      on: u.id == e.user_id,
        #for getting stats
      join: v in Selfme.Vote,
      on: v.experiment_id == e.id,
      where: u.token == ^token,
      group_by: [v.attractiveness, e.id],
      select: %{
        experiment_id: e.id,
        rating_type: v.attractiveness,
        count: count(v.id)
      },
      order_by: [
        desc: v.attractiveness
      ]
    )
      attractiveness_data = Enum.group_by(attractiveness_rows, fn (row) -> row.rating_type end, fn (row) -> row.count end)


"""