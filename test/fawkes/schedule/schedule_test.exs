defmodule Fawkes.ScheduleTest do
  use Fawkes.DataCase

  alias Fawkes.Schedule

  describe "speakers" do
    alias Fawkes.Schedule.Speaker

    @valid_attrs %{company: "some company", description: "some description", first: "some first", github: "some github", image: "some image", last: "some last", slug: "some slug", twitter: "some twitter"}
    @update_attrs %{company: "some updated company", description: "some updated description", first: "some updated first", github: "some updated github", image: "some updated image", last: "some updated last", slug: "some updated slug", twitter: "some updated twitter"}
    @invalid_attrs %{company: nil, description: nil, first: nil, github: nil, image: nil, last: nil, slug: nil, twitter: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_speaker()

      speaker
    end

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert Schedule.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert Schedule.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = Schedule.create_speaker(@valid_attrs)
      assert speaker.company == "some company"
      assert speaker.description == "some description"
      assert speaker.first == "some first"
      assert speaker.github == "some github"
      assert speaker.image == "some image"
      assert speaker.last == "some last"
      assert speaker.slug == "some slug"
      assert speaker.twitter == "some twitter"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, speaker} = Schedule.update_speaker(speaker, @update_attrs)
      assert %Speaker{} = speaker
      assert speaker.company == "some updated company"
      assert speaker.description == "some updated description"
      assert speaker.first == "some updated first"
      assert speaker.github == "some updated github"
      assert speaker.image == "some updated image"
      assert speaker.last == "some updated last"
      assert speaker.slug == "some updated slug"
      assert speaker.twitter == "some updated twitter"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_speaker(speaker, @invalid_attrs)
      assert speaker == Schedule.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = Schedule.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = Schedule.change_speaker(speaker)
    end
  end

  describe "schedule_slots" do
    alias Fawkes.Schedule.Slot

    @valid_attrs %{date: "some date", slug: "some slug", time: "some time"}
    @update_attrs %{date: "some updated date", slug: "some updated slug", time: "some updated time"}
    @invalid_attrs %{date: nil, slug: nil, time: nil}

    def slot_fixture(attrs \\ %{}) do
      {:ok, slot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_slot()

      slot
    end

    test "list_schedule_slots/0 returns all schedule_slots" do
      slot = slot_fixture()
      assert Schedule.list_schedule_slots() == [slot]
    end

    test "get_slot!/1 returns the slot with given id" do
      slot = slot_fixture()
      assert Schedule.get_slot!(slot.id) == slot
    end

    test "create_slot/1 with valid data creates a slot" do
      assert {:ok, %Slot{} = slot} = Schedule.create_slot(@valid_attrs)
      assert slot.date == "some date"
      assert slot.slug == "some slug"
      assert slot.time == "some time"
    end

    test "create_slot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_slot(@invalid_attrs)
    end

    test "update_slot/2 with valid data updates the slot" do
      slot = slot_fixture()
      assert {:ok, slot} = Schedule.update_slot(slot, @update_attrs)
      assert %Slot{} = slot
      assert slot.date == "some updated date"
      assert slot.slug == "some updated slug"
      assert slot.time == "some updated time"
    end

    test "update_slot/2 with invalid data returns error changeset" do
      slot = slot_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_slot(slot, @invalid_attrs)
      assert slot == Schedule.get_slot!(slot.id)
    end

    test "delete_slot/1 deletes the slot" do
      slot = slot_fixture()
      assert {:ok, %Slot{}} = Schedule.delete_slot(slot)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_slot!(slot.id) end
    end

    test "change_slot/1 returns a slot changeset" do
      slot = slot_fixture()
      assert %Ecto.Changeset{} = Schedule.change_slot(slot)
    end
  end

  describe "locations" do
    alias Fawkes.Schedule.Location

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Schedule.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Schedule.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Schedule.create_location(@valid_attrs)
      assert location.name == "some name"
      assert location.slug == "some slug"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, location} = Schedule.update_location(location, @update_attrs)
      assert %Location{} = location
      assert location.name == "some updated name"
      assert location.slug == "some updated slug"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_location(location, @invalid_attrs)
      assert location == Schedule.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Schedule.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Schedule.change_location(location)
    end
  end

  describe "audiences" do
    alias Fawkes.Schedule.Audience

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def audience_fixture(attrs \\ %{}) do
      {:ok, audience} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_audience()

      audience
    end

    test "list_audiences/0 returns all audiences" do
      audience = audience_fixture()
      assert Schedule.list_audiences() == [audience]
    end

    test "get_audience!/1 returns the audience with given id" do
      audience = audience_fixture()
      assert Schedule.get_audience!(audience.id) == audience
    end

    test "create_audience/1 with valid data creates a audience" do
      assert {:ok, %Audience{} = audience} = Schedule.create_audience(@valid_attrs)
      assert audience.name == "some name"
      assert audience.slug == "some slug"
    end

    test "create_audience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_audience(@invalid_attrs)
    end

    test "update_audience/2 with valid data updates the audience" do
      audience = audience_fixture()
      assert {:ok, audience} = Schedule.update_audience(audience, @update_attrs)
      assert %Audience{} = audience
      assert audience.name == "some updated name"
      assert audience.slug == "some updated slug"
    end

    test "update_audience/2 with invalid data returns error changeset" do
      audience = audience_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_audience(audience, @invalid_attrs)
      assert audience == Schedule.get_audience!(audience.id)
    end

    test "delete_audience/1 deletes the audience" do
      audience = audience_fixture()
      assert {:ok, %Audience{}} = Schedule.delete_audience(audience)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_audience!(audience.id) end
    end

    test "change_audience/1 returns a audience changeset" do
      audience = audience_fixture()
      assert %Ecto.Changeset{} = Schedule.change_audience(audience)
    end
  end

  describe "talks" do
    alias Fawkes.Schedule.Talk

    @valid_attrs %{description: "some description", slug: "some slug", title: "some title"}
    @update_attrs %{description: "some updated description", slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{description: nil, slug: nil, title: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_talk()

      talk
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert Schedule.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert Schedule.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = Schedule.create_talk(@valid_attrs)
      assert talk.description == "some description"
      assert talk.slug == "some slug"
      assert talk.title == "some title"
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, talk} = Schedule.update_talk(talk, @update_attrs)
      assert %Talk{} = talk
      assert talk.description == "some updated description"
      assert talk.slug == "some updated slug"
      assert talk.title == "some updated title"
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_talk(talk, @invalid_attrs)
      assert talk == Schedule.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = Schedule.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = Schedule.change_talk(talk)
    end
  end

  describe "events" do
    alias Fawkes.Schedule.Event

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Schedule.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Schedule.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Schedule.create_event(@valid_attrs)
      assert event.name == "some name"
      assert event.slug == "some slug"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Schedule.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.name == "some updated name"
      assert event.slug == "some updated slug"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_event(event, @invalid_attrs)
      assert event == Schedule.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Schedule.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Schedule.change_event(event)
    end
  end
end
