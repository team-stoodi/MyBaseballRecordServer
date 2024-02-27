defmodule Mybaseballrecord.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MybaseballrecordWeb.Telemetry,
      Mybaseballrecord.Repo,
      {DNSCluster, query: Application.get_env(:mybaseballrecord, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mybaseballrecord.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Mybaseballrecord.Finch},
      # Start a worker by calling: Mybaseballrecord.Worker.start_link(arg)
      # {Mybaseballrecord.Worker, arg},
      # Start to serve requests, typically the last entry
      MybaseballrecordWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mybaseballrecord.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MybaseballrecordWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
