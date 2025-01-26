defmodule SilentThreads.Domain.UseCase.JoinRoom do
  alias SilentThreads.Domain.Repository.{Rooms, Participants}
  alias SilentThreads.Infra.PubSub.RoomsTopic

  def join(id, attrs) do
    case Rooms.find(id) do
      nil ->
        {:error, :room_not_found}

      room ->
        case Participants.join(room, attrs) do
          {:ok, participant} ->
            RoomsTopic.broadcast(room, {:new_participant, participant})
            {:ok, %{room: room, participant: participant}}

          {:error, e} ->
            {:error, e}
        end
    end
  end
end
