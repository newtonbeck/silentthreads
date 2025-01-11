defmodule SilentThreads.Domain.Repository.Participants do

  alias SilentThreads.Domain.Model.Participant
  alias SilentThreads.Repo

  def join(room, %{nickname: nickname}) do
    %Participant{}
      |> Participant.changeset(%{room_id: room.id, nickname: nickname})
      |> Repo.insert()
  end
end
