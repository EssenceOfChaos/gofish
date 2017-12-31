defmodule Gofish.GamePlay.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gofish.GamePlay.Game
  alias Gofish.Deck

  use GenServer

  schema "games" do
    field :winner, :string, default: nil
    field :player_1, :id, default: nil
    field :player_2, :id, default: nil
   

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:winner])
    |> validate_required([:winner])
  end


 @doc """
 Starts the CLIENT state.
 """
 
   def start(id) do
    GenServer.start_link(__MODULE__, id, name: ref(id))
   end
 # Generates global reference
  defp ref(id), do: {:global, {:game, id}}

  defp try_call(id, message) do
    case GenServer.whereis(ref(id)) do
      nil ->
        {:error, "Game does not exist"}
      pid ->
        GenServer.call(pid, message)
    end
  end

  @doc """
   SERVER .
 """
 def init(id) do
  {:ok, %__MODULE__{id: id}}
 end



def play(pid, index, player_id) do
  GenServer.call(pid, {:play, index, player_id})
end

def handle_call({:play, index, player_id}, _from, state) do
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
