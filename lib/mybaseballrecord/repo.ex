defmodule Mybaseballrecord.Repo do
  use Ecto.Repo,
    otp_app: :mybaseballrecord,
    adapter: Ecto.Adapters.Postgres
end
