class UserPerformance < ApplicationRecord
  belongs_to :user

  before_save :calculate_win_loss_ratio

  def increment_wins
    self.wins += 1
    increment_games_completed
    save
  end

  def increment_losses
    self.losses += 1
    increment_games_completed
    save
  end

  def increment_games_completed
    self.games_completed += 1
  end

  def calculate_win_loss_ratio
    self.win_loss_ratio = losses.zero? ? wins.to_f : (wins/losses.to_f).round(2)
  end
end