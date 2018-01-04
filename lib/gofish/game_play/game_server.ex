defmodule Gofish.GamePlay.GameServer do
  use GenServer
  alias Gofish.GamePlay.Game

    @moduledoc """
  This module contains the game logic and maintains the game state
  """


  def start(game_id) do
    GenServer.start_link(__MODULE__, :ok, name: via_tuple(game_id))
  end

  defp via_tuple(game_id), do: {:via, Registry, {Registry.Game, game_id}}

  def init do

  end
#


  # Client

  def push(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %Game{
      status: "initializing",
      }}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_call(request, from, state) do
    # Call the default implementation from GenServer
    super(request, from, state)
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  def handle_cast(request, state) do
    super(request, state)
  end





end
