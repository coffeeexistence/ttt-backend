class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.text :board_state, default: "         "
      t.string :p1_token
      t.string :ai_token
      t.integer :ai_difficulty

      t.timestamps null: false
    end
  end
end
