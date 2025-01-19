defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelperTest do

  alias SilentThreadsWeb.Controllers.RoomHtml.ViewHelper
  use ExUnit.Case

  test "it should add a new participant group when acc is empty" do
    messages = [
      %{participant_id: 1, content: "Hi"},
    ]
    participants = [
      %{id: 1, nickname: "Alice"},
    ]

    grouped_messages = ViewHelper.group_messages_by_participant(messages, participants)

    assert grouped_messages == [
      %{
        participant: %{
          id: 1,
          nickname: "Alice",
        },
        messages: [
          %{participant_id: 1, content: "Hi"},
        ]
      }
    ]
  end

  test "it should group messages from same participant" do
    messages = [
      %{participant_id: 1, content: "Hi"},
      %{participant_id: 1, content: "How are you?"},
      %{participant_id: 3, content: "Hey"},
      %{participant_id: 2, content: "Hallo"},
      %{participant_id: 2, content: "Wie geth's?"},
      %{participant_id: 4, content: "Olá!"},
    ]
    participants = [
      %{id: 1, nickname: "Alice"},
      %{id: 2, nickname: "Bob"},
      %{id: 3, nickname: "Charlie"},
      %{id: 4, nickname: "David"},
    ]

    grouped_messages = ViewHelper.group_messages_by_participant(messages, participants)

    assert grouped_messages == [
      %{
        participant: %{
          id: 1,
          nickname: "Alice",
        },
        messages: [
          %{participant_id: 1, content: "Hi"},
          %{participant_id: 1, content: "How are you?"},
        ]
      },
      %{
        participant: %{
          id: 3,
          nickname: "Charlie",
        },
        messages: [
          %{participant_id: 3, content: "Hey"},
        ]
      },
      %{
        participant: %{
          id: 2,
          nickname: "Bob",
        },
        messages: [
          %{participant_id: 2, content: "Hallo"},
          %{participant_id: 2, content: "Wie geth's?"},
        ]
      },
      %{
        participant: %{
          id: 4,
          nickname: "David",
        },
        messages: [
          %{participant_id: 4, content: "Olá!"},
        ]
      },
    ]
  end
end
