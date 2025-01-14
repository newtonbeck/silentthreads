defmodule SilentThreadsWeb.HomeController do
  use SilentThreadsWeb, :controller

  alias SilentThreads.Domain.UseCase.StartRoom
  alias SilentThreads.Domain.Model.Participant

  def index(conn, _params) do
    changeset = Participant.changeset(%Participant{}, %{})
    conn
      |> put_layout(html: :app)
      |> render(:index, changeset: changeset)
  end

  def start_room(conn, %{"nickname" => nickname}) do
    case StartRoom.start(%{nickname: nickname}) do
      {:ok, room, _participant} -> conn |> redirect(to: ~p"/room/#{room.id}")
      {:error, %Ecto.Changeset{} = changeset} -> conn |> put_layout(html: :app) |> render(:index, changeset: changeset)
    end
  end

end
