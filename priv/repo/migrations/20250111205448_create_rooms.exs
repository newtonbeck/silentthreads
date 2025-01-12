defmodule SilentThreads.Repo.Migrations.StartRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do

      timestamps(type: :utc_datetime)
    end
  end
end
