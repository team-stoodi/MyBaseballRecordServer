defmodule Mybaseballrecord.Games.PlayerRecord do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "player_records" do
    belongs_to :player, Mybaseballrecord.Accounts.User
    belongs_to :game, Mybaseballrecord.Games.GameRecord

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(player_record, attrs) do
    player_record
    |> cast(attrs, [:player_id, :game_id])
    |> validate_required([:player_id, :game_id])
  end
end
