defmodule SilentThreads.Domain.UseCase.SendMessage do
  alias SilentThreads.Domain.Repository.{Rooms, Messages}
  alias SilentThreads.Infra.PubSub.RoomsTopic

  def send(room_id, current_participant, content) do
    with room <- Rooms.find(room_id),
         {:ok, message} <-
           Messages.send(room, current_participant, content) do
      RoomsTopic.broadcast(room, {:new_message, message})
      {:ok, %{room: room, message: message}}
    else
      _ -> {:error, :room_not_found}
    end
  end
end
