defmodule Gofish.DeckTest do
  use ExUnit.Case

  test "deals initial hand" do
    deck = Gofish.Deck.create
    assert length(deck) == 52
  end

  test "shuffling a deck randomizes it" do
    deck1 = Gofish.Deck.create
    deck2 = Gofish.Deck.create
    refute deck1 == deck2
  end


end
