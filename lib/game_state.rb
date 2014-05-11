module TicTacToe
	class GameState
		attr_reader :board, :computer_token, :human_token, :winner

		def initialize(computer_token, human_token)
			@computer_token, @human_token =
				computer_token, human_token
			@impossible_lines = []
		end

		def board=(board)
			@board = board
			@board_width ||= board.width
			@max_index ||= @board_width - 1
			@minimum_moves_required_to_win ||= (2 * @board_width)-1
			check_for_win
		end

		def make_move(cell)
			new_state = self.dup
			new_state.computer_token = human_token
			new_state.human_token = computer_token
			new_state.impossible_lines = @impossible_lines.dup
			new_state.board = board.dup.mark_token(cell,
							       computer_token)
			new_state
		end

		def available_moves
			@board.available_cells
		end

		def corner_cells
			[0, @max_index].product([0, @max_index])
		end

		def unplayed?
			@board.new?
		end

		def final_move
			@board.available_cells.first if @board.empty_cells == 1
		end

		def over?
			winner_exists? || draw?
		end

		def draw?
			@board.empty_cells == 0 && !@winner
		end

		def winner_exists?
			!!@winner
		end

		def lost?(token)
			@winner && @winner != token
		end

		def won?(token)
			token == @winner
		end

		protected

		attr_writer :computer_token, :human_token, :impossible_lines

		private

		def check_for_win
			@winner = winning_row || winning_column ||
				  winning_diagonal || winning_reverse_diagonal
		end

		def winning_row
			@board_width.times do |row_index|
				token = check_line([row_index, 0],
						   "row#{row_index}") {
					|index| [row_index, index]
				}
		 		return token if token
			end
			return nil
		end

		def winning_column
			@board_width.times do |column_index|
				token = check_line([0, column_index],
						   "column#{column_index}") {
					|index| [index, column_index]
				}
				return token if token
			end
			return nil
		end

		def winning_diagonal
			check_line([0, 0], "diag") { |index| [index, index] }
		end

		def winning_reverse_diagonal
			check_line([0, @max_index], "rev_diag") do |index|
				[index, @max_index - index]
			end
		end

		def check_line(cell, line_id)
			return if @impossible_lines.include? line_id
			token = @board.token_at(cell)
			return if !token
			(1..@max_index).each do |index|
				test_cell = yield index
				test_token = @board.token_at(test_cell)
				if test_token != token
					@impossible_lines << line_id if test_token
					return
				end
			end
			token
		end
	end
end
