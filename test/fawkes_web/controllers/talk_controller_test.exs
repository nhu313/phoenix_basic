defmodule FawkesWeb.TalkControllerTest do
  use FawkesWeb.ConnCase

  alias Fawkes.Schedule

  @create_attrs %{description: "some description", slug: "some slug", title: "some title"}
  @update_attrs %{description: "some updated description", slug: "some updated slug", title: "some updated title"}
  @invalid_attrs %{description: nil, slug: nil, title: nil}

  def fixture(:talk) do
    {:ok, talk} = Schedule.create_talk(@create_attrs)
    talk
  end

  describe "index" do
    test "lists all talks", %{conn: conn} do
      conn = get conn, talk_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Talks"
    end
  end

  describe "new talk" do
    test "renders form", %{conn: conn} do
      conn = get conn, talk_path(conn, :new)
      assert html_response(conn, 200) =~ "New Talk"
    end
  end

  describe "create talk" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, talk_path(conn, :create), talk: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == talk_path(conn, :show, id)

      conn = get conn, talk_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Talk"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, talk_path(conn, :create), talk: @invalid_attrs
      assert html_response(conn, 200) =~ "New Talk"
    end
  end

  describe "edit talk" do
    setup [:create_talk]

    test "renders form for editing chosen talk", %{conn: conn, talk: talk} do
      conn = get conn, talk_path(conn, :edit, talk)
      assert html_response(conn, 200) =~ "Edit Talk"
    end
  end

  describe "update talk" do
    setup [:create_talk]

    test "redirects when data is valid", %{conn: conn, talk: talk} do
      conn = put conn, talk_path(conn, :update, talk), talk: @update_attrs
      assert redirected_to(conn) == talk_path(conn, :show, talk)

      conn = get conn, talk_path(conn, :show, talk)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, talk: talk} do
      conn = put conn, talk_path(conn, :update, talk), talk: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Talk"
    end
  end

  describe "delete talk" do
    setup [:create_talk]

    test "deletes chosen talk", %{conn: conn, talk: talk} do
      conn = delete conn, talk_path(conn, :delete, talk)
      assert redirected_to(conn) == talk_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, talk_path(conn, :show, talk)
      end
    end
  end

  defp create_talk(_) do
    talk = fixture(:talk)
    {:ok, talk: talk}
  end
end
