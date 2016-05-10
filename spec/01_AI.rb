require 'spec_helper'
require 'rails_helper'

describe 'AI' do


  it 'selects the optimal move for a blank board' do
    session = GameSession.create
    session.ai_difficulty = 5
    board = Board.new(session)
    hal = AI.new(board)
    #byebug
    expect(hal.move).to eq("5")
  end

  it 'selects the optimal move if the player selects the middle position' do
    session = GameSession.create
    session.ai_difficulty = 5
    board = Board.new(session)
    board.update_by_token(5, 'X')
    board.persist
    hal = AI.new(board)
    #byebug
    expect(hal.move).to eq("1")
  end

end
