defmodule SilentThreadsWeb.RoomLive.Show do
  use SilentThreadsWeb, :live_view
  alias SilentThreads.Domain.UseCase.ShowRoom

  @fake_current_participant %{id: 30}

  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     %{
       room: room,
       participants: participants,
       messages: messages
     }} = ShowRoom.show(id)

    {:ok,
     assign(
       socket,
       current_participant: @fake_current_participant,
       room: room,
       messages: messages,
       participants: participants
     )}
  end
end
