defmodule SilentThreads.Infra.PubSub.RoomsTopic do
  def subscribe(%{id: id}) do
    Phoenix.PubSub.subscribe(SilentThreads.PubSub, "rooms:#{id}")
  end

  def broadcast(%{id: id}, message) do
    Phoenix.PubSub.broadcast(SilentThreads.PubSub, "rooms:#{id}", message)
  end
end
