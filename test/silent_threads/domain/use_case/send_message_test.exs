defmodule SilentThreads.Domain.UseCase.SendMessageTest do
  use SilentThreads.DataCase
  alias SilentThreads.Domain.UseCase.SendMessage
  alias SilentThreads.Domain.Model.Message
  alias SilentThreads.Domain.Repository.{Rooms, Participants}

  describe "happy path" do
    setup [:create_room]

    test "it should send a message to the room", %{room: room, participant: participant} do
      {:ok, %{room: room, message: message}} = SendMessage.send(room.id, participant, "I am going on an adventure!")

      assert room == room
      assert %Message{content: "I am going on an adventure!"} = message
    end

    defp create_room(_) do
      {:ok, room} = Rooms.create()
      {:ok, participant} = Participants.join(room, %{nickname: "bilbo"})
      %{room: room, participant: participant}
    end

  end

end
