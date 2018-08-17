defmodule Fawkes.Repo.Migrations.AlterSlotTimeToDateTime do
  use Ecto.Migration

  def change do
    alter table("schedule_slots") do
      remove :date
      remove :time
      add :start, :naive_datetime
      add :finish, :naive_datetime
    end
  end
end
