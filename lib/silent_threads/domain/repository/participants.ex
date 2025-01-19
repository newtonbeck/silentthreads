defmodule SilentThreads.Domain.Repository.Participants do

  import Ecto.Query

  alias SilentThreads.Domain.Model.Participant
  alias SilentThreads.Repo


  def join(%{ id: room_id}, %{nickname: nickname}) do
    %Participant{}
      |> Participant.changeset(%{room_id: room_id, nickname: nickname})
      |> Repo.insert()
  end

  def find_by_room(room_id) do
    Repo.all(from p in Participant, where: p.room_id == ^room_id)
  end
end
