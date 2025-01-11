defmodule SilentThreads.Domain.Repository.Rooms do

  alias SilentThreads.Domain.Model.Room
  alias SilentThreads.Repo

  def create() do
    %Room{} |> Repo.insert()
  end
end
