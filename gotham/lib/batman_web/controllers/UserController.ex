defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  alias Todolist.Repo
  alias Todolist.User

  # GET /api/users
  def index(conn, _params) do
    users = Repo.all(User)
    json(conn, users)
  end

  # GET /api/users/:userID
  def show(conn, %{"userID" => id}) do
    user = Repo.get(User, id)
    render(conn, :show, user: user)
  end

  # POST /api/users
  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} -> conn |> put_status(:created) |> json(user)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  # PUT /api/users/:id
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)

    case user do
      nil -> send_resp(conn, :not_found, "User not found")
      user ->
        changeset = User.changeset(user, user_params)

        case Repo.update(changeset) do
          {:ok, user} -> json(conn, user)
          {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
        end
    end
  end

  # DELETE /api/users/:id
  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)

    case user do
      nil -> send_resp(conn, :not_found, "User not found")
      user ->
        Repo.delete(user)
        send_resp(conn, :no_content, "")
    end
  end
end
