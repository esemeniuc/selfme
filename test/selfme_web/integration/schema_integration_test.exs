defmodule SelfmeWeb.SchemaIntegrationTest do
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
  end
end
