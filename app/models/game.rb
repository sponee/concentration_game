class Game < ApplicationRecord
  validates :user_id, presence: true
  validates :player_one_id, presence: true
  validates :player_two_id, presence: true
  validate :validate_player_uniqueness

  private

  def validate_player_uniqueness
    errors.add("Games must have different Players") if player_one_id == player_two_id
  end
end
