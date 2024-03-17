defmodule MybaseballrecordWeb.Router do
  use MybaseballrecordWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug MybaseballrecordWeb.AuthPipeline
    plug MybaseballrecordWeb.Plugs.AssignCurrentUser
  end

  scope "/api", MybaseballrecordWeb do
    pipe_through :api

    post "/login", AccountsController, :login
    post "/register", AccountsController, :register

    scope "/" do
      pipe_through :auth

      get "/me", AccountsController, :me
      resources "/game_records", GameRecordController
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mybaseballrecord, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: MybaseballrecordWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
