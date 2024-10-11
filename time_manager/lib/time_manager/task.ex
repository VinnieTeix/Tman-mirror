defmodule TimeManager.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :user, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([:title, :description, :status])
  end
end
