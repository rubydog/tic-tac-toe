require 'test/unit'
require '../lib/game_state.rb'

module TicTacToe
	class TestGameState < Test::Unit::TestCase

		def setup
			@game_state = TicTacToe::GameState.new('X', 'O')
		end

		def test_initiates_with_token
			assert_equal 'X', @game_state.computer_token
			assert_equal 'O', @game_state.human_token
		end
	end
end
