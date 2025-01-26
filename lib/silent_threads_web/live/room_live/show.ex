defmodule SilentThreadsWeb.RoomLive.Show do
  use SilentThreadsWeb, :live_view
  alias SilentThreads.Domain.UseCase.ShowRoom
  alias SilentThreads.Domain.UseCase.SendMessage
  alias SilentThreads.Infra.PubSub.RoomsTopic

  def mount(%{"id" => id}, session, socket) do
    if connected?(socket) do
      RoomsTopic.subscribe(%{id: id})
    end

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

  def handle_info({:new_message, new_message}, socket) do
    %{messages: messages, current_participant: current_participant} = socket.assigns

    if new_message.author_id == current_participant.id do
      {:noreply, socket}
    else
      {:noreply, assign(socket, messages: messages ++ [new_message])}
    end
  end

  def handle_info({:new_participant, new_participant}, socket) do
    %{participants: participants} = socket.assigns
    {:noreply, assign(socket, participants: participants ++ [new_participant])}
  end
end
