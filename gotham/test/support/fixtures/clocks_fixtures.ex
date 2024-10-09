defmodule Tman.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tman.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2024-10-08 11:24:00]
      })
      |> Tman.Clocks.create_clock()

    clock
  end
end
