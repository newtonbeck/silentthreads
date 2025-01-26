defmodule SilentThreadsWeb.HomeController do
  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.StartRoom

  def index(conn, _params) do
    empty_changeset = %{
      valid?: true,
      params: %{}
    }

    conn
    |> put_layout(html: :app)
    |> render(:index, changeset: empty_changeset)
  end

  def start_room(conn, %{"nickname" => nickname}) do
    case StartRoom.start(%{nickname: nickname}) do
      {:ok, %{room: room, participant: participant}} ->
        conn
        |> put_session(:participant, participant)
        |> redirect(to: ~p"/rooms/#{room.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> put_layout(html: :app) |> render(:index, changeset: changeset)
    end
  end
end
