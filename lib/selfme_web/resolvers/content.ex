defmodule SelfmeWeb.Resolvers.Content do

  @spec get_credits(any, %{required(String.t()) => String.t()}, any) :: integer
  def get_credits(_parent, %{token: token}, _resolution) do
    IO.puts(token)
    {:ok, 0}
  end

#  @spec get_experiments(any, %{required(string) => string}, any) :: [experiment]
  def get_experiments(_parent, args, _resolution) do
    IO.inspect(args)
    {:ok, [0,1]}
  end

#  @spec get_image(any, %{required(string) => string}, any) :: successResponse
#  #  token, imageid
#  def get_image(_parent, _args, _resolution) do
#    {:ok, 0}
#  end

end