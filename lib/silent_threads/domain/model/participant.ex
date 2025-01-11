defmodule SilentThreads.Domain.Model.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    field :nickname, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:nickname])
    |> validate_required([:nickname])
  end
end
