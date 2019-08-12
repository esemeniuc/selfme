defmodule SelfmeWeb.Resolvers.Mutations do
  import SelfmeWeb.Schema.CustomTypes

  @spec upload_image(any, %{required(:token) => String.t(), required(:image) => Plug.Upload}, any) :: String.t()
  def upload_image(_parent, %{token: token, image: image}, _resolution) do
#    IO.puts(token)
#    IO.inspect(image)
    {ok, contents} = File.read(image.path)
#    IO.puts(ok)
#    IO.puts(contents)
    {:ok, "someimageid"}
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
  def vote(_parent, %{token: token, experiment_id: experiment_id, attractiveness: attractiveness, fun: fun}, _resolution) do
#    IO.puts(token)
#    IO.puts(experiment_id)
#    IO.puts(attractiveness)
#    IO.puts(fun)
    {:ok, 95}
  end
end