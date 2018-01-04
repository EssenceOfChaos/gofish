defmodule GofishWeb.LobbyChannel do
  use GofishWeb, :channel
  alias GofishWeb.Presence
  alias Gofish.GamePlay
  alias Gofish.GamePlay.GameServer


  def join("lobby:lobby", _params, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.current_player.id, %{
      username: socket.assigns.current_player.username,
      online_at: :os.system_time(:seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end



  def handle_in("new_game", _params, socket) do
    game = GamePlay.create_game
    game_id = game.id
    GameServer.start_game(game_id)
    {:reply, {:ok, %{game_id: game_id}}, socket}
  end



  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (lobby:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end



## phoenix channels guide example
  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{
      player: socket.assigns.current_player.username,
      body: body,
      timestamp: :os.system_time(:milli_seconds)
    }
    {:noreply, socket}
  end

  # def handle_in("new_game", _params, socket) do
  #   {:reply, {:ok, %{game_id: game_id}}, socket}
  # end

  def handle_in("game_invite", %{"username" => username}, socket) do
    data = %{"username" => username, "sender" => socket.assigns.current_player.username }
    broadcast! socket, "game_invite", data
    {:noreply, socket}
  end

  intercept ["game_invite"]
def handle_out("game_invite", %{"username" => username, "sender" => sender}, socket) do
  if socket.assigns.current_player.username == username do
    push socket, "game_invite", %{ username: sender}
  end
  {:noreply, socket}
end



    # Add authorization logic here as required.
    # defp authorized?(_payload) do
    #   true
    # end

end
