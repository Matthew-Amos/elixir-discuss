defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string       # User email
      add :provider, :string    # Who they signed up with
      add :token, :string       # Link to the provider API

      timestamps()
    end
  end
end
