class Board

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
  ]

  attr_accessor :cells, :game_session

	def initialize(game_session)
		self.game_session = game_session
    self.set_cells
	end

  def set_cells
    self.cells = game_session.board_state.split('')
  end

	def position(user_input_string)
		cells[user_input_string.chomp.to_i - 1] # user is entering 1-9.  posiitons are 0-8
	end

	def full?
		cells.all? {|cell| cell.strip != ""}
	end

	def turn_count
		cells.count {|cell| !cell.strip.empty?}
	end

	def taken?(input)
		!cells[input.to_i - 1].strip.empty?
	end

	def valid_move?(input)
		!taken?(input) && (1..9).include?(input.to_i)
	end

  def update(position, player)
    @cells[position.to_i-1]=player.token
  end

  def possible_moves
    moves_arr=[]
    @cells.each_with_index{|space, index| moves_arr << (index+1).to_s if space==" "}
    moves_arr
  end

  def current_player
    (turn_count % 2 == 0) ? @player_1 : @player_2
  end

  def over?
    (draw? || won?)
  end

  def won?
    win_combinations = WIN_COMBINATIONS
    winner = win_combinations.detect do |combos|
      @cells[combos[0]]==cells[combos[1]] && cells[combos[1]]==cells[combos[2]] && cells[combos[1]]!=" "
    end
    winner
  end

  def draw?
    (full? && !won?)
  end

  def winner
    return nil unless won?
    @cells[won?[0]]
  end

  def update_by_token(position, token)
    @cells[position.to_i-1]=token
    #puts "Updated @cells to =     #{@cells}"
  end

end
