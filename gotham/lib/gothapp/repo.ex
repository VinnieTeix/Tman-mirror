defmodule Tman.Repo do
  use Ecto.Repo,
    otp_app: :gothapp,
    adapter: Ecto.Adapters.Postgres
end
