defmodule Blog.Web.ImageControllerTest do
  use Blog.Web.ConnCase

  alias Blog.Comp

  @create_attrs %{image: "some image", name: "some name"}
  @update_attrs %{image: "some updated image", name: "some updated name"}
  @invalid_attrs %{image: nil, name: nil}

  def fixture(:image) do
    {:ok, image} = Comp.create_image(@create_attrs)
    image
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, image_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Images"
  end

  test "renders form for new images", %{conn: conn} do
    conn = get conn, image_path(conn, :new)
    assert html_response(conn, 200) =~ "New Image"
  end

  test "creates image and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, image_path(conn, :create), image: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == image_path(conn, :show, id)

    conn = get conn, image_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Image"
  end

  test "does not create image and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, image_path(conn, :create), image: @invalid_attrs
    assert html_response(conn, 200) =~ "New Image"
  end

  test "renders form for editing chosen image", %{conn: conn} do
    image = fixture(:image)
    conn = get conn, image_path(conn, :edit, image)
    assert html_response(conn, 200) =~ "Edit Image"
  end

  test "updates chosen image and redirects when data is valid", %{conn: conn} do
    image = fixture(:image)
    conn = put conn, image_path(conn, :update, image), image: @update_attrs
    assert redirected_to(conn) == image_path(conn, :show, image)

    conn = get conn, image_path(conn, :show, image)
    assert html_response(conn, 200) =~ "some updated image"
  end

  test "does not update chosen image and renders errors when data is invalid", %{conn: conn} do
    image = fixture(:image)
    conn = put conn, image_path(conn, :update, image), image: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Image"
  end

  test "deletes chosen image", %{conn: conn} do
    image = fixture(:image)
    conn = delete conn, image_path(conn, :delete, image)
    assert redirected_to(conn) == image_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, image_path(conn, :show, image)
    end
  end
end
