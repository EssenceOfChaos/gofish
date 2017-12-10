defmodule Gofish.DealHandTest do
  use ExUnit.Case

  test "deals initial hand" do
    deck = Gofish.DealHand.create_deck
    assert length(deck) == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Gofish.DealHand.create_deck
    refute deck == Gofish.DealHand.shuffle(deck)
  end


end
