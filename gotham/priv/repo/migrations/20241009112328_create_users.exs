defmodule Tman.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:email, :string, unique: true)
      add(:password, :string)
      add(:role, :string, default: "employee")

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:users, [:email]))
    execute("CREATE TYPE role AS ENUM ('employee', 'manager', 'general_manager', 'admin');")
  end
end
