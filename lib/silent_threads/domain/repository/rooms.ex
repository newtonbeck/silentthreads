defmodule SilentThreads.Domain.Repository.Rooms do

  alias SilentThreads.Domain.Model.Room
  alias SilentThreads.Repo

  def create(attrs) do
    %Room{}
      |> Room.changeset(attrs)
      |> Repo.insert()
  end
end
