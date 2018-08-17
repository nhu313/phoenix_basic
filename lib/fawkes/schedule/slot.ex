defmodule Fawkes.Schedule.Slot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType
  alias Fawkes.Schedule.Event
  alias Fawkes.Schedule.Talk

  @type t :: %__MODULE__{}

  schema "schedule_slots" do
    field :finish, :naive_datetime
    field :slug, SymbolType
    field :start, :naive_datetime

    has_one :event, Event
    has_many :talks, Talk

    timestamps()
  end

  @doc false
  def changeset(slot, attrs) do
    slot
    |> cast(attrs, [:slug, :start, :finish])
    |> validate_required([:slug, :start, :finish])
    |> unique_constraint(:slug)
  end
end
