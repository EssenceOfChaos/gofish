defmodule Gofish.Plugs.CurrentPlayer do
  import Plug.Conn
  alias Gofish.Accounts.Player

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
		player_id = get_session(conn, :player_id)

		cond do
		player = player_id && repo.get(Player, player_id) ->
			assign(conn, :current_player, player)
			# conn.assigns.player => player struct
			true ->
				assign(conn, :current_player, nil)
		end
  end
end
