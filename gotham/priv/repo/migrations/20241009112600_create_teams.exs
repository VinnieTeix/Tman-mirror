defmodule Tman.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :team_leader, :integer
      add :users, {:array, :integer}

      timestamps(type: :utc_datetime)
    end

    create index(:teams, [:team_leader])
  end
end
