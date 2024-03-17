defmodule MybaseballrecordWeb.AccountsController do
  use MybaseballrecordWeb, :controller
  require Logger
  alias Mybaseballrecord.Accounts.Service

  def register(conn, %{"email" => email, "password" => password}) do
    with {:ok, _} <- Service.register_user(%{email: email, password: password}),
         {:ok, token} <-
           generate_token(email, password) do
      send_token_response(conn, token)
    else
      {:error, reason} -> send_error_response(conn, reason, :register)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, token} <-
           generate_token(email, password) do
      send_token_response(conn, token)
    else
      {:error, reason} -> send_error_response(conn, reason, :login)
    end
  end

  def me(conn, _params) do
    current_user = conn.assigns.current_user

    with {:ok, user} <- Service.get_user(%{id: current_user.id}) do
      conn
      |> put_status(:ok)
      |> json(%{user: user})
    else
      {:error, reason} -> send_error_response(conn, reason, :me)
    end
  end

  defp generate_token(email, password) do
    Service.generate_jwt_for_authenticated_user(%{email: email, password: password})
  end

  defp send_token_response(conn, token) do
    conn
    |> put_resp_header("Authorization", "Bearer #{token}")
    |> put_status(:created)
    |> json(%{token: token})
  end

  defp send_error_response(conn, reason, action) do
    Logger.error("Error: #{inspect(reason)}")

    {status, error_message} =
      case action do
        :register -> {:unprocessable_entity, "Invalid email or password"}
        :login -> {:unauthorized, "Authentication failed"}
        :me -> {:not_found, "User not found"}
      end

    conn |> put_status(status) |> json(%{error: error_message})
  end
end
