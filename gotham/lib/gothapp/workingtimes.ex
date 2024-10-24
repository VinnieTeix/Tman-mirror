defmodule Tman.Workingtimes do
  @moduledoc """
  The Workingtimes context.
  """

  import Ecto.Query, warn: false
  alias Tman.Repo

  alias Tman.Workingtimes.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  # def list_workingtimes_by_params(startTime, endTime, userID) do
  #   cond do
  #     startTime && endTime ->
  #       Repo.all(from(w in Workingtime, where: w.start == ^startTime and w.end == ^endTime and w.user == ^userID))

  #     startTime ->
  #       Repo.all(from(w in Workingtime, where: w.start == ^startTime and w.user == ^userID))

  #     endTime ->
  #       Repo.all(from(w in Workingtime, where: w.end == ^endTime and w.user == ^userID))

  #     true ->
  #        Repo.all(from(w in Workingtime, where: w.user == ^userID))
  #   end
  # end

  def get_workingtime_by_dates!(startTime, endTime, userID) do
    query =
      from(wt in Workingtime,
        where: wt.start >= ^startTime and wt.start <= ^endTime and wt.user == ^userID,
        select: wt
      )

    Repo.all(query)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_workingtime!(id), do: Repo.get!(Workingtime, id)
  def get_workingtime_by_userid_and_id!(user, id),
    do: Repo.get_by(Working_time, user: user, id: id)

  def get_workingtime_by_id!(id), do: Repo.get_by(Working_time, id: id)

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end
end
