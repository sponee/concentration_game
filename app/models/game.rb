class Game < ApplicationRecord
  belongs_to :user
  has_many :cards
  after_create :generate_cards, :set_score, :set_current_player
  
  validates :user_id, presence: true
  validates :player_one_id, presence: true
  validates :player_two_id, presence: true
  validate :validate_player_uniqueness

  scope :active, -> { where(winner_id: nil) }
  scope :completed, -> { where.not(winner_id: nil)}
  
  def update_current_player
    if current_player_id == player_one_id
      update_attributes(current_player_id: player_two_id)
    elsif current_player_id == player_two_id
      update_attributes(current_player_id: player_one_id)
    end
  end

  def update_score(current_player_id)
    if current_player_id == player_one_id
      self.player_one_score += 1
    elsif current_player_id == player_two_id
      self.player_two_score += 1
    end
    save
  end

  def end_game
    if cards.matched.count >= 10 && player_one_score >= 5
        self.winner_id = player_one_id
    elsif cards.matched.count >= 10 && player_two_score >= 5
      self.winner_id = player_two_id
    end
    save
  end

  def over?
    winner_id != nil
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

  def set_score
    self.update_attributes(player_one_score: 0, player_two_score: 0)
  end

  def set_current_player
    self.update_attributes(current_player_id: player_one_id)
  end
end
