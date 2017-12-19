defmodule GofishWeb.LobbyChannel do
  use GofishWeb, :channel
  alias GofishWeb.Presence
  alias Gofish.Repo
  alias Gofish.Plugs.ChannelMonitor


  def join("lobby:lobby", _payload, socket) do
      current_player = socket.assigns.current_player
      players = ChannelMonitor.player_joined("lobby:lobby", current_player)["lobby:lobby"]
      send self, {:after_join, players}
      {:ok, socket}
    end

    def terminate(_reason, socket) do
      player_id = socket.assigns.current_player.id
      players = ChannelMonitor.player_left("lobby:lobby", player_id)["lobby:lobby"]
      lobby_update(socket, players)
      :ok
    end

    def handle_info({:after_join, players}, socket) do
      lobby_update(socket, players)
      {:noreply, socket}
    end

    defp lobby_update(socket, players) do
      broadcast! socket, "lobby_update", %{ players: get_playernames(players) }
    end

    defp get_playernames(nil), do: []
    defp get_playernames(players) do
      Enum.map players, &(&1.playername)
    end

# invite for game //
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

## phoenix channels guides
  # def handle_in("new_msg", %{"body" => body}, socket) do
  #   broadcast! socket, "new_msg", %{body: body}
  #   {:noreply, socket}
  # end
end
