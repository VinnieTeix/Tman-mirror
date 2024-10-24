defmodule Tman.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias Tman.Repo

  alias Tman.Users.User

  @doc """
  Lists all users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user by ID.
  """
  def get_user_by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Gets a single user by email and username.
  """
  def get_user_by_email_and_username(email, username) do
    case Repo.get_by(User, email: email, username: username) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def get_user_by_email(email) do
    Logger.info("get_user_by_email: #{email}")

    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    case %User{}
         |> User.changeset(attrs)
         |> hash_password()
         |> Repo.insert() do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        hashed_password = Bcrypt.hash_pwd_salt(password)
        Ecto.Changeset.put_change(changeset, :password, hashed_password)

      _ ->
        changeset
    end
  end

  @doc """
  Authenticates a user by email and password and returns a token.
  """
  def authenticate_user(email, password) do
    Logger.info("authenticate_user: #{email}")

    case get_user_by_email(email) do
      {:ok, user} ->
        case Bcrypt.verify_pass(password, user.password) do
          true ->
            {:ok, user}

          false ->
            {:error, :unauthorized}
        end

      {:error, _} ->
        {:error, :unauthorized}
    end
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    case user
         |> User.changeset(attrs)
         |> Repo.update() do
      {:ok, updated_user} -> {:ok, updated_user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    case Repo.delete(user) do
      {:ok, deleted_user} -> {:ok, deleted_user}
      {:error, _changeset} -> {:error, :not_found}
    end
  end
end
