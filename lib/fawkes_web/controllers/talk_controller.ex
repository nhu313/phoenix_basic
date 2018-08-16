defmodule FawkesWeb.TalkController do
  use FawkesWeb, :controller

  alias Fawkes.Schedule
  alias Fawkes.Schedule.Talk

  def index(conn, _params) do
    talks = Schedule.list_talks()
    render(conn, "index.html", talks: talks)
  end

  def new(conn, _params) do
    changeset = Schedule.change_talk(%Talk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"talk" => talk_params}) do
    case Schedule.create_talk(talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: talk_path(conn, :show, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    render(conn, "show.html", talk: talk)
  end

  def edit(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    changeset = Schedule.change_talk(talk)
    render(conn, "edit.html", talk: talk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}) do
    talk = Schedule.get_talk!(id)

    case Schedule.update_talk(talk, talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk updated successfully.")
        |> redirect(to: talk_path(conn, :show, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", talk: talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    {:ok, _talk} = Schedule.delete_talk(talk)

    conn
    |> put_flash(:info, "Talk deleted successfully.")
    |> redirect(to: talk_path(conn, :index))
  end
end
