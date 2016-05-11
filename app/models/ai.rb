class AI
  attr_accessor :difficulty, :main_board
  def initialize(main_board)
		@token = main_board.game_session.ai_token
    @difficulty = main_board.game_session.ai_difficulty
    self.main_board = main_board
	end

  def move
    move = optimal_move
    puts "CPU #{@token} selected position #{move}"
    move
	end

  def opponent_token
    @token=="X" ? "O" : "X"
  end

  def optimal_move
    cpu_board = HypotheticalBoard.new(self.main_board.cells)
    results = ai_starter(cpu_board, self.difficulty)
    puts results.to_s
    results
  end

  def ai_starter(cpu_board, depth)
    #  make array of (possible_moves.length) entries of (current board with token in potential move slot) called possible_moves_boards
    possible_moves=cpu_board.possible_moves
    possible_moves_board_array = generate_moves_array(cpu_board, @token)
    #  simulate execution of each possible move of current_player
    move_optimality_arr=[]
    #raise 'stop here'
    possible_moves_board_array.each{|board| move_optimality_arr << ai(board, depth, depth, false) }
    #puts move_optimality_arr.to_s

    best_option = index_of_max(move_optimality_arr)
    puts move_optimality_arr
    possible_moves[best_option]
  end

  def index_of_max(arr)
    value = arr.max
    arr.find_index(value)
  end

  def ai(cpu_board, depth, initial_depth, cpus_turn=true) #warning: recursion may occur :P -  https://youtu.be/Mv9NEXX1VHc
    optimality=50
    token=""
    cpus_turn ? token=@token : token=opponent_token
    #  return optimality for following values for potential cases:
    # puts "#{@token} - #{opponent_token}"
    if cpu_board.winner==@token
      if depth == initial_depth
        return 500
        puts "Immediate win"
      end
      return 100

    end

    return -50 if cpu_board.winner==opponent_token
    return 25 if cpu_board.draw?
    #return default value if a draw
    return optimality if depth<=0
    #  make array of possible moves
    moves_array = generate_moves_array(cpu_board, token)
    #puts "got here"
    #puts "#{moves_array.to_s} - possible_moves"
    #  simulate execution of each possible move of current_player
    sub_moves = moves_array.map{|board| ai(board, depth-1, initial_depth, !cpus_turn)}
    sub_moves_sum = array_sum(sub_moves)

    long_term_optimality = (sub_moves_sum)/sub_moves.length

    return long_term_optimality
  end

  def array_sum(array)
    sum=0
    array.each {|element| sum+=element}
    sum
  end

  def generate_moves_array(cpu_board, token)
    possible_moves=cpu_board.possible_moves
    #puts "possible moves: #{possible_moves.to_s}"
    board_cells=cpu_board.cells
    possible_moves_boards = []
    possible_moves.each do |move_position|
      new_board = HypotheticalBoard.new(board_cells.clone)
      #puts "Board_cells Var =     #{board_cells}"
      new_board.update_by_token(move_position, token)
      #puts "set position #{move_position} id=#{new_board}"
      possible_moves_boards << new_board
      #puts "Board Started/Updated to: #{new_board.cells}"
    end
    possible_moves_boards

  end


end
