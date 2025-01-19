defmodule SilentThreads.Domain.UseCase.StartRoomTest do
  use SilentThreads.DataCase
  alias SilentThreads.Domain.UseCase.StartRoom
  alias SilentThreads.Domain.Model.{Room, Participant}

  describe "validation errors" do
    test "it should return error when nickname is invalid" do
      {:error, error} = StartRoom.start(%{nickname: ""})
      assert %Ecto.Changeset{valid?: false} = error
    end
  end

  describe "happy path" do
    test "it should create a room" do
      {:ok, %{room: room}} = StartRoom.start(%{nickname: "bilbo"})
      assert %Room{id: _id} = room
    end

    test "it should create a room with one participant" do
      {:ok, %{participant: participant}} = StartRoom.start(%{nickname: "bilbo"})
      assert %Participant{id: _id, nickname: "bilbo"} = participant
    end
  end
end
