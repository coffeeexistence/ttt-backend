class GameController < ApplicationController

  skip_before_filter :verify_authenticity_token


  allow_headers = 'Origin, Authorization, Accept, Content-Type, X-HTTP-Method-Override'


  def create
    game_session = GameSession.create
    render json: game_session
  end

  def show
    game_session = GameSession.find(params[:id])
    render json: game_session
  end

  def update
    game_session = GameSession.find(params[:id])
    game_session.board_state = game_session_params[:board_state]
    render json: game_session
  end

  def ai_move
    game_session = GameSession.find(params[:id])
    board = Board.new(game_session)
    hal = AI.new(board)
    ai_move = hal.move
    board.update_by_token(ai_move, game_session.ai_token)
    render json: {game_session: game_session, ai_move: ai_move}
  end

  def game_session_params
      params.require(:game_session).permit(:p1_token, :ai_difficulty, :board_state)
  end

end
