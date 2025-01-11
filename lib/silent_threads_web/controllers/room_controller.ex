defmodule SilentThreadsWeb.RoomController do

  alias SilentThreads.Domain.UseCase.CreateRoom

  use SilentThreadsWeb, :controller

  def create(conn, params) do
    room = CreateRoom.create_room(params)
    conn |> redirect(to: ~p"/rooms/#{room.id}")
  end

  def show(conn, _params) do
    conn
    |> put_layout(html: :app)
    |> render(:show)
  end

end
