defmodule Tman.Repo.Migrations.AddUserIdToClocks do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      add :user_id, references(:users, on_delete: :delete_all)  # Creates the foreign key
    end
    alter table(:workingtimes) do
      add :user_id, references(:users, on_delete: :delete_all)  # Creates the foreign key
    end
  end
end
