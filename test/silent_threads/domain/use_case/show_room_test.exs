defmodule SilenThreads.Domain.UseCase.ShowRoomTest do

  use SilentThreads.DataCase
  alias SilentThreads.Domain.UseCase.ShowRoom
  alias SilentThreads.Domain.Repository.{Rooms, Participants, Messages}

  describe "validation errors" do
    test "it should return error when room does not exist" do
      {:error, error} = ShowRoom.show(0)
      assert error == :room_not_found
    end
  end

  describe "happy path" do
    setup [:create_room]

    test "it should return the room", %{room: room} do
      {:ok, %{room: returned_room}} = ShowRoom.show(room.id)
      assert returned_room == room
    end

    test "it should return the participants", %{room: room, participant: participant} do
      {:ok, %{participants: participants}} = ShowRoom.show(room.id)
      assert participants == [participant]
    end

    test "it should return the messages", %{room: room, message: message} do
      {:ok, %{messages: messages}} = ShowRoom.show(room.id)
      assert messages == [message]
    end
  end

  defp create_room(_) do
    {:ok, room} = Rooms.create()
    {:ok, participant} = Participants.join(room, %{nickname: "bilbo"})
    {:ok, message} = Messages.send(room, participant, "Hello")
    %{room: room, participant: participant, message: message}
  end

end
