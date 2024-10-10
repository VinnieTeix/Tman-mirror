defmodule Todolist.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtime" do
    field(:start, :naive_datetime)
    field(:end, :naive_datetime)
    belongs_to(:user, Todolist.User)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
