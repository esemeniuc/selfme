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
      attractiveness_data = Enum.group_by(attractiveness_rows, fn (row) -> row.experiment_id end, fn (row) -> row end)
 a = %{
  3 => [
    %{count: 2, experiment_id: 3, rating_type: :like},
    %{count: 1, experiment_id: 3, rating_type: :meh}
  ],
  4 => [%{count: 2, experiment_id: 4, rating_type: :dislike}]
}
a |> Enum.map(fn ({experiment_id, list_of_grouped_ratings}) -> {experiment_id, Enum.group_by(list_of_grouped_ratings, fn(row) -> row.rating_type end, fn(row) -> row.count end)} end) |> Enum.into(%{})
b = %{3 => %{like: [2], meh: [1]}, 4 => %{dislike: [2]}}
  get_scalar = fn (map, key) -> List.first(Map.get(map, key, [0])) end
 c = Enum.map(Map.to_list(b), fn({experiment_id, ratings}) -> %{
        experiment_id: experiment_id,
        likes: get_scalar.(ratings, :like),
        mehs: get_scalar.(ratings,:meh),
        dislikes: get_scalar.(ratings,:dislike),
  } end)

#wish
  #[%{experiment_id: 3, dislike: 2, like: 2, meh: 1}] #temporary form

"""