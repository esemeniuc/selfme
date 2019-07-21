defmodule SelfmeWeb.PageController do
  use SelfmeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
