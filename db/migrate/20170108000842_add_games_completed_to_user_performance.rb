class AddGamesCompletedToUserPerformance < ActiveRecord::Migration[5.0]
  def change
    add_column :user_performances, :games_completed, :integer, default: 0
  end
end
