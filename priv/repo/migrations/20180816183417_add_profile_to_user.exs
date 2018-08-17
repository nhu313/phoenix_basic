defmodule Fawkes.Repo.Migrations.AddProfileToUser do
  use Ecto.Migration

  def change do
    alter table("profiles") do
      add :user_id, references("users")
      add :title, :string
    end
  end
end
