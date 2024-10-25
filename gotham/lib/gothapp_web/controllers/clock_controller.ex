  defmodule TmanWeb.ClockController do
    use TmanWeb, :controller

    alias Tman.Clocks
    alias Tman.Clocks.Clock

    action_fallback TmanWeb.FallbackController

    def index(conn, _params) do
      clocks = Clocks.list_clocks() |> Repo.preload(:user)
      render(conn, :index, clocks: clocks)
    end

    def create(conn, %{"clock" => clock_params}) do
      user_id = conn.assigns[:current_user_id]  # Example of how you might get the user id

      clock_params_with_user = Map.put(clock_params, "user_id", user_id)

      with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params_with_user) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
        |> render(:show, clock: clock)
        end
    end

    def show(conn, %{"id" => id}) do
      clock = Clocks.get_clock!(id)
      render(conn, :show, clock: clock)
    end

    def update(conn, %{"id" => id, "clock" => clock_params}) do
      clock = Clocks.get_clock!(id)

      with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
        render(conn, :show, clock: clock)
      end
    end

    def delete(conn, %{"id" => id}) do
      clock = Clocks.get_clock!(id)

      with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
        send_resp(conn, :no_content, "")
      end
    end
  end
