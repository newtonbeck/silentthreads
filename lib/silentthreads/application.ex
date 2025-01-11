defmodule SilentThreads.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SilentThreadsWeb.Telemetry,
      SilentThreads.Repo,
      {DNSCluster, query: Application.get_env(:silentthreads, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SilentThreads.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SilentThreads.Finch},
      # Start a worker by calling: SilentThreads.Worker.start_link(arg)
      # {SilentThreads.Worker, arg},
      # Start to serve requests, typically the last entry
      SilentThreadsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SilentThreads.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SilentThreadsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
