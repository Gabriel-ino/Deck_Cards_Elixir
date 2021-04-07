defmodule Cards do
  @moduledoc """
      Provides methods for creating and hadling a deck of cards.
  """

 @doc """
  Returns a list of strings representing a deck of playing cards
 """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
  cards = for suit <- suits, value <- values do
    "#{value} of #{suit}"
  end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Example

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contain?(deck, "Ace of Spades")
      true
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
  @doc """
    Divides a deck into a hand and the rest of the deck.
    The `hand_size` argument indicates how many cards shold
    be in player's hand.

  ## Example
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file doesn't exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
