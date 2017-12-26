defmodule GofishWeb.PlayerSocket do
  use Phoenix.Socket
  alias Gofish.Accounts.Player
  alias Gofish.Repo

  ## Channel Routes
  channel "lobby:lobby", GofishWeb.LobbyChannel
  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 45_000
  # transport :longpoll, Phoenix.Transports.LongPoll


@max_age 2 * 7 * 24 * 60 * 60

# def connect(_params, socket) do
#   {:ok, socket}
# end

  def connect(%{"token" => token}, socket) do
      case Phoenix.Token.verify(socket, "player auth", token, max_age: @max_age) do
        {:ok, player_id} ->
          player = Repo.get!(Player, player_id)
          {:ok, assign(socket, :current_player, player)}
          {:error, _reason} ->
           :error
      end
  end

  def connect(_params, _socket), do: :error

  def id(_socket), do: nil
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
      # def id(socket), do: "player_socket:#{socket.assigns.player_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     GofishWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
end
