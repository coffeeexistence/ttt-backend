class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.text :board_state, default: "         "
      t.string :p1_token, default: 'X'
      t.string :ai_token, default: 'O'
      t.integer :ai_difficulty, default: '3'

      t.timestamps null: false
    end
  end
end
