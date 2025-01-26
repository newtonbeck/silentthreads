defmodule SilentThreads.Domain.UseCase.ShowRoom do
  alias SilentThreads.Domain.Repository.{Rooms, Participants, Messages}

  def show(id) do
    case Rooms.find(id) do
      nil ->
        {:error, :room_not_found}

      room ->
        participants = Participants.find_by_room(id)
        messages = Messages.find_by_room(id)
        {:ok, %{room: room, participants: participants, messages: messages}}
    end
  end
end
