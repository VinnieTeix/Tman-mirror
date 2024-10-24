defmodule Tman.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :role, :string, default: "employee"

    timestamps(type: :utc_datetime)
  end

  @roles ["employee", "manager", "generalManager", "admin"]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role])
    |> unique_constraint(:email)
    |> validate_required([:username, :email, :password, :role])
    |> validate_format(:email, ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)
    |> validate_inclusion(:role, @roles)
  end
end
