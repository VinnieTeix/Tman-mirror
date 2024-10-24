defmodule TmanWeb.TeamJSON do
  alias Tman.Teams.Team

  @doc """
  Renders a list of teams.
  """
  def index(%{teams: teams}) do
    for(team <- teams, do: data(team))
  end

  @doc """
  Renders a single team.
  """
  def show(%{team: team}) do
    data(team)
  end

  defp data(%Team{} = team) do
    %{
      id: team.id,
      users: team.users,
      team_leader: team.team_leader
    }
  end
end
