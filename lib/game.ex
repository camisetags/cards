defmodule Cards.Game do
  @moduledoc """
  Provides functions to execute game actions
  """

  @doc """
  Method to execute funcions to the main game.

  Returns `:ok`.

  ## Examples
      iex(1)> {hand, _} = Cards.create_hand(5)
      iex(2)> hand
      [
        %{code: :ace_of_clubs, name: "Ace of Clubs"},
        %{code: :five_of_diamonds, name: "Five of Diamonds"},
        %{code: :four_of_diamonds, name: "Four of Diamonds"},
        %{code: :two_of_spades, name: "Two of Spades"},
        %{code: :three_of_spades, name: "Three of Spades"}
      ]
      iex(3)> Cards.Game.game(hand)
      Choose one card:
      1 - Ace of Clubs
      2 - Five of Diamonds
      3 - Four of Diamonds
      4 - Two of Spades
      5 - Three of Spades

      2
      Winner choice is: Ace of Clubs
      Your choice is: Five of Diamonds

      You lose...
  """
  def game(hand) do
    choice = hand
      |> formated_title
      |> IO.gets
      |> Integer.parse
      |> case do
        {choice,  _} -> choice - 1
        :error -> -1
      end

    decide_winner(choice, hand)
  end

  @doc """
  Decides the winner card based on user choice
  """
  def decide_winner(choice, hand) when choice >= 0 do
    winner_card = get_winner_card(hand)
    user_choice = case Enum.at(hand, choice) do
      %{name: name} -> name
      nil -> "Invalid choice"
    end

    result = if winner_card.name === user_choice do
      "You win!!"
    else
      "You lose..."
    end

    IO.puts """
      Winner choice is: #{winner_card.name}
      Your choice is: #{user_choice}
      
      #{result}
    """
  end

  def decide_winner(choice, hand) when choice < 0 do
    IO.puts "Choose a valid option"
    game(hand)
  end

  @doc """
  Generates the winner card
  """
  def get_winner_card(hand) do
    winner_index = Range.new(0, length(hand) - 1) |> Enum.random
    Enum.at(hand, winner_index)
  end

  @doc """
  Format the string containing hand cards
  """
  defp format_hand(hand) do
    hand
      |> Enum.with_index
      |> Enum.map(fn {card, i} -> "#{i+1} - #{card.name} \n" end)
      |> Enum.join
  end

  @doc """
  Format hand with title
  """
  defp formated_title(hand) do
    """
    Choose one card:
    #{format_hand(hand)}
    """
  end
end
