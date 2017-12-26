defmodule GofishWeb.LobbyChannelTest do
  use GofishWeb.ChannelCase

  alias GofishWeb.LobbyChannel
  alias Gofish.Accounts.Player
  alias Gofish.Repo

  setup do
    player = Repo.insert!(%Player{username: "tester", email: "tester@aol.com",
    rank: 24, password_hash: "abc123"})

    {:ok, _, socket} = socket("", %{current_player: player})
    |> subscribe_and_join(LobbyChannel, "lobby:lobby")
    {:ok, socket: socket}
  end


  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to lobby:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
