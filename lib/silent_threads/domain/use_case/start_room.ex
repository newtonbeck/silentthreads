defmodule SilentThreads.Domain.UseCase.StartRoom do

  alias SilentThreads.Domain.Repository.{Rooms, Participants}
  alias SilentThreads.Repo

  def start(attrs) do
    Repo.transaction(fn ->
      with {:ok, room} <- Rooms.create(),
           {:ok, participant} <- Participants.join(room, attrs) do
        {room, participant}
      else
        {:error, %{valid?: false, errors: errors}} ->
          Repo.rollback({:validation, errors})
        {:error, e} ->
          Repo.rollback({:unknown, e})
      end
    end)
  end
end
