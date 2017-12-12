defmodule GofishWeb.PageController do
  use GofishWeb, :controller

  def index(conn, _params) do
    # ExDebugToolbar.pry()
    render conn, "index.html"
  end
end
