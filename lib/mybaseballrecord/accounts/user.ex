defmodule Mybaseballrecord.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :role, :string
    field :email, :string
    field :birthday, :date
    field :intro, :string
    has_many :player_records, Mybaseballrecord.Games.PlayerRecord, foreign_key: :player_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :role, :birthday, :intro])
    |> validate_required([:name, :email, :role, :birthday, :intro])
    |> unique_constraint(:email)
  end
end
