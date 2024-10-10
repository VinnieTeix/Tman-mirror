defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller
  alias Todolist.Repo
  alias Todolist.Clock

  # GET /api/clocks/:user_id
  def index(conn, %{"user_id" => user_id}) do
    clocks = Repo.all(from c in Clock, where: c.user_id == ^user_id)
    json(conn, clocks)
  end

  # POST /api/clocks/:user_id
  def create(conn, %{"user_id" => user_id, "clock" => clock_params}) do
    changeset = Clock.changeset(%Clock{user_id: user_id}, clock_params)

    case Repo.insert(changeset) do
      {:ok, clock} -> conn |> put_status(:created) |> json(clock)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end
end
