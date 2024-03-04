defmodule MybaseballrecordWeb.GameRecordControllerTest do
  use MybaseballrecordWeb.ConnCase

  import Mybaseballrecord.GamesFixtures

  alias Mybaseballrecord.Games.GameRecord

  @create_attrs %{
    date: ~D[2024-03-03],
    description: "some description",
    place: "some place"
  }
  @update_attrs %{
    date: ~D[2024-03-04],
    description: "some updated description",
    place: "some updated place"
  }
  @invalid_attrs %{date: nil, description: nil, place: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all game_records", %{conn: conn} do
      conn = get(conn, ~p"/api/game_records")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create game_record" do
    test "renders game_record when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/game_records", game_record: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/game_records/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-03-03",
               "description" => "some description",
               "place" => "some place"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/game_records", game_record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update game_record" do
    setup [:create_game_record]

    test "renders game_record when data is valid", %{conn: conn, game_record: %GameRecord{id: id} = game_record} do
      conn = put(conn, ~p"/api/game_records/#{game_record}", game_record: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/game_records/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-03-04",
               "description" => "some updated description",
               "place" => "some updated place"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, game_record: game_record} do
      conn = put(conn, ~p"/api/game_records/#{game_record}", game_record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete game_record" do
    setup [:create_game_record]

    test "deletes chosen game_record", %{conn: conn, game_record: game_record} do
      conn = delete(conn, ~p"/api/game_records/#{game_record}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/game_records/#{game_record}")
      end
    end
  end

  defp create_game_record(_) do
    game_record = game_record_fixture()
    %{game_record: game_record}
  end
end
