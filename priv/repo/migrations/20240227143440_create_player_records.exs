defmodule Mybaseballrecord.Repo.Migrations.CreatePlayerRecords do
  use Ecto.Migration

  def change do
    create table(:player_records, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :game_id, references(:game_records, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:player_records, [:player_id])
    create index(:player_records, [:game_id])
  end
end
