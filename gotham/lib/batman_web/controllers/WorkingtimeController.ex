defmodule TodolistWeb.WorkingTimeController do
  use TodolistWeb, :controller
  alias Todolist.Repo
  alias Todolist.Workingtime

  # GET /api/workingtime/:user_id
  def index(conn, %{"user_id" => user_id}) do
    working_times = Repo.all(from w in Workingtime, where: w.user_id == ^user_id)
    json(conn, working_times)
  end

  # GET /api/workingtime/:user_id/:id
  def show(conn, %{"user_id" => user_id, "id" => id}) do
    working_time = Repo.get(Workingtime, id)

    case working_time do
      nil -> send_resp(conn, :not_found, "Working time not found")
      working_time -> json(conn, working_time)
    end
  end

  # POST /api/workingtime/:user_id
  def create(conn, %{"user_id" => user_id, "workingtime" => workingtime_params}) do
    changeset = Workingtime.changeset(%Workingtime{user_id: user_id}, workingtime_params)

    case Repo.insert(changeset) do
      {:ok, working_time} -> conn |> put_status(:created) |> json(working_time)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  # PUT /api/workingtime/:id
  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    working_time = Repo.get(Workingtime, id)

    case working_time do
      nil -> send_resp(conn, :not_found, "Working time not found")
      working_time ->
        changeset = Workingtime.changeset(working_time, workingtime_params)

        case Repo.update(changeset) do
          {:ok, working_time} -> json(conn, working_time)
          {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
        end
    end
  end

  # DELETE /api/workingtime/:id
  def delete(conn, %{"id" => id}) do
    working_time = Repo.get(Workingtime, id)

    case working_time do
      nil -> send_resp(conn, :not_found, "Working time not found")
      working_time ->
        Repo.delete(working_time)
        send_resp(conn, :no_content, "")
    end
  end
end
