defmodule GofishWeb.PageController do
  use GofishWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
