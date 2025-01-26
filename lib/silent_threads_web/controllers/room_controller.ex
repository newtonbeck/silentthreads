defmodule SilentThreadsWeb.RoomController do
  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.JoinRoom
  alias SilentThreads.Domain.Repository.Rooms

  def lobby(conn, %{"id" => id}) do
    case Rooms.find(id) do
      nil ->
        conn
        |> put_flash(:error, "Room not found")
        |> redirect(to: ~p"/")

      room ->
        empty_changeset = %{
          valid?: true,
          params: %{}
        }

        conn
        |> put_layout(html: :app)
        |> render(:lobby, room_id: room.id, changeset: empty_changeset)
    end
  end

  def join(conn, %{"id" => id, "nickname" => nickname}) do
    case JoinRoom.join(id, %{nickname: nickname}) do
      {:ok, %{room: room, participant: participant}} ->
        conn
        |> put_session(:participant, participant)
        |> redirect(to: ~p"/rooms/#{room.id}")

      {:error, :room_not_found} ->
        conn
        |> put_flash(:error, "Room not found")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_layout(html: :app)
        |> render(:join, id: id, changeset: changeset)
    end
  end
end
