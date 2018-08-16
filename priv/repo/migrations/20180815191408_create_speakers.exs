defmodule Fawkes.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :slug, :string
      add :image, :string
      add :first, :string
      add :last, :string
      add :company, :string
      add :github, :string
      add :twitter, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:speakers, [:slug])
  end
end
