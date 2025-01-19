defmodule SilentThreads.Domain.Repository.Messages do

  import Ecto.Query

  alias SilentThreads.Domain.Model.Message
  alias SilentThreads.Repo

  def find_by_room(room_id) do
    Repo.all(from m in Message, where: m.room_id == ^room_id)
  end

  def send(room, author, content) do
    %Message{}
    |> Message.changeset(%{room_id: room.id, author_id: author.id, content: content, type: "participant"})
    |> Repo.insert()
  end
end
