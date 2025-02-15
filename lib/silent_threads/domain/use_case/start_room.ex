defmodule SilentThreads.Domain.UseCase.StartRoom do
  alias SilentThreads.Domain.Repository.{Rooms, Participants}
  alias SilentThreads.Repo

  def start(attrs) do
    Repo.transaction(fn ->
      with {:ok, room} <- Rooms.create(),
           {:ok, participant} <- Participants.join(room, attrs) do
        # TODO Sent message that first participant joined
        %{room: room, participant: participant}
      else
        {:error, e} ->
          Repo.rollback(e)
      end
    end)
  end
end
