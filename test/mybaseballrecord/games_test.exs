defmodule Mybaseballrecord.GamesTest do
  use Mybaseballrecord.DataCase

  alias Mybaseballrecord.Games
  alias Mybaseballrecord.Games.Service.GameRecordService

  describe "game_records" do
    alias Mybaseballrecord.Games.GameRecord

    import Mybaseballrecord.GamesFixtures

    @invalid_attrs %{date: nil, description: nil, place: nil}

    test "create_game_record/1 service without user just for test" do
      valid_attrs = %{date: ~D[2024-02-26], description: "some description", place: "some place"}

      assert {:ok, %GameRecord{} = game_record} =
               GameRecordService.create_game_record(valid_attrs)

      assert game_record.date == ~D[2024-02-26]
      assert game_record.description == "some description"
      assert game_record.place == "some place"
    end

    test "list_game_records/0 returns all game_records" do
      game_record = game_record_fixture()
      assert Games.list_game_records() == [game_record]
    end

    test "get_game_record!/1 returns the game_record with given id" do
      game_record = game_record_fixture()
      assert Games.get_game_record!(game_record.id) == game_record
    end

    test "create_game_record/1 with valid data creates a game_record" do
      valid_attrs = %{date: ~D[2024-02-26], description: "some description", place: "some place"}

      assert {:ok, %GameRecord{} = game_record} = Games.create_game_record(valid_attrs)
      assert game_record.date == ~D[2024-02-26]
      assert game_record.description == "some description"
      assert game_record.place == "some place"
    end

    test "create_game_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_record(@invalid_attrs)
    end

    test "update_game_record/2 with valid data updates the game_record" do
      game_record = game_record_fixture()

      update_attrs = %{
        date: ~D[2024-02-27],
        description: "some updated description",
        place: "some updated place"
      }

      assert {:ok, %GameRecord{} = game_record} =
               Games.update_game_record(game_record, update_attrs)

      assert game_record.date == ~D[2024-02-27]
      assert game_record.description == "some updated description"
      assert game_record.place == "some updated place"
    end

    test "update_game_record/2 with invalid data returns error changeset" do
      game_record = game_record_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game_record(game_record, @invalid_attrs)
      assert game_record == Games.get_game_record!(game_record.id)
    end

    test "delete_game_record/1 deletes the game_record" do
      game_record = game_record_fixture()
      assert {:ok, %GameRecord{}} = Games.delete_game_record(game_record)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game_record!(game_record.id) end
    end

    test "change_game_record/1 returns a game_record changeset" do
      game_record = game_record_fixture()
      assert %Ecto.Changeset{} = Games.change_game_record(game_record)
    end
  end

  describe "PlayerRecord" do
    alias Mybaseballrecord.Games.GameRecord
    # alias Mybaseballrecord.Accounts.User
    alias Mybaseballrecord.Games.PlayerRecord

    import Mybaseballrecord.GamesFixtures
    import Mybaseballrecord.AccountsFixtures

    # @player1_attrs %{}
    # @player2_attrs %{}

    # @game_record_attrs %{}

    test "create_player_record/1 with valid data creates a player_record" do
      game_record = game_record_fixture()
      assert game_record.id != nil

      player = user_fixture()
      assert player.id != nil

      valid_attrs = %{
        player_id: player.id,
        game_id: game_record.id
      }

      assert {:ok, %PlayerRecord{} = player_record} = Games.create_player_record(valid_attrs)
      assert player_record.player_id == player.id
      assert player_record.game_id == game_record.id
    end
  end
end
