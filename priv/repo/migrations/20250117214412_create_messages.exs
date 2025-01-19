defmodule SilentThreads.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :author_id, references(:participants, on_delete: :delete_all)
      add :room_id, references(:rooms, on_delete: :delete_all)
      add :content, :text
      add :type, :string

      timestamps(type: :utc_datetime)
    end
  end
end
