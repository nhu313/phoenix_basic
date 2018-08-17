defmodule Fawkes.Schedule.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType
  alias Fawkes.Schedule.Slot

  @type t :: %__MODULE__{}

  schema "events" do
    field :name, :string
    field :slug, SymbolType

    belongs_to :slot, Slot

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:slug, :name, :slot_id])
    |> validate_required([:slug, :name, :slot_id])
    |> unique_constraint(:slug)
    |> assoc_constraint(:slot)
  end
end
