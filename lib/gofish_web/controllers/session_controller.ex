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
        |> assign(:current_player, player)
        |> put_session(:player_id, player.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_player)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

  # defp put_current_player(conn, player) do
  #   token = Phoenix.Token.sign(conn, "player socket", player.id)
  #   conn
  #   |> assign(:current_player, player)
  #   |> put_session(:player_id, player.id)
  #   |> assign(:player_token, token)
  # end


end
