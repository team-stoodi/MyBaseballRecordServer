defmodule Mybaseballrecord.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Mybaseballrecord.Repo

  alias Mybaseballrecord.Games.GameRecord
  alias Mybaseballrecord.Games.PlayerRecord

  @doc """
  Returns the list of game_records.

  ## Examples

      iex> list_game_records()
      [%GameRecord{}, ...]

  """
  def list_game_records do
    Repo.all(GameRecord)
  end

  @doc """
  Gets a single game_record.

  Raises `Ecto.NoResultsError` if the Game record does not exist.

  ## Examples

      iex> get_game_record!(123)
      %GameRecord{}

      iex> get_game_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_record(id) do
    try do
      case Repo.get(GameRecord, id) do
        nil -> {:error, {:not_found, "GameRecord with ID #{id} not found"}}
        game_record -> {:ok, game_record}
      end
    rescue
      e -> {:error, {:not_found, "Query failed due to invalid input: #{inspect(e)}"}}
    end
  end

  @doc """
  Creates a game_record.

  ## Examples

      iex> create_game_record(%{field: value})
      {:ok, %GameRecord{}}

      iex> create_game_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_record(attrs \\ %{}) do
    %GameRecord{}
    |> GameRecord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_record.

  ## Examples

      iex> update_game_record(game_record, %{field: new_value})
      {:ok, %GameRecord{}}

      iex> update_game_record(game_record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_record(%GameRecord{} = game_record, attrs) do
    game_record
    |> GameRecord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_record.

  ## Examples

      iex> delete_game_record(game_record)
      {:ok, %GameRecord{}}

      iex> delete_game_record(game_record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_record(%GameRecord{} = game_record) do
    Repo.delete(game_record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_record changes.

  ## Examples

      iex> change_game_record(game_record)
      %Ecto.Changeset{data: %GameRecord{}}

  """
  def change_game_record(%GameRecord{} = game_record, attrs \\ %{}) do
    GameRecord.changeset(game_record, attrs)
  end

  def create_player_record(attrs \\ %{}) do
    %PlayerRecord{}
    |> PlayerRecord.changeset(attrs)
    |> Repo.insert()
  end
end
