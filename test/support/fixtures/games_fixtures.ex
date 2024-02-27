defmodule Mybaseballrecord.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mybaseballrecord.Games` context.
  """

  @doc """
  Generate a game_record.
  """
  def game_record_fixture(attrs \\ %{}) do
    {:ok, game_record} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-02-26],
        description: "some description",
        place: "some place"
      })
      |> Mybaseballrecord.Games.create_game_record()

    game_record
  end

  def player_record_fixture(attrs \\ %{}) do
    {:ok, player_record} =
      attrs
      |> Enum.into(%{
        player_id: attrs[:player_id],
        game_id: attrs[:game_id]
      })
      |> Mybaseballrecord.Games.create_player_record()

    player_record
  end
end
