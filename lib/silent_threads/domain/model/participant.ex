defmodule SilentThreads.Domain.Model.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    field :room_id, :integer
    field :nickname, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:room_id, :nickname])
    |> validate_required([:room_id, :nickname])
    |> validate_length(:nickname, min: 3, max: 50)
  end
end
