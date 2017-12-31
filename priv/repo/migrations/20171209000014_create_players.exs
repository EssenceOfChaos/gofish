defmodule Gofish.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :username, :string
      add :email, :string, null: false
      add :rank, :integer
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:players, [:email])
  end
end
