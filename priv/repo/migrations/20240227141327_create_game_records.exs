defmodule Mybaseballrecord.Repo.Migrations.CreateGameRecords do
  use Ecto.Migration

  def change do
    create table(:game_records, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :date
      add :place, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
