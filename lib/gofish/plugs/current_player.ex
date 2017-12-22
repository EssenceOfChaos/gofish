defmodule Gofish.Plugs.CurrentPlayer do
  import Plug.Conn
  alias Gofish.Accounts.Player

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end


  def call(conn, repo) do
		player_id = get_session(conn, :player_id)
		if player = player_id && repo.get(Gofish.Accounts.Player, player_id) do
			put_current_player(conn, player)
		else
			assign(conn, :current_player, nil)
		end
  end

	defp put_current_player(conn, player) do
    token = Phoenix.Token.sign(conn, "player auth", player.id)
		conn
		|> assign(:current_player, player)
		|> assign(:player_token, token)
	end

end
