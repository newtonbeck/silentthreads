defmodule SilentThreadsWeb.RoomLive.Show do
  use SilentThreadsWeb, :live_view
  alias SilentThreads.Domain.UseCase.ShowRoom
  alias SilentThreads.Domain.UseCase.SendMessage

  def mount(%{"id" => id}, session, socket) do
    current_participant = Map.get(session, "participant")

    {:ok,
     %{
       room: room,
       participants: participants,
       messages: messages
     }} = ShowRoom.show(id)

    {:ok,
     assign(
       socket,
       current_participant: current_participant,
       room: room,
       messages: messages,
       participants: participants
     )}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    %{
      room: room,
      current_participant: current_participant
    } = socket.assigns

    {:ok, %{message: new_message}} = SendMessage.send(room.id, current_participant, message)
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [new_message])}
  end
end
