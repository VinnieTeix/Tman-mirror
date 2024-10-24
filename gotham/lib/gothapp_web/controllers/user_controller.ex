defmodule TmanWeb.UserController do
  use TmanWeb, :controller

  alias Tman.Users
  alias Tman.Users.User
  alias Tman.Auth.Token
  require Logger

  action_fallback(TmanWeb.FallbackController)

  def get_all_users(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user_by_id(id)
    render(conn, :show, user: user)
  end

  def get_user_by_id(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get_user_by_id(id) do
      render(conn, :show, user: user)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "user with id: #{id} not found"})
    end
  end

  def get_user_by_email_and_username(conn, %{"email" => email, "username" => username}) do
    with {:ok, user} <- Users.get_user_by_email_and_username(email, username) do
      render(conn, :show, user: user)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "user with email: #{email} and username: #{username} not found"})
    end
  end

  def create_user(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render("show.json", user: user)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: TmanWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def login_user(conn, %{"email" => email, "password" => password}) do
    Logger.info("login_user: #{email}")

    with {:ok, %User{} = user} <- Users.authenticate_user(email, password) do
      claims = %{
        "id" => user.id,
        "role" => user.role
      }

      {:ok, token, _claims} = Token.generate_and_sign(claims)

      conn
      |> put_status(:ok)
      |> put_resp_cookie("token", token, http_only: true)
      |> put_session(:csrf_token, Plug.CSRFProtection.get_csrf_token())

      render(conn, :show_user_and_token, user: user, token: token)
    else
      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "user with email: #{email} not found"})
    end
  end

  def update_user(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, %User{} = user} <- Users.get_user_by_id(id),
         {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "user with id: #{id} not found"})
    end
  end

  def delete_user(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get_user_by_id(id),
         {:ok, %User{} = user} <- Users.delete_user(user) do
      render(conn, :show, user: user)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "user with id: #{id} not found"})
    end
  end
end
