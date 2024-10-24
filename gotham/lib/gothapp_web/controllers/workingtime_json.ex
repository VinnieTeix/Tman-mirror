defmodule TmanWeb.WorkingTimeJSON do
  alias Tman.Workingtimes.Workingtime

  @doc """
  Renders a list of workingtimes.
  """
  def index(%{workingtimes: workingtimes}) do
    %{data: for(workingtimes <- workingtimes, do: data(workingtimes))}
  end

  @doc """
  Renders a single workingtimes.
  """
  def show(%{workingtimes: workingtimes}) do
    %{data: data(workingtimes)}
  end

  defp data(%Workingtime{} = workingtimes) do
    %{
      id: workingtimes.id,
      start: workingtimes.start,
      end: workingtimes.end,
      user: workingtimes.user
    }
  end
end
