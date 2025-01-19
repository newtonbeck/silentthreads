defmodule SilentThreads.Domain.Repository.Messages do

  import Ecto.Query

  alias SilentThreads.Domain.Model.Message
  alias SilentThreads.Repo

  def find_by_room(room_id) do
    Repo.all(from m in Message, where: m.room_id == ^room_id)
  end
end
