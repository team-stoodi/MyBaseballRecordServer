defmodule Mybaseballrecord.AccountsServiceTest do
  use Mybaseballrecord.DataCase
  alias Mybaseballrecord.Accounts.Service
  # alias Mybaseballrecord.Accounts.User

  describe "register_user/1" do
    setup do
      attrs = %{email: "test@example.com", password: "password123"}
      {:ok, attrs: attrs}
    end

    defp register_user(attrs) do
      Service.register_user(attrs)
    end

    test "with valid attrs", %{attrs: attrs} do
      {:ok, user} = Service.register_user(attrs)
      assert user.email == "test@example.com"
      assert user.hashed_password
    end

    test "returns error when email is already taken", %{attrs: attrs} do
      register_user(attrs)

      {:error, changeset} = register_user(attrs)

      assert changeset.errors[:email] ==
               {"has already been taken",
                [{:constraint, :unique}, {:constraint_name, "users_email_index"}]}
    end

    test "returns error when email is invalid" do
      attrs = %{email: "test", password: "password123"}
      {:error, changeset} = register_user(attrs)
      assert changeset.errors[:email] == {"is invalid", [{:validation, :format}]}
    end

    test "returns error when password is invalid" do
      attrs = %{email: "test@example.com", password: "123"}
      {:error, changeset} = register_user(attrs)

      assert changeset.errors[:password] ==
               {"should be at least %{count} character(s)",
                [{:count, 8}, {:validation, :length}, {:kind, :min}, {:type, :string}]}
    end

    test "mismatch parameter" do
      attrs = %{
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password1234"
      }

      {:error, errors} = register_user(attrs)
      assert errors == :invalid_attrs

      attrs = %{}

      {:error, errors} = register_user(attrs)
      assert errors == :invalid_attrs

      attrs = %{
        email: "test@example.com",
        passwords: "password123"
      }

      {:error, errors} = register_user(attrs)
      assert errors == :invalid_attrs
    end
  end

  describe "authenticate/2" do
    setup do
      attrs = %{email: "test@example.com", password: "password123"}
      {:ok, attrs: attrs}
    end

    defp register_user(attrs) do
      Service.register_user(attrs)
    end

    defp authenticate(attrs) do
      Service.authenticate(attrs)
    end

    test "with valid email and password", %{attrs: attrs} do
      {:ok, user} = register_user(attrs)
      {:ok, user} = authenticate(%{email: user.email, password: attrs[:password]})
      assert user.email == "test@example.com"
      assert user.id
    end

    test "with invalid email", %{attrs: attrs} do
      {:error, :unauthorized} = authenticate(%{email: "test", password: attrs[:password]})
      assert :unauthorized
    end

    test "with invalid password", %{attrs: attrs} do
      {:ok, user} = register_user(attrs)

      {:error, :unauthorized} = authenticate(%{email: user.email, password: "password1234"})
      assert :unauthorized
    end
  end
end
