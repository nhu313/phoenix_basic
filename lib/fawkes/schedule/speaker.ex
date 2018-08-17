defmodule Fawkes.Schedule.Speaker do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  schema "profiles" do
    field :company, :string
    field :description, :string
    field :first, :string
    field :github, :string
    field :image, Fawkes.ImageUploader.Type
    field :last, :string
    field :slug, SymbolType
    field :twitter, :string

    has_one :talk, Fawkes.Schedule.Talk

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:slug, :image, :first, :last, :company, :github, :twitter, :description])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:slug, :image, :first, :last, :description])
    |> unique_constraint(:slug)
  end
end
