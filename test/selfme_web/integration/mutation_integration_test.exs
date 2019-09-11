defmodule SelfmeWeb.MutationIntegrationTest do
  @moduledoc false
  use SelfmeWeb.ConnCase, async: true

  describe "mutations" do
    test "create a new experiment" do
      createExperimentMutation = """
      mutation($token: String!) {
      createExperiment(image: "upload_fixture.txt", token: $token)
      }
      """
      upload = %Plug.Upload{
        content_type: "application/octet-stream",
        filename: "upload_fixture.txt",
        path: Path.expand("upload_fixture.txt", __DIR__)
      }

      variables = %{token: "poken1"}

      response =
        build_conn()
        |> post("/api", %{:query => createExperimentMutation, :variables => variables, "upload_fixture.txt" => upload})

      assert json_response(response, 200) == %{
               "data" => %{
                 "createExperiment" => "5"
               }
             }
    end

    test "work with voting on a experiment" do
      voteMutation = """
      mutation($experimentId: ID!, $token: String!, $attractiveness: Rating!, $fun: Rating!) {
      vote(experimentId: $experimentId,
      token: $token,
      attractiveness: $attractiveness,
      fun: $fun)
      }
      """

      variables = %{
        experimentId: 1,
        token: "poken4",
        attractiveness: "LIKE",
        fun: "MEH"
      }

      response =
        build_conn()
        |> post("/api", %{:query => voteMutation, :variables => variables})

      assert json_response(response, 200) == %{
               "data" => %{
                 "vote" => "95"
               }
             }
    end
  end

end
