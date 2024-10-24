defmodule TmanWeb.ClockController do
  use TmanWeb, :controller
  alias Tman.Clocks
  alias Tman.Clocks.Clock
  alias Tman.Workingtimes
  alias Tman.Workingtimes.Workingtime

  action_fallback(TmanWeb.FallbackController)

  def get_all_clocks(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create_clock(conn, %{"status" => status, "userID" => id}) do
    existing_clock = Clocks.get_clock_by_user_id!(id)
    current_time = DateTime.utc_now() |> DateTime.to_iso8601()

    case existing_clock do
      nil ->
        create_new_clock(conn, id, current_time, status)

      _ ->
        update_existing_clock(conn, existing_clock, id, current_time)
    end
  end

  defp update_existing_clock(conn, existing_clock, id, current_time) do
    existing_clock_status = existing_clock.status
    workingtime_start_time = existing_clock.time
    workingtime_end_time = current_time

    workingtimes =
      case existing_clock_status do
        true ->
          case Workingtimes.create_workingtime(%{
                 "start" => workingtime_start_time,
                 "end" => workingtime_end_time,
                 "user" => id
               }) do
            {:ok, wt} -> wt
            _ -> nil
          end

        _ ->
          nil
      end

    with {:ok, %Clock{} = clock} <-
           Clocks.update_clock(existing_clock, %{
             "status" => !existing_clock_status,
             "time" => current_time
           }) do
      case workingtimes do
        %Workingtime{} = wt ->
          render_update(conn, wt)

        nil ->
          render_created(conn, clock)
      end
    end
  end

  defp create_new_clock(conn, id, current_time, status) do
    clocking_params_with_user = Map.put(%{"user" => id, "time" => current_time}, "status", status)

    with {:ok, %Clock{} = clock} <- Clocks.create_clock(clocking_params_with_user) do
      render_created(conn, clock)
    end
  end

  defp render_update(conn, workingtimes) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", ~p"/api/workingtimes/#{workingtimes}")
    |> render("show_workingtime.json", workingtimes: workingtimes)
  end

  defp render_created(conn, clock) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", ~p"/api/clocks/#{clock}")
    |> render("show.json", clock: clock)
  end

  def get_clock_by_user_id(conn, %{"userID" => id}) do
    clock = Clocks.get_clock_by_user_id!(id)
    render(conn, :show, clock: clock)
  end
end
