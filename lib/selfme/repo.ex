defmodule Selfme.Repo do
  use Ecto.Repo,
    otp_app: :selfme,
    adapter: Ecto.Adapters.Postgres
end
