defmodule MybaseballrecordWeb.GameRecordController do
  use MybaseballrecordWeb, :controller

  alias Mybaseballrecord.Games
  alias Mybaseballrecord.Games.GameRecord

  action_fallback MybaseballrecordWeb.FallbackController

  def index(conn, _params) do
    game_records = Games.list_game_records()
    render(conn, :index, game_records: game_records)
  end

  def create(conn, %{"game_record" => game_record_params}) do
    with {:ok, %GameRecord{} = game_record} <- Games.create_game_record(game_record_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/game_records/#{game_record}")
      |> render(:show, game_record: game_record)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, game_record} <- Games.get_game_record(id) do
      render(conn, :show, game_record: game_record)
    end
  end

  def update(conn, %{"id" => id, "game_record" => game_record_params}) do
    with {:ok, game_record} <- Games.get_game_record(id),
         {:ok, %GameRecord{} = game_record} <-
           Games.update_game_record(game_record, game_record_params) do
      render(conn, :show, game_record: game_record)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, game_record} <- Games.get_game_record(id),
         {:ok, %GameRecord{}} <- Games.delete_game_record(game_record) do
      send_resp(conn, :no_content, "")
    end
  end
end
