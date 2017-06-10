defmodule Blog.Web.FileControllerTest do
  use Blog.Web.ConnCase

  alias Blog.Comp

  @create_attrs %{file: "some file", name: "some name"}
  @update_attrs %{file: "some updated file", name: "some updated name"}
  @invalid_attrs %{file: nil, name: nil}

  def fixture(:file) do
    {:ok, file} = Comp.create_file(@create_attrs)
    file
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, file_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Files"
  end

  test "renders form for new files", %{conn: conn} do
    conn = get conn, file_path(conn, :new)
    assert html_response(conn, 200) =~ "New File"
  end

  test "creates file and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, file_path(conn, :create), file: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == file_path(conn, :show, id)

    conn = get conn, file_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show File"
  end

  test "does not create file and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, file_path(conn, :create), file: @invalid_attrs
    assert html_response(conn, 200) =~ "New File"
  end

  test "renders form for editing chosen file", %{conn: conn} do
    file = fixture(:file)
    conn = get conn, file_path(conn, :edit, file)
    assert html_response(conn, 200) =~ "Edit File"
  end

  test "updates chosen file and redirects when data is valid", %{conn: conn} do
    file = fixture(:file)
    conn = put conn, file_path(conn, :update, file), file: @update_attrs
    assert redirected_to(conn) == file_path(conn, :show, file)

    conn = get conn, file_path(conn, :show, file)
    assert html_response(conn, 200) =~ "some updated file"
  end

  test "does not update chosen file and renders errors when data is invalid", %{conn: conn} do
    file = fixture(:file)
    conn = put conn, file_path(conn, :update, file), file: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit File"
  end

  test "deletes chosen file", %{conn: conn} do
    file = fixture(:file)
    conn = delete conn, file_path(conn, :delete, file)
    assert redirected_to(conn) == file_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, file_path(conn, :show, file)
    end
  end
end
