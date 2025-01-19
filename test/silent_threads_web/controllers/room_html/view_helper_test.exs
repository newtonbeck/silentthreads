defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelperTest do

  alias SilentThreadsWeb.Controllers.RoomHtml.ViewHelper
  use ExUnit.Case

  test "it should add a new author group when acc is empty" do
    messages = [
      %{author_id: 1, content: "Hi"},
    ]

    grouped_messages = ViewHelper.group_messages_by_author(messages)

    assert grouped_messages == [
      %{
        author: %{
          id: 1,
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

    grouped_messages = ViewHelper.group_messages_by_author(messages)

    assert grouped_messages == [
      %{
        author: %{
          id: 1,
        },
        messages: [
          %{author_id: 1, content: "Hi"},
          %{author_id: 1, content: "How are you?"},
        ]
      },
      %{
        author: %{
          id: 3,
        },
        messages: [
          %{author_id: 3, content: "Hey"},
        ]
      },
      %{
        author: %{
          id: 2,
        },
        messages: [
          %{author_id: 2, content: "Hallo"},
          %{author_id: 2, content: "Wie geth's?"},
        ]
      },
      %{
        author: %{
          id: 4,
        },
        messages: [
          %{author_id: 4, content: "Olá!"},
        ]
      },
    ]
  end
end
