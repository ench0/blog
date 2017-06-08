defmodule Blog.Web.PageControllerTest do
  use Blog.Web.ConnCase

  alias Blog.Base

  @create_attrs %{active: true, body: "some body", menu: true, slug: "some slug", title: "some title"}
  @update_attrs %{active: false, body: "some updated body", menu: false, slug: "some updated slug", title: "some updated title"}
  @invalid_attrs %{active: nil, body: nil, menu: nil, slug: nil, title: nil}

  def fixture(:page) do
    {:ok, page} = Base.create_page(@create_attrs)
    page
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Pages"
  end

  test "renders form for new pages", %{conn: conn} do
    conn = get conn, page_path(conn, :new)
    assert html_response(conn, 200) =~ "New Page"
  end

  test "creates page and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, page_path(conn, :create), page: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == page_path(conn, :show, id)

    conn = get conn, page_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Page"
  end

  test "does not create page and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, page_path(conn, :create), page: @invalid_attrs
    assert html_response(conn, 200) =~ "New Page"
  end

  test "renders form for editing chosen page", %{conn: conn} do
    page = fixture(:page)
    conn = get conn, page_path(conn, :edit, page)
    assert html_response(conn, 200) =~ "Edit Page"
  end

  test "updates chosen page and redirects when data is valid", %{conn: conn} do
    page = fixture(:page)
    conn = put conn, page_path(conn, :update, page), page: @update_attrs
    assert redirected_to(conn) == page_path(conn, :show, page)

    conn = get conn, page_path(conn, :show, page)
    assert html_response(conn, 200) =~ "some updated body"
  end

  test "does not update chosen page and renders errors when data is invalid", %{conn: conn} do
    page = fixture(:page)
    conn = put conn, page_path(conn, :update, page), page: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Page"
  end

  test "deletes chosen page", %{conn: conn} do
    page = fixture(:page)
    conn = delete conn, page_path(conn, :delete, page)
    assert redirected_to(conn) == page_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, page_path(conn, :show, page)
    end
  end
end
