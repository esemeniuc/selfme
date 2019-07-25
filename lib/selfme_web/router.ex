defmodule SelfmeWeb.Router do
  use SelfmeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: SelfmeWeb.Schema

    forward "/", Absinthe.Plug,
            schema: SelfmeWeb.Schema

  end

end