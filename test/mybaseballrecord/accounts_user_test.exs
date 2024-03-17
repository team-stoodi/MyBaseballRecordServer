defmodule Mybaseballrecord.AccountsUserTest do
  use Mybaseballrecord.DataCase
  alias Mybaseballrecord.Accounts.User
  alias Mybaseballrecord.Repo

  describe "registration_changeset/3" do
    test "with valid attributes" do
      valid_attrs = %{email: "test@example.com", password: "password123"}
      changeset = User.registration_changeset(%User{}, valid_attrs)
      assert changeset.valid?
      assert changeset.changes.email == "test@example.com"
      assert changeset.changes.hashed_password
      refute Map.has_key?(changeset.changes, :password)
    end

    test "with invalid email" do
      invalid_attrs = %{email: "invalid_email", password: "password123"}
      changeset = User.registration_changeset(%User{}, invalid_attrs)
      refute changeset.valid?
      assert changeset.errors[:email] == {"is invalid", [validation: :format]}
    end

    test "with missing password" do
      invalid_attrs = %{email: "test@example.com"}
      changeset = User.registration_changeset(%User{}, invalid_attrs)
      refute changeset.valid?
      assert changeset.errors[:password] == {"can't be blank", [validation: :required]}
    end

    test "with short password" do
      invalid_attrs = %{email: "test@example.com", password: "short"}
      changeset = User.registration_changeset(%User{}, invalid_attrs)
      refute changeset.valid?
    end

    test "with duplicate email" do
      attrs = %{email: "test@example.com", password: "password123"}

      %User{}
      |> User.registration_changeset(attrs)
      |> Repo.insert()

      attrs = %{email: "test@example.com", password: "password123"}
      changeset = User.registration_changeset(%User{}, attrs)
      {:error, changeset} = Repo.insert(changeset)

      assert changeset.errors[:email] ==
               {"has already been taken",
                [{:constraint, :unique}, {:constraint_name, "users_email_index"}]}
    end

    test "without hashing password" do
      attrs = %{email: "test@example.com", password: "password123"}
      changeset = User.registration_changeset(%User{}, attrs, hash_password: false)
      assert changeset.valid?
      assert changeset.changes.password == "password123"
      refute Map.has_key?(changeset.changes, :hashed_password)
    end

    test "hashes password correctly" do
      attrs = %{email: "test@example.com", password: "password123"}
      changeset = User.registration_changeset(%User{}, attrs)

      assert changeset.valid?
      assert changeset.changes.hashed_password
      refute Map.has_key?(changeset.changes, :password)

      # Bcrypt 해시 형식 확인
      assert String.starts_with?(changeset.changes.hashed_password, "$2b$")

      # 해시된 비밀번호와 평문 비밀번호 비교
      assert Bcrypt.verify_pass("password123", changeset.changes.hashed_password)
    end
  end
end
