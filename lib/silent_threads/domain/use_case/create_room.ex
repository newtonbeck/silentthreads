defmodule SilentThreads.Domain.UseCase.CreateRoom do

  alias SilentThreads.Domain.Repository.{Rooms}

  def create_room(attrs) do
    room = Rooms.create(attrs)
    # Creates a new participant
    # Returns the room
    room
  end

end
