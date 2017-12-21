defmodule Gofish.Accounts.Auth do
  alias Gofish.Accounts.{Player, Encryption}

  def login(params, repo) do
    player = repo.get_by(Player, email: String.downcase(params["email"]))
    case authenticate(player, params["password"]) do
      true -> {:ok, player}
      _    -> :error
    end
  end

  defp authenticate(player, password) do
    case player do
      nil -> false
      _   -> Encryption.validate_password(password, player.password_hash)
    end
  end


  ## Helper functions for view
  def current_player(conn) do
  id = Plug.Conn.get_session(conn, :current_player)
  if id, do: Gofish.Repo.get(Player, id)
  end
  def logged_in?(conn), do: !!current_player(conn)
  
end
