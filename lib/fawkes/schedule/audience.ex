defmodule Fawkes.Schedule.Audience do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  schema "audiences" do
    field :name, :string
    field :slug, SymbolType

    timestamps()
  end

  @doc false
  def changeset(audience, attrs) do
    audience
    |> cast(attrs, [:slug, :name])
    |> validate_required([:slug, :name])
    |> unique_constraint(:slug)
  end
end
