require '../lib/board.rb'
require 'test/unit'

module TicTacToe

	class TestBoard < Test::Unit::TestCase
		def setup
			@board = TicTacToe::Board.new(3)
		end

		def test_initialize_with_right_width
			assert_equal 3, @board.width
		end

		def test_total_cells
			assert_equal 9, @board.total_cells
			assert_equal 9, @board.empty_cells
			assert_equal 0, @board.occupied_cells
			cells = [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1],
				[1, 2], [2, 0], [2, 1], [2, 2]]
			assert_equal cells, @board.cells
		end

		def test_mark_token
			@board.mark_token([1,2], 'X')
			assert_equal 'X', @board.token_at([1,2])
			assert_equal @board.available_cells, [[0, 0], [0, 1],
				[0, 2], [1, 0], [1, 1], [2, 0], [2, 1], [2, 2]]
			assert_equal 8, @board.empty_cells
			assert_equal 1, @board.occupied_cells
		end

		def test_makes_deep_copy_of_board
			@board.mark_token([0, 0], 'X')
			board2 = @board.clone
			@board.mark_token([0, 1], 'X')
			board2.mark_token([0, 2], 'X')
			assert_nil board2.token_at([0, 1])
			assert_nil @board.token_at([0, 2])
			assert_not_equal @board.available_cells,
					 board2.available_cells
		end
	end
end
