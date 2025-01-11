defmodule SilentThreadsWeb.PageController do
  use SilentThreadsWeb, :controller

  def home(conn, _params) do
    conn
      |> put_layout(html: :app)
      |> render(:home)
  end
end
