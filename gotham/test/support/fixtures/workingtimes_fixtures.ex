defmodule Tman.WorkingtimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tman.Workingtimes` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2024-10-08 11:25:00],
        start: ~N[2024-10-08 11:25:00]
      })
      |> Tman.Workingtimes.create_workingtime()

    workingtime
  end
end
