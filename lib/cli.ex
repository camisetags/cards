defmodule Cards.CLI do
	@moduledoc """
  Provides the main function for CLI
	"""
	
	@doc """
	Main function
	"""
	def main(_args) do
		{hand, deck} = Cards.create_hand(5)
		Cards.Game.game(hand)
	end
end
