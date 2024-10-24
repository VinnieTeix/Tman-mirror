defmodule TmanWeb.WorkingtimesController do
  use TmanWeb, :controller

  import Ecto.Query, warn: false
  alias Tman.Workingtimes
  alias Tman.Workingtimes.Workingtime
  require Logger

  action_fallback(TmanWeb.FallbackController)

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def get_workingtime_by_dates(conn, %{"userID" => id} = params) do
    workingtimes = Workingtimes.get_workingtime_by_dates!(params["start"], params["end"], id)

    render(conn, :index, workingtimes: workingtimes)
  end

  def get_workingtime_by_id(conn, %{"id" => id}) do
    workingtimes = Workingtimes.get_workingtime_by_id!(id)
    render(conn, :show, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtimes" => workingtime_params, "userID" => id}) do
    workingtime_params_with_user = Map.put(workingtime_params, "user", id)

    with {:ok, %Workingtime{} = workingtimes} <-
           Workingtimes.create_workingtime(workingtime_params_with_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtimes}")
      |> render("show.json", workingtimes: workingtimes)
    end
  end

  def show(conn, %{"user" => user, "id" => id}) do
    workingtimes = Workingtimes.get_workingtime_by_userid_and_id!(user, id)
    render(conn, :show, workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtimes" => workingtime_params}) do
    workingtimes = Workingtimes.get_workingtime_by_id!(id)

    with {:ok, %Workingtime{} = workingtimes} <-
           Workingtimes.update_workingtime(workingtimes, workingtime_params) do
      render(conn, :show, workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = Workingtimes.get_workingtime_by_id!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
