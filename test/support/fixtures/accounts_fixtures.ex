defmodule Mybaseballrecord.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mybaseballrecord.Account` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthday: ~D[2024-02-26],
        email: unique_user_email(),
        intro: "some intro",
        name: "some name",
        role: "some role"
      })
      |> Mybaseballrecord.Accounts.create_user()

    user
  end
end
