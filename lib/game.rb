require_relative 'board.rb'
require_relative 'game_state.rb'
require_relative 'ai_player.rb'

module TicTacToe
	class Game

		BOARD_WIDTH = 3
		TOKENS = ['X', 'O']

		def initialize
			@board = TicTacToe::Board.new(BOARD_WIDTH)
			@computer_token = TOKENS.sample
			@human_token = @computer_token == 'X' ? 'O' : 'X'
			@game_state = TicTacToe::GameState.new(@computer_token,
							       @human_token)
			@game_state.board = @board
			@ai = TicTacToe::AIPlayer.new
			puts "My token: #{@computer_token}, Your token: #{@human_token}\n"
			play
		end

		def play
			@current_player = @computer_token
			@board.print
			loop do
				if @game_state.over?
					output = @game_state.draw? ? "Draw" :
						"Winner #{@game_state.winner}"
					puts output
					break
				end
				if @current_player == @human_token
					@current_player = @computer_token
					human_move
				else
					@current_player = @human_token
					computer_move
				end
				@board.print
			end
		end

		def human_move
			print "Your turn: "
			input = gets.strip.split('').map { |num| num.to_i - 1 }
			@game_state = @game_state.make_move(input)
		end

		def computer_move
			puts "My turn"
			@game_state = @ai.take_turn(@game_state)
			@board = @game_state.board
		end

		private
		attr_writer :board, :human, :computer

	end
end

TicTacToe::Game.new
