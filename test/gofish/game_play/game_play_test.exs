defmodule Gofish.GamePlayTest do
  use Gofish.DataCase

  alias Gofish.GamePlay

  describe "games" do
    alias Gofish.GamePlay.Game

    @valid_attrs %{winner: "some winner"}
    @update_attrs %{winner: "some updated winner"}
    @invalid_attrs %{winner: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GamePlay.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert GamePlay.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert GamePlay.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = GamePlay.create_game(@valid_attrs)
      assert game.winner == "some winner"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GamePlay.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = GamePlay.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.winner == "some updated winner"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = GamePlay.update_game(game, @invalid_attrs)
      assert game == GamePlay.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = GamePlay.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> GamePlay.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = GamePlay.change_game(game)
    end
  end
end
