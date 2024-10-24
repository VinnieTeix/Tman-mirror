defmodule TmanWeb.UserJSON do
  alias Tman.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  @doc """
  Renders user and token.
  """
  def show_user_and_token(%{user: user, token: token}) do
    %{user: data(user), token: token}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }
  end
end
