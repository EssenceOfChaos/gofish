defmodule GofishWeb.LobbyChannel do
  use GofishWeb, :channel
  alias GofishWeb.Presence
  alias Gofish.Repo


  def join("lobby:lobby", _message, socket) do
    {:ok, socket}
  end


  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.player_id, %{
      online_at: inspect(System.system_time(:seconds))
    })
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


  # def handle_in("new_msg", %{"body" => body}, socket) do
  #   broadcast! socket, "new_msg", %{body: body}
  #   {:noreply, socket}
  # end

  def handle_in("new_msg", %{"body" => body}, socket) do
    player = Repo.get(Player, socket.assigns.current_player)
    broadcast! socket, "new_msg", %{body: body, player: player.username}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end