defmodule Gofish.GameTest do
  use ExUnit.Case
  alias Gofish.Game

  test "starting the Game module creates a linked process" do
    {:ok, pid} = Game.start(1)
  end

end
