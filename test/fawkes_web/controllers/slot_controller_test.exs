defmodule FawkesWeb.SlotControllerTest do
  use FawkesWeb.ConnCase

  alias Fawkes.Schedule

  @create_attrs %{date: "some date", slug: "some slug", time: "some time"}
  @update_attrs %{date: "some updated date", slug: "some updated slug", time: "some updated time"}
  @invalid_attrs %{date: nil, slug: nil, time: nil}

  def fixture(:slot) do
    {:ok, slot} = Schedule.create_slot(@create_attrs)
    slot
  end

  describe "index" do
    test "lists all schedule_slots", %{conn: conn} do
      conn = get conn, slot_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Schedule slots"
    end
  end

  describe "new slot" do
    test "renders form", %{conn: conn} do
      conn = get conn, slot_path(conn, :new)
      assert html_response(conn, 200) =~ "New Slot"
    end
  end

  describe "create slot" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, slot_path(conn, :create), slot: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == slot_path(conn, :show, id)

      conn = get conn, slot_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Slot"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, slot_path(conn, :create), slot: @invalid_attrs
      assert html_response(conn, 200) =~ "New Slot"
    end
  end

  describe "edit slot" do
    setup [:create_slot]

    test "renders form for editing chosen slot", %{conn: conn, slot: slot} do
      conn = get conn, slot_path(conn, :edit, slot)
      assert html_response(conn, 200) =~ "Edit Slot"
    end
  end

  describe "update slot" do
    setup [:create_slot]

    test "redirects when data is valid", %{conn: conn, slot: slot} do
      conn = put conn, slot_path(conn, :update, slot), slot: @update_attrs
      assert redirected_to(conn) == slot_path(conn, :show, slot)

      conn = get conn, slot_path(conn, :show, slot)
      assert html_response(conn, 200) =~ "some updated date"
    end

    test "renders errors when data is invalid", %{conn: conn, slot: slot} do
      conn = put conn, slot_path(conn, :update, slot), slot: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Slot"
    end
  end

  describe "delete slot" do
    setup [:create_slot]

    test "deletes chosen slot", %{conn: conn, slot: slot} do
      conn = delete conn, slot_path(conn, :delete, slot)
      assert redirected_to(conn) == slot_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, slot_path(conn, :show, slot)
      end
    end
  end

  defp create_slot(_) do
    slot = fixture(:slot)
    {:ok, slot: slot}
  end
end
