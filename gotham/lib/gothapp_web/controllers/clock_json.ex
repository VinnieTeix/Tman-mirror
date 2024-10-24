defmodule TmanWeb.ClockJSON do
  alias Tman.Clocks.Clock
  alias Tman.Workingtimes.Workingtime

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end

  @doc """
  Renders a single clock.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  def show_workingtime(%{workingtimes: workingtimes}) do
    %{data_wt: data_wt(workingtimes)}
  end

  defp data_wt(%Workingtime{} = workingtimes) do
    %{
      id: workingtimes.id,
      start: workingtimes.start,
      end: workingtimes.end,
      user: workingtimes.user
    }
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status
    }
  end
end
