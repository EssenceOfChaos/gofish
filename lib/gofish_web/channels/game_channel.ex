defmodule GofishWeb.GameChannel do
  use GofishWeb, :channel
  @moduledoc """
  This module contains the Game Channel
  """

  def join("game:" <> game_id, _message, socket) do
    player_id = socket.assigns.player_id

    case Game.join(game_id, player_id, socket.channel_pid) do
      {:ok, _pid} ->
        {:ok, assign(socket, :game_id, game_id)}
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end



  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end


end
