defmodule Silentthreads.Repo do
  use Ecto.Repo,
    otp_app: :silentthreads,
    adapter: Ecto.Adapters.Postgres
end
