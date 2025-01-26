defmodule SilentThreadsWeb.RoomController do
  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.ShowRoom
  alias SilentThreads.Domain.UseCase.SendMessage
  alias SilentThreads.Domain.Repository.Rooms

  def show(conn, %{"id" => id}) do
    current_participant = get_session(conn, :participant)

    case ShowRoom.show(id) do
      {:ok, %{room: room, participants: participants, messages: messages}} ->
        conn
        |> put_layout(html: :app)
        |> render(:show,
          room: room,
          participants: participants,
          messages: messages,
          current_participant: current_participant
        )

      {:error, _} ->
        conn
        |> put_flash(:error, "Room not found")
        |> redirect(to: ~p"/")
    end
  end

  def send_message(conn, %{"message" => message, "id" => room_id}) do
    current_participant = get_session(conn, :participant)

    case SendMessage.send(room_id, current_participant, message) do
      {:ok, %{room: room}} ->
        conn |> redirect(to: ~p"/room/#{room.id}")

      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: ~p"/room/#{room_id}")
    end
  end

  def show_join(conn, %{"id" => id}) do
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
        |> render(:join, id: room.id, changeset: empty_changeset)
    end
  end
end
