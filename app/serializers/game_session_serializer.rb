class GameSessionSerializer < ActiveModel::Serializer
  attributes :id, :board_state, :p1_token, :ai_token, :ai_difficulty, :game_data
end
