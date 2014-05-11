module TicTacToe
	class AIPlayer

		Node = Struct.new(:score, :move)

		def take_turn(game_state)
			@game_state = game_state
			@token = @game_state.computer_token
			game_state.make_move(choose_move)
		end

		private
		attr_reader :token, :game_state

		def choose_move
			return game_state.corner_cells.sample if game_state.unplayed?
			return game_state.final_move if game_state.final_move
			best_possible_move
		end

		def best_possible_move
			@base_score = 10 # game_state.available_moves.count + 1
			bound = @base_score + 1
			minmax(game_state, 0, -bound, bound)
			@current_move_choice
		end

		def score(game_state, depth)
			if game_state.won?(token)
				return @base_score - depth
			elsif game_state.lost?(token)
				return depth - @base_score
			else
				0
			end
		end

		def minmax(game_state, depth, lower_bound, upper_bound)
			return score(game_state, depth) if game_state.over?
			possible_move_nodes = []
			game_state.available_moves.each do |move|
				child_board = game_state.make_move(move)
				score = minmax(child_board, depth + 1,
					       lower_bound, upper_bound)
				node = Node.new(score, move)

				if game_state.computer_token == token
					possible_move_nodes.push node
					lower_bound = node.score if node.score >
								    lower_bound
				else
					upper_bound = node.score if node.score <
								    upper_bound
				end
				break if lower_bound > upper_bound
			end

			return upper_bound if game_state.computer_token != token
			@current_move_choice = possible_move_nodes.max_by do |node|
				node.score
			end.move
			lower_bound
		end
	end
end
