defmodule GofishWeb.PageControllerTest do
  use GofishWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Go Fish!"
  end
end
