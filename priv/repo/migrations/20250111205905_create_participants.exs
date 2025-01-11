defmodule Silentthreads.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :nickname, :string, size: 50, null: false
      add :room_id, references(:rooms, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:participants, [:room_id])
    create unique_index(:participants, [:room_id, :nickname])
  end
end
