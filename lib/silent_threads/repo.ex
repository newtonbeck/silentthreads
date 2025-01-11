defmodule SilentThreads.Repo do
  use Ecto.Repo,
    otp_app: :silent_threads,
    adapter: Ecto.Adapters.Postgres
end
