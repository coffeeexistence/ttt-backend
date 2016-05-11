class GameSession < ActiveRecord::Base

  def game_data
    board = Board.new(self)
    return {winner: board.winner, draw: board.draw?}
  end

end
