defmodule Gofish.Repo.Migrations.AddStatusToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :status, :string
    end

  end
end
