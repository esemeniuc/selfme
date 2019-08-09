defmodule SelfmeWeb.QueryIntegrationTest do
  @moduledoc false
  use SelfmeWeb.ConnCase, async: true

  describe "queries" do
    test "gets the credits for a user with $token" do
      getCredits = """
      query($token: String!){
      getCredits(token: $token)
      }
      """
      variables = %{token: "poken"}

      response =
        build_conn()
        |> post("/api", %{query: getCredits, variables: variables})

      assert json_response(response, 200) == Jason.decode!(
               """
               {
                 "data": {
                   "getCredits": 0
                 }
               }
               """
             )
    end

    test "gets the experiments for a user" do
      getExperiments = """
      query($token: String!) {
        getExperiments(token: $token){
          attractiveness{
            dislikes
            likes
            mehs
          }
          fun{
            dislikes
            likes
            mehs
          }
        }
      }
      """
      variables = %{token: "poken"}

      response =
        build_conn()
        |> post("/api", %{query: getExperiments, variables: variables})

      assert json_response(response, 200) == Jason.decode!(
               """
               {
               "data": {
               "getExperiments": [
               {
               "attractiveness": {
               "dislikes": 1,
               "likes": 3,
               "mehs": 2
               },
               "fun": {
               "dislikes": 4,
               "likes": 6,
               "mehs": 5
               }
               }
               ]
               }
               }
               """
             )
    end

    test "gets the image for an experiment owned by a user with $token" do
      getImages = """
      query($experimentId: String!, $token: String!){
      getImage(experimentId: $experimentId, token: $token)
      }
      """
      variables = %{experimentId: "magic", token: "poken"}

      response =
        build_conn()
        |> post("/api", %{query: getImages, variables: variables})

      assert json_response(response, 200) == Jason.decode!(
               """
               {
               "data": {
               "getImage": "fakeImageConvertedToString"
               }
               }
               """
             )
    end

  end
end
