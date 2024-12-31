defmodule SilentthreadsWeb.PageController do
  use SilentthreadsWeb, :controller

  def home(conn, _params) do
    conn
      |> put_layout(html: :app)
      |> render(:home)
  end
end
