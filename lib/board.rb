module TicTacToe
	class Board

		INITIAL_CELL_TOKEN = nil

		attr_reader :width, :total_cells, :occupied_cells, :cells,
			    :empty_cells, :available_cells, :board


		def initialize(width)
			@width = width
			@cells = @available_cells =
				width.times.to_a.product(width.times.to_a)
			@empty_cells = @cells.length
			@occupied_cells = 0
			@total_cells = @empty_cells + @occupied_cells
			@board = Array.new(width) {
				         Array.new(width) { INITIAL_CELL_TOKEN }
			}
		end

		def new?
			@total_cells == @empty_cells
		end

		def print
			count = 1
			output = "  1    2    3 \n"
			board.flatten.each_with_index do |cell, index|
				output << ' ' + cell.to_s + ' '
				case index % 3
				when 0, 1 then output << ' | '
				when 2
					output << " #{count}" +
					("\n---------------\n" unless index == 8).to_s
					count += 1
				end
			end
			puts output
		end

		def token_at(cell)
			board[cell.first][cell.last]
		end

		def mark_token(cell, token)
			board[cell.first][cell.last] = token
			@occupied_cells += 1
			@empty_cells -= 1
			@available_cells.delete(cell)
			self
		end

		def blank?(cell)
			true if board[cell.first][cell.last]
		end

		private

		def initialize_copy(source)
			available_cells = @available_cells.map(&:dup)
			board = @board.map(&:dup)
			super
			@available_cells = available_cells
			@board = board
		end
	end

end