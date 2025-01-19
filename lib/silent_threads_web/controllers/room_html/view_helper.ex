defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelper do

  def group_messages_by_author(all_messages) do
    Enum.reduce(all_messages, [], fn (message, acc) -> case List.last(acc) do
        nil -> acc ++ [%{
          author: %{
            id: message.author_id,
          },
          messages: [message]
        }]
        %{ author: author, messages: messages } when author.id == message.author_id ->
          List.replace_at(acc, -1, %{
            author: author,
            messages: messages ++ [message]
          })
        _ -> acc ++ [%{
          author: %{
            id: message.author_id,
          },
          messages: [message]
        }]
      end
    end)
  end

end
