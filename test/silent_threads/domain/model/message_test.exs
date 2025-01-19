defmodule SilentThreads.Domain.Model.MessageTest do
  use SilentThreads.DataCase
  alias SilentThreads.Domain.Model.Message

  describe "required fields" do
    test "author_id should be required" do
      changeset = Message.changeset(%Message{}, %{})
      assert %{author_id: ["can't be blank"]} = errors_on(changeset)
    end

    test "room_id should be required" do
      changeset = Message.changeset(%Message{}, %{})
      assert %{room_id: ["can't be blank"]} = errors_on(changeset)
    end

    test "content should be required" do
      changeset = Message.changeset(%Message{}, %{})
      assert %{content: ["can't be blank"]} = errors_on(changeset)
    end

    test "type should be required" do
      changeset = Message.changeset(%Message{}, %{})
      assert %{type: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "content length validation" do
    test "should be at least 1 char" do
      changeset = Message.changeset(%Message{}, %{content: ""})
      assert %{content: ["can't be blank"]} = errors_on(changeset)
    end

    test "should be at most 255 chars" do
      changeset = Message.changeset(%Message{}, %{content: "a" <> String.duplicate("a", 255)})
      assert %{content: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end
  end
end
