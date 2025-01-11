defmodule SilentThreads.Domain.UseCase.CreateRoom do

  alias SilentThreads.Domain.Repository.{Rooms, Participants}

  def create_room(attrs) do
    with {:ok, room} <- Rooms.create(),
         {:ok, participant} <- Participants.join(room, attrs) do
      {:ok, room, participant}
    else
      {:error, _} -> {:error, "Failed to create room"}
    end
  end

end
