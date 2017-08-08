defmodule Plugapi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :user_id, :integer, null: false
      add :title, :string
      add :body, :text
      add :priority, :integer, default: 1
      timestamps()
    end
  end
end
