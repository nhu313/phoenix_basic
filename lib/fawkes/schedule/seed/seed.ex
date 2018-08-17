defmodule Fawkes.Schedule.Seed do
  alias Fawkes.Schedule.Seed.Audience
  alias Fawkes.Schedule.Seed.Category
  alias Fawkes.Schedule.Seed.Event
  alias Fawkes.Schedule.Seed.Location
  alias Fawkes.Schedule.Seed.Slot
  alias Fawkes.Schedule.Seed.Speaker
  alias Fawkes.Schedule.Seed.Talk

  def perform do
    Slot.perform()
    Speaker.perform()
    Location.perform()
    Category.perform()
    Audience.perform()
    Talk.perform()
    Event.perform()

    Enum.each(image_files(), fn(file) ->
      File.cp("priv/repo/seed_images/#{file}", "priv/static/images/#{file}")
    end)
  end

  def image_files do
    [
      "jose-valim.jpg",
      "lance-halvorsen.jpg",
      "anna-neyzberg.jpg",
      "luke-imhoff.jpg",
      "bailey-miller",
      "fahad-almusharraf.jpg",
      "manu-ajith.jpg",
      "aaron-renner.jpg",
      "justus-eapen.jpg",
      "aish-dahal.jpg",
      "catherine-zoller.jpg",
      "david-schainker.jpg",
      "maciej-kaszubowski.jpg",
      "aaron-votre.jpg",
      "frank-kumro.jpg",
      "ben-marx.jpg",
      "anil-wadghule.jpg",
      "todd-resudek.jpg",
      "mathew-gardner.jpg",
      "justin-schneck.jpg",
      "renan-ranelli.jpg",
      "james-smith.jpg",
      "michael-stalker.jpg",
      "jeff-schomay.jpg",
      "zach-porter.jpg",
      "andrew-bennett.jpg",
      "eric-oestrich.jpg",
      "daniel-azuma.jpg",
      "rafal-studnicki.jpg",
      "emerson-macedo.jpg",
      "jerel-unruh.jpg",
      "boyd-multerer.jpg",
      "joao-britto.jpg",
      "jeffrey-gillis.jpg",
      "dan-mcguire.jpg",
      "alex-garibay.jpg",
      "guilherme-de-maio.jpg",
      "enio-lopes.jpg",
      "chris-mccord.jpg"
    ]
  end
end
