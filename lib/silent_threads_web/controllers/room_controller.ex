defmodule SilentThreadsWeb.RoomController do

  use SilentThreadsWeb, :controller

  def show(conn, _params) do
    conn
    |> put_layout(html: :app)
    |> render(:show)
  end

end
