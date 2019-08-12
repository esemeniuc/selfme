defmodule SelfmeWeb.MutationIntegrationTest do
  @moduledoc false
  use SelfmeWeb.ConnCase, async: true

  describe "mutations" do
    test "work with a valid required upload" do
      uploadImageMutation = """
      mutation($token: String!) {
      uploadImage(image: "upload_fixture.txt", token: $token)
      }
      """
      upload = %Plug.Upload{
        content_type: "application/octet-stream",
        filename: "upload_fixture.txt",
        path: Path.expand("upload_fixture.txt", __DIR__)
      }

      variables = %{token: "poken"}

      response =
        build_conn()
        |> post("/api", %{:query => uploadImageMutation, :variables => variables, "upload_fixture.txt" => upload})

      assert json_response(response, 200) == %{
               "data" => %{
                 "uploadImage" => "someimageid"
               }
             }
    end
  end

end
