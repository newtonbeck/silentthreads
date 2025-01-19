defmodule SilentThreads.Domain.UseCase.SendMessage do
  alias SilentThreads.Domain.Repository.{Rooms, Messages}

  def send(room_id, current_participant, content) do
    with room <- Rooms.find(room_id),
      {:ok, message} <- Messages.send(room, current_participant, content) do
      {:ok, %{room: room, message: message}}
    else
      _ -> {:error, "Room not found"}
    end
  end
end
