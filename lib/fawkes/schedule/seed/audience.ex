defmodule Fawkes.Schedule.Seed.Audience do
  alias Fawkes.Schedule.Audience
  alias Fawkes.Repo

  def perform do
    Enum.each(data(), fn(attrs) ->
      %Audience{}
      |> Audience.changeset(attrs)
      |> Repo.insert()
    end)
  end

  def data do
    [
      %{
        slug: :general,
        name: "General"
      },
      %{
        slug: :beginner,
        name: "Beginner"
      },
      %{
        slug: :intermediate,
        name: "Intermediate"
      },
      %{
        slug: :advanced,
        name: "Advanced"
      }
    ]
  end
end
