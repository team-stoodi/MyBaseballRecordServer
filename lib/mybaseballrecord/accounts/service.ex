defmodule Mybaseballrecord.Accounts.Service do
  alias Mybaseballrecord.Accounts.User
  alias Mybaseballrecord.Accounts.Repository

  # TODO 1. Registration User
  def register_user(%{email: email, password: password} = attrs)
      when attrs == %{email: email, password: password} do
    Repository.insert_user(attrs)
  end

  def register_user(_attrs) do
    {:error, :invalid_attrs}
  end

  # Todo 2. Authenticate
  def authenticate(%{email: email, password: password} = attrs)
      when attrs == %{email: email, password: password} do
    with user <- Repository.get_user_by(email),
         %User{hashed_password: hashed_password} <- user,
         true <- Bcrypt.verify_pass(password, hashed_password) do
      {:ok, Map.take(user, [:id, :email])}
    else
      _ -> {:error, :unauthorized}
    end
  end

  def authenticate(_attrs) do
    {:error, :invalid_attrs}
  end

  # Todo 3. Authenticate & return JWT Token
end
