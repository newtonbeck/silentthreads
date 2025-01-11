defmodule SilentThreadsWeb.RoomController do

  alias SilentThreads.Domain.UseCase.CreateRoom

  use SilentThreadsWeb, :controller

  def create(conn, %{"nickname" => nickname}) do
    with {:ok, room, _participant} <- CreateRoom.create_room(%{nickname: nickname}) do
      conn |> redirect(to: ~p"/rooms/#{room.id}")
    else
      {:error, _} -> conn |> put_flash(:error, "Failed to create room") |> redirect(to: "/")
    end
  end

  def show(conn, _params) do
    conn
    |> put_layout(html: :app)
    |> render(:show)
  end

end
