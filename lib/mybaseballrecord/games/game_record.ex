defmodule Mybaseballrecord.Games.GameRecord do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_records" do
    field :date, :date
    field :description, :string
    field :place, :string

    has_many :player_records, Mybaseballrecord.Games.PlayerRecord, foreign_key: :game_id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_record, attrs) do
    game_record
    |> cast(attrs, [:date, :place, :description])
    |> validate_required([:date, :place, :description])
  end
end
