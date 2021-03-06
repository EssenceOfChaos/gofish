defmodule GofishWeb.SessionController do
  use GofishWeb, :controller
  alias Gofish.Accounts.Auth
  alias Gofish.Repo

  action_fallback GofishWeb.FallbackController


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Auth.login(session_params, Repo) do
      {:ok, player} ->
        conn
        # |> put_session(:current_player, player.id)
        |> assign(:current_player, player)
        |> put_session(:player_id, player.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
        |> configure_session(renew: true)
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:player_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end



end
