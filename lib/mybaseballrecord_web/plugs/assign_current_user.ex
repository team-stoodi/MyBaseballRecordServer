defmodule MybaseballrecordWeb.Plugs.AssignCurrentUser do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    current_user = Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, current_user)
  end
end
