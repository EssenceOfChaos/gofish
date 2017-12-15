defmodule GofishWeb.PlayerSocket do
  use Phoenix.Socket
  alias Gofish.Accounts.Player

  ## Channels
  # channel "room:*", GofishWeb.RoomChannel
  channel "lobby:lobby", GofishWeb.LobbyChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 45_000
  # transport :longpoll, Phoenix.Transports.LongPoll

  
  @max_age 2 * 7 * 24 * 60 * 60

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "player socket", token, max_age: @max_age) do
      {:ok, player_id} ->
        player = Gofish.Repo.get!(Player, player_id)
        {:ok, assign(socket, :current_player, player)}
      {:error, _reason} ->
        :error
    end
end

def connect(_params, _socket), do: :error

def id(socket), do: "players_socket:#{socket.assigns.current_player.id}"
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     GofishWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
end
