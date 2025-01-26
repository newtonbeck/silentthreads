defmodule SilentThreads.Infra.PubSub.MessagesTopic do
  def subscribe(%{id: id}) do
    Phoenix.PubSub.subscribe(SilentThreads.PubSub, "rooms:#{id}")
  end

  def broadcast(%{id: id}, message) do
    Phoenix.PubSub.broadcast(SilentThreads.PubSub, "rooms:#{id}", message)
  end
end
