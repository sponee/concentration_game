class Game < ApplicationRecord
  belongs_to :user
  has_many :cards
  after_create :generate_cards
  
  validates :user_id, presence: true
  validates :player_one_id, presence: true
  validates :player_two_id, presence: true
  validate :validate_player_uniqueness

  scope :active, -> { where(winner_id: nil) }

  def update_current_player
    if self.current_player_id == player_one_id
      self.update_attributes(current_player_id: player_two_id)
    elsif self.current_player_id == player_two_id
      self.update_attributes(current_player_id: player_one_id)
    end
  end

  private

  def validate_player_uniqueness
    errors.add(:base, "Games must have different Players") if player_one_id == player_two_id
  end

  def generate_cards
    (Card::CARDS*2).shuffle.each_with_index do |card, index|
      self.cards.create(content: card.content, image_url: card.image_url, position: index)
    end
  end
end
