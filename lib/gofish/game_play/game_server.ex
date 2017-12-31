defmodule Gofish.GamePlay.GameServer do
  use GenServer
  alias Gofish.GamePlay.Game
    @moduledoc """
  This module contains the game logic and maintains the game state
  """

  def start(id) do
    GenServer.start_link(__MODULE__, id, name: ref(id))
   end
# Generates global reference
  defp ref(id), do: {:global, {:game, id}}



  def join(pid, player_1) do
    GenServer.call(pid, {:join, player_1})
  end

  def play(pid, index, player_id) do
    GenServer.call(pid, {:play, index, player_id})
  end

  def init(_opts) do
    {:ok, %Game{}}
  end

  def handle_call({:join, player_1}, _from, state) do
    case Game.join_user(state, player_1) do
      %Game{} = state -> {:reply, {:ok, state}, state}
      other           -> {:reply, other, state}
    end
  end



  def start_game(game_id) do
    
  end


  
end