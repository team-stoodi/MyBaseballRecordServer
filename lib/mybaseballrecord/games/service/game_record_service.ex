defmodule Mybaseballrecord.Games.Service.GameRecordService do
  alias Mybaseballrecord.Games.Repository.GameRecordRepository
  alias Mybaseballrecord.Games.GameRecord

  def create_game_record(attrs \\ %{}) do
    %GameRecord{}
    |> GameRecord.changeset(attrs)
    |> GameRecordRepository.create_game_record()
  end
end
