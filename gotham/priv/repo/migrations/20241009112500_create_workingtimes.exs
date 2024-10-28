defmodule Tman.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :user_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
