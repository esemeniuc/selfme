defmodule SelfmeWeb.Resolvers.Queries do
  import SelfmeWeb.Schema.CustomTypes
  import Ecto.Query

  @spec get_credits(any, %{required(String.t()) => String.t()}, any) :: integer
  def get_credits(_parent, %{token: token}, _resolution) do
    credits = Selfme.Repo.one(from u in Selfme.User, select: u.credits, where: u.token == ^token)
    {:ok, credits}
  end

  #returns experiment_id -> rating count
  # %{
  #  3 => %{dislikes: 0, experiment_id: 3, likes: 2, mehs: 1},
  #  4 => %{dislikes: 2, experiment_id: 4, likes: 0, mehs: 0}
  #}
  def get_experiments_helper(query_result) do
    get_scalar = fn (map, key) -> List.first(Map.get(map, key, [0])) end
    query_result
    |> Enum.group_by(fn (row) -> row.experiment_id end, fn (row) -> row end) #group by experiment
    |> Enum.map(
         #group by rating
         fn ({experiment_id, list_of_grouped_ratings}) ->
           grouped_ratings = Enum.group_by(
             list_of_grouped_ratings,
             fn (row) -> row.rating_type end,
             fn (row) -> row.count end
           )
           {
             experiment_id,
             %{
               likes: get_scalar.(grouped_ratings, :like),
               mehs: get_scalar.(grouped_ratings, :meh),
               dislikes: get_scalar.(grouped_ratings, :dislike),
             }
           }
         end
       )
    |> Enum.into(%{}) #make back into map
  end

  @spec get_experiments(any, %{required(String.t()) => String.t()}, any) :: [:experiment]
  def get_experiments(_parent, %{token: token}, _resolution) do
    attractiveness_query = Selfme.Repo.all(
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
    fun_query = Selfme.Repo.all(
      from e in Selfme.Experiment,
      #for token validation
      join: u in Selfme.User,
      on: u.id == e.user_id,
        #for getting stats
      join: v in Selfme.Vote,
      on: v.experiment_id == e.id,
      where: u.token == ^token,
      group_by: [v.fun, e.id],
      select: %{
        experiment_id: e.id,
        rating_type: v.fun,
        count: count(v.id)
      },
      order_by: [
        desc: v.fun
      ]
    )
    query_out = Map.merge(
                  get_experiments_helper(attractiveness_query),
                  get_experiments_helper(fun_query),
                  fn _experiment_id, attractiveness, fun ->
                    %{attractiveness: attractiveness, fun: fun}
                  end
                )
                |> Map.to_list
                |> Enum.map(
                     fn {experiment_id, attractiveness_fun_stat_tuple} ->
                       %{
                         experiment_id: experiment_id,
                         attractiveness: attractiveness_fun_stat_tuple.attractiveness,
                         fun: attractiveness_fun_stat_tuple.fun,
                         imageId: "this is an image"
                       }
                     end
                   )

    {:ok, query_out}
  end

  @spec get_image(any, %{required(String.t()) => String.t()}, any) :: String.t()
  def get_image(_parent, %{experiment_id: experiment_id, token: token}, _resolution) do
    image = Selfme.Repo.one(
      from e in Selfme.Experiment,
      join: u in Selfme.User,
      on: u.id == e.user_id,
      where: u.token == ^token and e.id == ^experiment_id,
      select: e.payload
    )
    {:ok, image}
  end
end