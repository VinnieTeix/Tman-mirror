defmodule Tman.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :team_leader, :integer
    field :users, {:array, :integer}
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:team_leader, :users])
    |> unique_constraint(:team_leader)
    |> validate_required([:team_leader, :users])
  end
end
