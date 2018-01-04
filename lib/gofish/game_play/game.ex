defmodule Gofish.GamePlay.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gofish.GamePlay.{Game}
  alias Gofish.GamePlay



  schema "games" do
    field :winner, :integer
    field :player_1, :id, default: nil
    field :player_2, :id, default: nil
    field :status, :string

    ## VIRTUAL FIELDS ##
    field :player_1_hand, :map, virtual: :true
    field :player_2_hand, :map, virtual: true

    timestamps()
  end


  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:player_1, :player_2, :winner])
  end

  def create do
    Gofish.GamePlay.new_game()
  end

  def show(id) do
    Gofish.GamePlay.get_game!(id)
  end

  def add_player_1(id, player) do
    game = GamePlay.get_game!(id)
    Gofish.GamePlay.update_game(game, %{player_1: player})
  end

  def add_player_2(id, player) do
    game = GamePlay.get_game!(id)
    Gofish.GamePlay.update_game(game, %{player_2: player})
  end




end
