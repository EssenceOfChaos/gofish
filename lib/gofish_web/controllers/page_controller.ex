defmodule GofishWeb.PageController do
  use GofishWeb, :controller

  def index(conn, _params) do 
    render conn, "index.html"
  end

  def rules(conn, _params) do
    conn
    |> render "rules.html"
  end

  def info(conn, _params) do
    render conn, "info.html"
  end

end
