defmodule SilentThreadsWeb.RoomController do

  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.ShowRoom
  alias SilentThreads.Domain.UseCase.SendMessage

  @fake_current_participant %{id: 30}

  def show(conn, %{"id" => id}) do
    case ShowRoom.show(id) do
      {:ok, %{room: room, participants: participants, messages: messages}} ->
        conn
        |> put_layout(html: :app)
        |> render(:show, room: room, participants: participants, messages: messages, current_participant: @fake_current_participant)
      {:error, _} ->
        conn
        |> put_flash(:error, "Room not found")
        |> redirect(to: ~p"/")
    end
  end

  def send_message(conn, %{"message" => message, "id" => room_id}) do
    case SendMessage.send(room_id, @fake_current_participant, message) do
      {:ok, %{room: room}} ->
        # TODO Send message to the room channel
        conn |> redirect(to: ~p"/room/#{room.id}")
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: ~p"/room/#{room_id}")
    end
  end

end
