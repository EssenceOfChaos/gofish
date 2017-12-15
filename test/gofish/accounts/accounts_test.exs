defmodule Gofish.AccountsTest do
  use Gofish.DataCase

  alias Gofish.Accounts

  describe "players" do
    alias Gofish.Accounts.Player

    @valid_attrs %{email: "batman@example.com", password_hash: "ASDLKFJAOIEAO394873948", rank: 42, username: "cooldude17"}
    @update_attrs %{email: "batman2@example.com", password_hash: "7dkj3gJAOIEAO394873948", rank: 43, username: "cooldude18"}
    @invalid_attrs %{email: nil, password_hash: nil, rank: nil, username: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Accounts.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Accounts.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Accounts.create_player(@valid_attrs)
      assert player.email == "batman@example.com"
      assert player.username == "cooldude17"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Accounts.update_player(player, @update_attrs)
      assert %Player{} = player
      assert player.email == "batman2@example.com"
      assert player.username == "cooldude18"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_player(player, @invalid_attrs)
      assert player == Accounts.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Accounts.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Accounts.change_player(player)
    end
  end
end
