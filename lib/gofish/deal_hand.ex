defmodule Gofish.DealHand do

  def create_deck do
    values = [
    "Ace", "Two", "Three",
    "Four", "Five", "Six",
    "Seven", "Eight", "Nine", "Ten",
    "Jack", "Queen", "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
      for suit <- suits, value <- values do
      ["#{value}, #{suit}"]
      end
  end

    def shuffle(deck) do
      Enum.shuffle(deck)
    end
end
