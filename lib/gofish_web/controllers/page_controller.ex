defmodule GofishWeb.PageController do
  use GofishWeb, :controller

  def index(conn, _params) do
    # ExDebugToolbar.pry()
    # |> put_flash(:info, "Testing flash")
    # |> render "index.html"
    render conn, "index.html"
  end

  def rules(conn, _params) do
    render conn, "rules.html"
  end

  def info(conn, _params) do
    render conn, "info.html"
  end
  
end
