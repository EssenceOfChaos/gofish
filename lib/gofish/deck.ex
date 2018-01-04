defmodule Gofish.Deck do

      @moduledoc """
  Provides a Deck context to hold the Card struct. The Deck module performs common operations
  such as creating a new deck and shuffling the cards.

  ## Examples

      iex> Gofish.Deck.create
      [%Gofish.Deck.Card{suit: "Spades", value: "Ten"},
      %Gofish.Deck.Card{suit: "Diamonds", value: "Six"},
      %Gofish.Deck.Card{suit: "Clubs", value: "Queen"},

  """

  defmodule Card do
    defstruct [:value, :suit]
  end


  @doc """
  create: Creates and returns a new shuffled deck
  """

  def create do
    values = [
    "Ace", "Two", "Three",
    "Four", "Five", "Six",
    "Seven", "Eight", "Nine", "Ten",
    "Jack", "Queen", "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
      for value <- values, suit <- suits do
        %Card{value: value, suit: suit}
      end |> Enum.shuffle
    end

end
