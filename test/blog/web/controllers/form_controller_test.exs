defmodule Blog.Web.FormControllerTest do
  use Blog.Web.ConnCase

  alias Blog.Comp

  @create_attrs %{active: true, info: "some info", title: "some title"}
  @update_attrs %{active: false, info: "some updated info", title: "some updated title"}
  @invalid_attrs %{active: nil, info: nil, title: nil}

  def fixture(:form) do
    {:ok, form} = Comp.create_form(@create_attrs)
    form
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, form_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Forms"
  end

  test "renders form for new forms", %{conn: conn} do
    conn = get conn, form_path(conn, :new)
    assert html_response(conn, 200) =~ "New Form"
  end

  test "creates form and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, form_path(conn, :create), form: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == form_path(conn, :show, id)

    conn = get conn, form_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Form"
  end

  test "does not create form and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, form_path(conn, :create), form: @invalid_attrs
    assert html_response(conn, 200) =~ "New Form"
  end

  test "renders form for editing chosen form", %{conn: conn} do
    form = fixture(:form)
    conn = get conn, form_path(conn, :edit, form)
    assert html_response(conn, 200) =~ "Edit Form"
  end

  test "updates chosen form and redirects when data is valid", %{conn: conn} do
    form = fixture(:form)
    conn = put conn, form_path(conn, :update, form), form: @update_attrs
    assert redirected_to(conn) == form_path(conn, :show, form)

    conn = get conn, form_path(conn, :show, form)
    assert html_response(conn, 200) =~ "some updated info"
  end

  test "does not update chosen form and renders errors when data is invalid", %{conn: conn} do
    form = fixture(:form)
    conn = put conn, form_path(conn, :update, form), form: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Form"
  end

  test "deletes chosen form", %{conn: conn} do
    form = fixture(:form)
    conn = delete conn, form_path(conn, :delete, form)
    assert redirected_to(conn) == form_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, form_path(conn, :show, form)
    end
  end
end
