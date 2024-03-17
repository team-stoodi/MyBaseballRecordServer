defmodule Mybaseballrecord.Accounts.Service do
  alias Mybaseballrecord.Accounts.User
  alias Mybaseballrecord.Accounts.Repository
  alias Mybaseballrecord.Guardian

  def register_user(%{email: email, password: password} = attrs)
      when attrs == %{email: email, password: password} do
    Repository.insert_user(attrs)
  end

  def register_user(_attrs) do
    {:error, :invalid_attrs}
  end

  def authenticate(%{email: email, password: password} = attrs)
      when attrs == %{email: email, password: password} do
    with user <- Repository.get_user_by(%{email: email}),
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

  def generate_jwt_for_authenticated_user(%{email: email, password: password} = attrs)
      when attrs == %{email: email, password: password} do
    with {:ok, user} <- authenticate(attrs),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, token}
    else
      _ -> {:error, :unauthorized}
    end
  end

  def generate_jwt_for_authenticated_user(_attrs) do
    {:error, :invalid_attrs}
  end

  def get_user(%{id: id}) when is_binary(id) do
    with user <- Repository.get_user_by(%{id: id}),
         true <- is_map(user) do
      {:ok, user}
    else
      _ -> {:error, :not_found}
    end
  end

  def get_user(_attrs) do
    {:error, :invalid_attrs}
  end
end
