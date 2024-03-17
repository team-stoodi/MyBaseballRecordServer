defmodule MybaseballrecordWeb.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :mybaseballrecord,
    module: Mybaseballrecord.Guardian,
    error_handler: MybaseballrecordWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
