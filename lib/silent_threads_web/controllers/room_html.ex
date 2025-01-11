defmodule SilentThreadsWeb.RoomHTML do
  @moduledoc """
  This module contains pages rendered by RoomController.

  See the `room_html` directory for all templates available.
  """
  use SilentThreadsWeb, :html

  embed_templates "room_html/*"
end
