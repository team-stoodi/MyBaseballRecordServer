defmodule Mybaseballrecord.Games.Repository.GameRecordRepository do
  import Ecto.Query, warn: false
  alias Mybaseballrecord.Repo

  def create_game_record(game_record) do
    game_record
    |> Repo.insert()
  end
end
