defmodule SilentThreadsWeb.RoomController do

  alias SilentThreads.Domain.UseCase.StartRoom

  use SilentThreadsWeb, :controller

  def start(conn, %{"nickname" => nickname}) do
    case StartRoom.start(%{nickname: nickname}) do
      {:ok, room, _participant} -> conn |> redirect(to: ~p"/rooms/#{room.id}")
      {:error, {:validation, validation_errors}} -> conn |> put_layout(html: :app) |> render(:home, validation_errors: validation_errors)
      _ -> conn |> put_layout(html: :app) |> render(:home, global_error: "Ops, something went wrong")
    end
  end

  def show(conn, _params) do
    conn
    |> put_layout(html: :app)
    |> render(:show)
  end

end
