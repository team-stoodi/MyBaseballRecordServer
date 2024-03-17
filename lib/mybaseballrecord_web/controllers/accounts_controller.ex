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
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> json(%{user: user})
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

    error_message =
      case action do
        :register -> "Invalid email or password"
        :login -> "Authentication failed"
      end

    conn |> put_status(:unauthorized) |> json(%{error: error_message})
  end
end
