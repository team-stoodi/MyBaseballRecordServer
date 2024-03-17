defmodule Mybaseballrecord.Accounts.Repository do
  alias Mybaseballrecord.Accounts.User
  alias Mybaseballrecord.Repo

  def insert_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
