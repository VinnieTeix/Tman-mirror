defmodule Tman.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TmanWeb.Telemetry,
      Tman.Repo,
      {DNSCluster, query: Application.get_env(:gothapp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tman.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tman.Finch},
      # Start a worker by calling: Tman.Worker.start_link(arg)
      # {Tman.Worker, arg},
      # Start to serve requests, typically the last entry
      TmanWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tman.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TmanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
