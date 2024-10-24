defmodule Tman.Teams do
  @moduledoc """
  The Teams context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias Tman.Repo

  alias Tman.Teams.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Add user to team.
  """
  def add_user_to_team(user_id, team_id) do
    case check_if_user_in_team(user_id, team_id) do
      {:ok, _} ->
        team = get_team!(team_id)
        users = team.users
        new_users = Enum.concat(users, [user_id])
        with {:ok, %Team{} = team} <- update_team(team, %{"users" => new_users}) do
          {:ok, team}
        end

      {:error, _} ->
        {:error, "User already in team"}
    end
  end

  defp check_if_user_in_team(user_id, team_id) do
    team = get_team!(team_id)
    users = team.users
    if Enum.member?(users, user_id) do
      {:error, "User already in team"}
    else
      {:ok, "User not in team"}
    end
  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
