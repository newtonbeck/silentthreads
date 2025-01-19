defmodule SilentThreadsWeb.RoomController do

  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.ShowRoom

  def show(conn, %{"id" => id}) do
    case ShowRoom.show(id) do
      {:ok, %{room: room, participants: participants, messages: messages}} ->
        conn
        |> put_layout(html: :app)
        |> render(:show, room: room, participants: participants, messages: messages)
      {:error, _} ->
        conn
        |> put_flash(:error, "Room not found")
        |> redirect(to: ~p"/")
    end
  end

end
