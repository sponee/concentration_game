class Game < ApplicationRecord
  belongs_to :user
  has_many :cards
  after_create :generate_cards
  
  validates :user_id, presence: true
  validates :player_one_id, presence: true
  validates :player_two_id, presence: true
  validate :validate_player_uniqueness

  private

  def validate_player_uniqueness
    errors.add(:base, "Games must have different Players") if player_one_id == player_two_id
  end

  def generate_cards
    (Card::CARD_CONTENT*2).shuffle.each_with_index do |content, index|
      self.cards.create(content: content, position: index)
    end
  end
end
