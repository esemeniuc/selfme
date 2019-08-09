defmodule SelfmeWeb.MutationIntegrationTest do
  @moduledoc false
  use SelfmeWeb.ConnCase, async: true

  describe "mutations" do
    setup [:basic_opts]
    test "work with a valid required upload",%{opts: opts} do
      query = """
      mutation() {
      uploadImage(image: "a", token: "POKEN")
      }
      """

      upload = %Plug.Upload{}

      assert %{status: 200, resp_body: resp_body} =
               conn(:post, "/", %{"query" => query, "a" => upload})
               |> put_req_header("content-type", "multipart/form-data")
               |> call(opts)

      assert resp_body == %{
               "data" => %{
                 "uploadImage" => "someimageid"
               }
             }
    end
  end

  defp basic_opts(context) do
    Map.put(context, :opts, Absinthe.Plug.init(schema: TestSchema))
  end
end
