defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelperTest do

  alias SilentThreadsWeb.Controllers.RoomHtml.ViewHelper
  use ExUnit.Case

  test "it should add a new author group when acc is empty" do
    messages = [
      %{author_id: 1, content: "Hi"},
    ]
    participants = [
      %{id: 1, nickname: "Alice"},
    ]

    grouped_messages = ViewHelper.group_messages_by_author(messages, participants)

    assert grouped_messages == [
      %{
        author: %{
          id: 1,
          nickname: "Alice",
        },
        messages: [
          %{author_id: 1, content: "Hi"},
        ]
      }
    ]
  end

  test "it should group messages from same author" do
    messages = [
      %{author_id: 1, content: "Hi"},
      %{author_id: 1, content: "How are you?"},
      %{author_id: 3, content: "Hey"},
      %{author_id: 2, content: "Hallo"},
      %{author_id: 2, content: "Wie geth's?"},
      %{author_id: 4, content: "Olá!"},
    ]
    participants = [
      %{id: 1, nickname: "Alice"},
      %{id: 2, nickname: "Bob"},
      %{id: 3, nickname: "Charlie"},
      %{id: 4, nickname: "David"},
    ]

    grouped_messages = ViewHelper.group_messages_by_author(messages, participants)

    assert grouped_messages == [
      %{
        author: %{
          id: 1,
          nickname: "Alice",
        },
        messages: [
          %{author_id: 1, content: "Hi"},
          %{author_id: 1, content: "How are you?"},
        ]
      },
      %{
        author: %{
          id: 3,
          nickname: "Charlie",
        },
        messages: [
          %{author_id: 3, content: "Hey"},
        ]
      },
      %{
        author: %{
          id: 2,
          nickname: "Bob",
        },
        messages: [
          %{author_id: 2, content: "Hallo"},
          %{author_id: 2, content: "Wie geth's?"},
        ]
      },
      %{
        author: %{
          id: 4,
          nickname: "David",
        },
        messages: [
          %{author_id: 4, content: "Olá!"},
        ]
      },
    ]
  end
end
