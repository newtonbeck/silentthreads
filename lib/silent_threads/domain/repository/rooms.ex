defmodule SilentThreads.Domain.Repository.Rooms do

  alias SilentThreads.Domain.Model.Room
  alias SilentThreads.Repo

  def create() do
    %Room{} |> Repo.insert()
  end

  def find(id) do
    Repo.get(Room, id)
  end
end
