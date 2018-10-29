defmodule GameTest do
  use ExUnit.Case
  doctest Cards.Game

  test "get_winner_card" do
    {hand, _} = Cards.create_hand(5)
    winner_card = Cards.Game.get_winner_card(hand)
    
    assert hand |> Enum.member?(winner_card) == true
  end
end
