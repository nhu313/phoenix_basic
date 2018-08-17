defmodule FawkesWeb.TalkView do
  use FawkesWeb, :view

  def format_date(datetime) do
    "#{datetime.month}/#{datetime.day}/#{datetime.year}"
  end

  def format_time(datetime) do
    "#{datetime.hour}:#{datetime.minute}"
  end
end
