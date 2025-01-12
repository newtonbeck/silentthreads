defmodule SilentThreadsWeb.HomeController do
  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.StartRoom

  def index(conn, _params) do
    conn
      |> put_layout(html: :app)
      |> render(:index)
  end

  def start_room(conn, %{"nickname" => nickname}) do
    case StartRoom.start(%{nickname: nickname}) do
      {:ok, room, _participant} -> conn |> redirect(to: ~p"/room/#{room.id}")
      {:error, {:validation, validation_errors}} -> conn |> put_layout(html: :app) |> render(:index, validation_errors: validation_errors)
      _ -> conn |> put_layout(html: :app) |> render(:index, global_error: "Ops, something went wrong")
    end
  end

end
