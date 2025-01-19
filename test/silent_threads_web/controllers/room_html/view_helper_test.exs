defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelperTest do

  alias SilentThreadsWeb.Controllers.RoomHtml.ViewHelper
  use ExUnit.Case

  describe "group_messages_by_participant" do
    test "it should add a new participant group when acc is empty" do
      messages = [
        %{author_id: 1, content: "Hi"},
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
            %{author_id: 1, content: "Hi"},
          ]
        }
      ]
    end

    test "it should group messages from same participant" do
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

      grouped_messages = ViewHelper.group_messages_by_participant(messages, participants)

      assert grouped_messages == [
        %{
          participant: %{
            id: 1,
            nickname: "Alice",
          },
          messages: [
            %{author_id: 1, content: "Hi"},
            %{author_id: 1, content: "How are you?"},
          ]
        },
        %{
          participant: %{
            id: 3,
            nickname: "Charlie",
          },
          messages: [
            %{author_id: 3, content: "Hey"},
          ]
        },
        %{
          participant: %{
            id: 2,
            nickname: "Bob",
          },
          messages: [
            %{author_id: 2, content: "Hallo"},
            %{author_id: 2, content: "Wie geth's?"},
          ]
        },
        %{
          participant: %{
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

end
