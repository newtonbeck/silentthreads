defmodule SilentThreads.Domain.Model.ParticipantTest do
  use SilentThreads.DataCase, async: true
  alias SilentThreads.Domain.Model.Participant

  describe "required fields" do
    test "nickname should be required" do
      changeset = Participant.changeset(%Participant{}, %{})
      assert %{nickname: ["can't be blank"]} = errors_on(changeset)
    end

    test "room_id should be required" do
      changeset = Participant.changeset(%Participant{}, %{nickname: "bilbo"})
      assert %{room_id: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "nickname length validation" do
    test "should be at least 3 chars" do
      changeset = Participant.changeset(%Participant{}, %{nickname: "ab"})
      assert %{nickname: ["should be at least 3 character(s)"]} = errors_on(changeset)
    end

    test "should be at most 50 chars" do
      changeset = Participant.changeset(%Participant{}, %{nickname: "a" <> String.duplicate("a", 50)})
      assert %{nickname: ["should be at most 50 character(s)"]} = errors_on(changeset)
    end
  end


  test "participant with room_id and nickname should be valid" do
    changeset = Participant.changeset(%Participant{}, %{room_id: 1, nickname: "bilbo"})
    assert changeset.valid? == true
  end
end
