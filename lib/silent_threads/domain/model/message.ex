defmodule SilentThreads.Domain.Model.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :type, :string
    field :author_id, :integer
    field :room_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:author_id, :room_id, :content, :type])
    |> validate_required([:author_id, :room_id, :content, :type])
    |> validate_length(:content, max: 255)
  end
end
