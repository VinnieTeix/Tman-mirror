defmodule TmanWeb.TeamController do
  use TmanWeb, :controller

  alias Tman.Teams
  alias Tman.Teams.Team
  require Logger

  action_fallback TmanWeb.FallbackController

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, :index, teams: teams)
  end

  def create_team(conn, team_params) do
    Logger.info("create_team: #{inspect(team_params)}")
    with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: TmanWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def add_user_to_team(conn, %{
    "user_id" => user_id,
    "team_id" => team_id
  }) do

    with {:ok, %Team{} = team} <- Teams.add_user_to_team(user_id, team_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: TmanWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, :show, team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
