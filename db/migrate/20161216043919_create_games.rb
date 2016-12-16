class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :player_one_id
      t.integer :player_two_id
      t.integer :winner_id
      t.integer :player_one_score
      t.integer :player_two_score
      t.integer :current_player_id

      t.timestamps
    end
  end
end
