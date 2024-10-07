defmodule Todolist.Repo do
  use Ecto.Repo,
    otp_app: :tman,
    adapter: Ecto.Adapters.Postgres
end
