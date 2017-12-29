defmodule Gofish.Game do
  use GenServer
  alias Gofish.Deck
    @moduledoc """
    This module contains the game logic and maintains the game state
    """
defstruct [
  id: nil,
  player_1: nil,
  player_2: nil,
  winnner: nil
]
   @doc """
   Starts the state.
   """
   def start(id) do
    GenServer.start_link(__MODULE__, id, name: ref(id))
   end

   
  def put(pid, key, value) do
    Agent.update(pid, &Map.put(&1, key, value))
  end

  def get(pid, key) do
    Agent.get(pid, &Map.get(&1, key))
  end
  
  def update(pid, item) do
    Agent.update(pid, fn list -> [item|list] end) 
  end


  def deck do
    Agent.get(__MODULE__, &(&1))
  end

# Generates global reference
defp ref(id), do: {:global, {:game, id}}

# SERVER

def init(id) do
  {:ok, %__MODULE__{id: id}}
end

defp try_call(id, message) do
  case GenServer.whereis(ref(id)) do
    nil ->
      {:error, "Game does not exist"}
    pid ->
      GenServer.call(pid, message)
  end
end


### TODO rewrites below !@#$%
  @doc """
  Starts a door with the given `color`.

  The color is given as a name so we can identify
  the door by color name instead of using a PID.
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Get the data currently in the `door`.
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into the door.
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`.

  Returns `{:ok, value}` if there is a value
  or `:error` if the hole is currently empty.
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      []    -> {:error, []}
      [h|t] -> {{:ok, h}, t}
    end)
  end

   @doc """
   Put a new player in the map
   """
def put_player(player) do
  Agent.update(__MODULE__, &Map.put_new(&1, player.id, player))
end

   @doc """
     Retrieve a player from the map
   """
def get_player(player_id) do
  Agent.get(__MODULE__, &Map.get(&1, player_id))
end

   @doc """
  Update the player information in the map
   """
def update_player(player) do
  Agent.update(__MODULE__, &Map.put(&1, player.id, player))
  player
end




end