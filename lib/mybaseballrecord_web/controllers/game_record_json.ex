defmodule MybaseballrecordWeb.GameRecordJSON do
  alias Mybaseballrecord.Games.GameRecord

  @doc """
  Renders a list of game_records.
  """
  def index(%{game_records: game_records}) do
    %{data: for(game_record <- game_records, do: data(game_record))}
  end

  @doc """
  Renders a single game_record.
  """
  def show(%{game_record: game_record}) do
    %{data: data(game_record)}
  end

  defp data(%GameRecord{} = game_record) do
    %{
      id: game_record.id,
      date: game_record.date,
      description: game_record.description,
      place: game_record.place
    }
  end
end
