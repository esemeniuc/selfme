defmodule SelfmeWeb.Resolvers.Content do

  @spec get_credits(any, %{required(String.t()) => String.t()}, any) :: integer
  def get_credits(_parent, %{token: token}, _resolution) do
    IO.puts(token)
    {:ok, 0}
  end

  @spec get_experiments(any, %{required(String.t()) => String.t()}, any) :: [SelfmeWeb.Schema.ContentTypes.experiment]
  def get_experiments(_parent, args, _resolution) do
    IO.inspect(args)

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
      image_id: "an image id"
    }
    {:ok, [mock_experiment]}
  end

  @spec get_image(any, %{required(String.t()) => String.t()}, any) :: String.t()
  def get_image(_parent, %{token: token}, _resolution) do
    IO.puts(token)
#    IO.puts(imageId)
    {:ok, "fakeImageConvertedToString"}
  end

end