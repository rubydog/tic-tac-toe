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
			output = ''
			width.times do |number|
				output +=  '   ' + (number + 1).to_s + '  '
			end
			output += "\n"
			@board.each_with_index do |row, row_index|
				output += (row_index + 1).to_s + ' '
				row.each_with_index do |cell, cell_index|
					output += ' ' + (cell || ' ') + ' '
					if cell_index % width == 0 ||
					   cell_index % width == 1
						output += ' | '
					end
				end
				if row_index != width-1
					output += "\n  ----------------\n"
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
