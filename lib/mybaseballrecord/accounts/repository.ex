defmodule Mybaseballrecord.Accounts.Repository do
  alias Mybaseballrecord.Accounts.User
  alias Mybaseballrecord.Repo

  def insert_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  # def get_user_by(email, columns) do
  #   from(u in User, where: u.email == ^email, select: map(u, ^columns))
  #   |> Repo.one()
  # end

  def get_user_by(%{email: email}) do
    Repo.get_by(User, email: email)
  end

  def get_user_by(%{id: id}) do
    Repo.get(User, id)
  end
end
