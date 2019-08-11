defmodule SelfmeWeb.MutationIntegrationTest do
  @moduledoc false
  use SelfmeWeb.ConnCase, async: true

  describe "mutations" do
    #    setup [:basic_opts]
    @query"""
    mutation() {
    uploadImage(image: "file_data_attribute_arbitraty_name", token: "POKEN")
    }
    """

    test "work with a valid required upload" do
      upload = %Plug.Upload{
        content_type: "text/csv",
        filename: "users.csv",
        path: Path.expand("../../Downloads/output.xml", __DIR__)
      }

      resp =
        conn
        |> post("/api", %{"query" => @query, "file_data_attribute_arbitraty_name" => upload})

      decode_response = response(resp, 200)

      #      assert %{status: 200, resp_body: resp_body} =
      #               conn(:post, "/", %{"query" => query, "a" => upload})
      #               |> put_req_header("content-type", "multipart/form-data")
      #               |> call(opts)
      #
      #      assert resp_body == %{
      #               "data" => %{
      #                 "uploadImage" => "someimageid"
      #               }
      #             }
    end
  end

  #  defp basic_opts(context) do
  #    Map.put(context, :opts, Absinthe.Plug.init(schema: TestSchema))
  #  end
end
