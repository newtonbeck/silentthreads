defmodule SilentThreadsWeb.Controllers.RoomHtml.ViewHelper do
  def group_messages_by_participant([], _participants) do
    []
  end

  def group_messages_by_participant(all_messages, participants) do
    Enum.reduce(all_messages, [], fn message, acc ->
      case List.last(acc) do
        nil ->
          acc ++
            [
              %{
                participant: Enum.find(participants, &(&1.id == message.author_id)),
                messages: [message]
              }
            ]

        %{participant: participant, messages: messages}
        when participant.id == message.author_id ->
          List.replace_at(acc, -1, %{
            participant: participant,
            messages: messages ++ [message]
          })

        _ ->
          acc ++
            [
              %{
                participant: Enum.find(participants, &(&1.id == message.author_id)),
                messages: [message]
              }
            ]
      end
    end)
  end

  def own_participant_article_class(participant, current_participant) do
    if participant.id == current_participant.id do
      %{class: "flex flex-col items-end mb-4"}
    else
      %{class: "mb-4"}
    end
  end

  def own_participant_ul_class(participant, current_participant) do
    if participant.id == current_participant.id do
      %{class: "flex flex-col items-end gap-4"}
    else
      %{class: "flex flex-col gap-4"}
    end
  end
end
