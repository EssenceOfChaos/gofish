defmodule Gofish.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :winner, :integer
      add :player_1, references(:players, on_delete: :nothing)
      add :player_2, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:games, [:winner])
  end
end
