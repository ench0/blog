defmodule Blog.Web.PageControllerTest do
  use Blog.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Blog"
  end
end
